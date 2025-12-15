import 'dart:isolate';
import 'package:flutter/foundation.dart';
import '../../domain/models/cookie_file_hit.dart';
import '../../domain/models/cookie_scan_result.dart';
import '../../domain/models/cookie_risk_result.dart';
import '../../domain/risk/cookie_risk_guard.dart';
import '../datasources/cookie_file_locator.dart';
import '../datasources/cookie_file_reader.dart';

/// Serviço que executa varredura de cookies em isolate separado
/// Com suporte a progresso, cancelamento e deep scan
class CookieScanIsolateService {
  /// Executa varredura em isolate com progresso
  static Future<CookieScanResult> scanInIsolate({
    List<String>? customPaths,
    bool deepScan = false,
    Function(double, String)? onProgress,
    Future<bool> Function()? shouldCancel,
  }) async {
    final receivePort = ReceivePort();
    
    try {
      await Isolate.spawn(
        _scanWorker,
        _ScanMessage(
          sendPort: receivePort.sendPort,
          customPaths: customPaths,
          deepScan: deepScan,
        ),
      );

      // Escutar mensagens do isolate
      await for (final message in receivePort) {
        if (message is _ProgressMessage) {
          onProgress?.call(message.progress, message.status);
        } else if (message is CookieScanResult) {
          receivePort.close();
          return message;
        } else if (message is _ErrorMessage) {
          receivePort.close();
          return CookieScanResult.empty().copyWith(
            status: ScanStatus.failed,
            errors: [message.error],
          );
        }
      }

      // Se chegou aqui, algo deu errado
      return CookieScanResult.empty().copyWith(
        status: ScanStatus.failed,
        errors: ['Isolate terminated unexpectedly'],
      );
    } catch (e) {
      debugPrint('[CookieScanIsolateService] Error: $e');
      return CookieScanResult.empty().copyWith(
        status: ScanStatus.failed,
        errors: [e.toString()],
      );
    }
  }

  /// Worker que roda no isolate
  static Future<void> _scanWorker(_ScanMessage message) async {
    final startTime = DateTime.now();
    final locator = CookieFileLocator();
    final reader = CookieFileReader();
    final errors = <String>[];
    
    try {
      // Fase 1: Localizar arquivos (30% do progresso)
      message.sendPort.send(_ProgressMessage(0.1, 'Iniciando varredura...'));
      
      List<CookieFileHit> files;
      if (message.customPaths != null && message.customPaths!.isNotEmpty) {
        files = [];
        for (final path in message.customPaths!) {
          final pathFiles = await locator.locateInDirectory(
            path,
            onProgress: (status) {
              message.sendPort.send(_ProgressMessage(0.2, status));
            },
          );
          files.addAll(pathFiles);
        }
      } else {
        files = await locator.locateInDefaultPaths(
          onProgress: (status) {
            message.sendPort.send(_ProgressMessage(0.2, status));
          },
        );
      }

      message.sendPort.send(_ProgressMessage(0.3, 'Encontrados ${files.length} arquivos'));

      if (files.isEmpty) {
        final result = CookieScanResult(
          scanStartTime: startTime,
          scanEndTime: DateTime.now(),
          filesFound: [],
          scannedPaths: message.customPaths ?? CookieFileLocator.getBrowserDirectories(),
          totalFilesScanned: 0,
          errors: errors,
          status: ScanStatus.completed,
        );
        message.sendPort.send(result);
        return;
      }

      // Fase 2: Ler conteúdo (40% do progresso)
      message.sendPort.send(_ProgressMessage(0.4, 'Analisando conteúdo...'));
      
      final filesWithContent = <CookieFileHit, String>{};
      
      if (message.deepScan) {
        // Deep scan: ler mais conteúdo
        for (int i = 0; i < files.length; i++) {
          try {
            final content = await reader.readFull(files[i]);
            filesWithContent[files[i]] = content;
            
            final progress = 0.4 + (0.3 * (i + 1) / files.length);
            message.sendPort.send(_ProgressMessage(
              progress,
              'Leitura profunda: ${i + 1}/${files.length}',
            ));
          } catch (e) {
            errors.add('Error reading ${files[i].fileName}: $e');
          }
        }
      } else {
        // Quick scan: ler apenas amostra
        for (int i = 0; i < files.length; i++) {
          try {
            final content = await reader.readSample(files[i]);
            filesWithContent[files[i]] = content;
            
            final progress = 0.4 + (0.3 * (i + 1) / files.length);
            message.sendPort.send(_ProgressMessage(
              progress,
              'Leitura rápida: ${i + 1}/${files.length}',
            ));
          } catch (e) {
            errors.add('Error reading ${files[i].fileName}: $e');
          }
        }
      }

      // Fase 3: Análise de risco (30% do progresso)
      message.sendPort.send(_ProgressMessage(0.7, 'Analisando riscos...'));
      
      final riskResults = CookieRiskGuard.analyzeMultipleWithContent(filesWithContent);
      
      // Filtrar apenas cookie files reais
      final cookieFiles = riskResults
          .where((r) => r.metadata['is_cookie_file'] == true)
          .map((r) => r.file)
          .toList();

      message.sendPort.send(_ProgressMessage(0.9, 'Finalizando...'));

      // Criar resultado final
      final result = CookieScanResult(
        scanStartTime: startTime,
        scanEndTime: DateTime.now(),
        filesFound: cookieFiles,
        scannedPaths: message.customPaths ?? CookieFileLocator.getBrowserDirectories(),
        totalFilesScanned: files.length,
        errors: errors,
        status: ScanStatus.completed,
      );

      message.sendPort.send(_ProgressMessage(1.0, 'Concluído!'));
      message.sendPort.send(result);
    } catch (e) {
      message.sendPort.send(_ErrorMessage(e.toString()));
    }
  }

  /// Analisa riscos em isolate (com conteúdo)
  static Future<List<CookieRiskResult>> analyzeRisksInIsolate(
    Map<CookieFileHit, String> filesWithContent, {
    Function(double)? onProgress,
  }) async {
    return await compute(_analyzeRisksWorker, filesWithContent);
  }

  static List<CookieRiskResult> _analyzeRisksWorker(
    Map<CookieFileHit, String> filesWithContent,
  ) {
    return CookieRiskGuard.analyzeMultipleWithContent(filesWithContent);
  }
}

/// Mensagem para o isolate
class _ScanMessage {
  final SendPort sendPort;
  final List<String>? customPaths;
  final bool deepScan;

  _ScanMessage({
    required this.sendPort,
    this.customPaths,
    this.deepScan = false,
  });
}

/// Mensagem de progresso
class _ProgressMessage {
  final double progress; // 0.0 a 1.0
  final String status;

  _ProgressMessage(this.progress, this.status);
}

/// Mensagem de erro
class _ErrorMessage {
  final String error;

  _ErrorMessage(this.error);
}
