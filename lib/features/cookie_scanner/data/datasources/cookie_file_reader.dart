import 'dart:io';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import '../../domain/models/cookie_file_hit.dart';

/// Leitor de conteúdo de arquivos de cookies
/// Lê apenas amostras para classificação rápida
class CookieFileReader {
  /// Tamanho padrão da amostra (64 KB)
  static const int defaultSampleSize = 64 * 1024;

  /// Tamanho para leitura profunda (512 KB)
  static const int deepScanSize = 512 * 1024;

  /// Lê amostra do arquivo para classificação rápida
  Future<String> readSample(
    CookieFileHit file, {
    int sampleSize = defaultSampleSize,
  }) async {
    try {
      final fileObj = File(file.path);
      
      if (!await fileObj.exists()) {
        return '';
      }

      // Ler apenas a amostra
      final bytes = await fileObj.openRead(0, sampleSize).toList();
      final flatBytes = bytes.expand((x) => x).toList();

      // Tentar decodificar como texto
      try {
        return utf8.decode(flatBytes, allowMalformed: true);
      } catch (e) {
        // Se falhar, retornar representação hex dos primeiros bytes
        return _bytesToHexString(flatBytes.take(1024).toList());
      }
    } catch (e) {
      debugPrint('[CookieFileReader] Error reading sample: $e');
      return '';
    }
  }

  /// Lê arquivo completo (com limite de segurança)
  Future<String> readFull(
    CookieFileHit file, {
    int maxSize = deepScanSize,
  }) async {
    try {
      final fileObj = File(file.path);
      
      if (!await fileObj.exists()) {
        return '';
      }

      // Verificar tamanho
      final fileSize = await fileObj.length();
      final readSize = fileSize > maxSize ? maxSize : fileSize;

      // Ler arquivo
      final bytes = await fileObj.openRead(0, readSize).toList();
      final flatBytes = bytes.expand((x) => x).toList();

      // Tentar decodificar
      try {
        return utf8.decode(flatBytes, allowMalformed: true);
      } catch (e) {
        return _bytesToHexString(flatBytes.take(2048).toList());
      }
    } catch (e) {
      debugPrint('[CookieFileReader] Error reading full file: $e');
      return '';
    }
  }

  /// Lê metadados estruturados do arquivo
  Future<Map<String, dynamic>> readMetadata(CookieFileHit file) async {
    try {
      final fileObj = File(file.path);
      
      if (!await fileObj.exists()) {
        return {'error': 'File not found'};
      }

      // Ler amostra
      final sample = await readSample(file);

      // Detectar tipo baseado no conteúdo
      final detectedType = _detectContentType(sample);

      return {
        'type': detectedType,
        'size': file.sizeBytes,
        'sample_size': sample.length,
        'is_binary': _isBinary(sample),
        'has_sqlite_signature': sample.contains('SQLite format 3'),
        'preview': sample.substring(0, sample.length > 200 ? 200 : sample.length),
      };
    } catch (e) {
      debugPrint('[CookieFileReader] Error reading metadata: $e');
      return {'error': e.toString()};
    }
  }

  /// Verifica se o arquivo é legível
  Future<bool> isReadable(CookieFileHit file) async {
    try {
      final fileObj = File(file.path);
      return await fileObj.exists();
    } catch (e) {
      return false;
    }
  }

  /// Detecta tipo de conteúdo
  String _detectContentType(String content) {
    if (content.isEmpty) return 'empty';
    
    if (content.contains('SQLite format 3')) {
      return 'sqlite';
    }
    
    if (content.startsWith('{') || content.startsWith('[')) {
      return 'json';
    }
    
    if (content.contains('Set-Cookie:') || content.contains('Cookie:')) {
      return 'http_dump';
    }
    
    if (content.contains('NSHTTPCookie') || content.contains('WebKit')) {
      return 'webkit';
    }
    
    if (_isBinary(content)) {
      return 'binary';
    }
    
    return 'text';
  }

  /// Verifica se o conteúdo é binário
  bool _isBinary(String content) {
    if (content.isEmpty) return false;
    
    // Verificar se tem muitos caracteres não-imprimíveis
    int nonPrintable = 0;
    for (int i = 0; i < content.length && i < 1000; i++) {
      final code = content.codeUnitAt(i);
      if (code < 32 && code != 9 && code != 10 && code != 13) {
        nonPrintable++;
      }
    }
    
    return nonPrintable > (content.length * 0.3);
  }

  /// Converte bytes para string hexadecimal
  String _bytesToHexString(List<int> bytes) {
    return bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join(' ');
  }

  /// Lê múltiplos arquivos em batch
  Future<Map<CookieFileHit, String>> readMultipleSamples(
    List<CookieFileHit> files, {
    int sampleSize = defaultSampleSize,
    Function(int, int)? onProgress,
  }) async {
    final results = <CookieFileHit, String>{};
    
    for (int i = 0; i < files.length; i++) {
      final sample = await readSample(files[i], sampleSize: sampleSize);
      results[files[i]] = sample;
      
      if (onProgress != null) {
        onProgress(i + 1, files.length);
      }
    }
    
    return results;
  }
}
