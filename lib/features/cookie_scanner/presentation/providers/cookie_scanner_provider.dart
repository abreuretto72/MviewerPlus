import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:io';
import '../../data/datasources/cookie_file_locator.dart';
import '../../data/datasources/cookie_file_reader.dart';
import '../../data/services/cookie_scan_isolate_service.dart';
import '../../domain/models/cookie_file_hit.dart';
import '../../domain/models/cookie_scan_result.dart';
import '../../domain/models/cookie_risk_result.dart';
import '../../domain/risk/cookie_risk_guard.dart';

/// Provider para gerenciar o estado do Cookie Scanner v2.0
class CookieScannerProvider extends ChangeNotifier {
  final CookieFileLocator _locator = CookieFileLocator();
  final CookieFileReader _reader = CookieFileReader();

  CookieScanResult _lastScanResult = CookieScanResult.empty();
  Map<CookieFileHit, CookieRiskResult> _riskResults = {};
  Map<CookieFileHit, String> _contentCache = {};
  
  bool _isScanning = false;
  String? _error;
  double _progress = 0.0;
  String _progressStatus = '';
  bool _deepScan = false;
  String _selectedScope = 'default'; // 'default', 'downloads', 'documents', 'custom'
  String? _customPath;

  // Getters
  CookieScanResult get lastScanResult => _lastScanResult;
  Map<CookieFileHit, CookieRiskResult> get riskResults => _riskResults;
  bool get isScanning => _isScanning;
  String? get error => _error;
  double get progress => _progress;
  String get progressStatus => _progressStatus;
  bool get deepScan => _deepScan;
  String get selectedScope => _selectedScope;
  String? get customPath => _customPath;
  
  List<CookieFileHit> get foundFiles => _lastScanResult.filesFound;
  int get totalFilesFound => foundFiles.length;
  bool get hasResults => foundFiles.isNotEmpty;

  /// Define se deve usar deep scan
  void setDeepScan(bool value) {
    _deepScan = value;
    notifyListeners();
  }

  /// Define o escopo da varredura
  void setScope(String scope, {String? customPath}) {
    _selectedScope = scope;
    _customPath = customPath;
    notifyListeners();
  }

  /// Inicia varredura de cookies
  Future<void> startScan() async {
    _isScanning = true;
    _error = null;
    _progress = 0.0;
    _progressStatus = 'Iniciando...';
    notifyListeners();

    try {
      // Determinar caminhos baseado no escopo
      List<String>? paths;
      
      switch (_selectedScope) {
        case 'downloads':
          if (Platform.isAndroid) {
            paths = ['/storage/emulated/0/Download', '/storage/emulated/0/Downloads'];
          }
          break;
        case 'documents':
          if (Platform.isAndroid) {
            paths = ['/storage/emulated/0/Documents'];
          }
          break;
        case 'custom':
          if (_customPath != null) {
            paths = [_customPath!];
          }
          break;
        default:
          paths = null; // Usar caminhos padrão
      }

      // Executar varredura em isolate
      _lastScanResult = await CookieScanIsolateService.scanInIsolate(
        customPaths: paths,
        deepScan: _deepScan,
        onProgress: (progress, status) {
          _progress = progress;
          _progressStatus = status;
          notifyListeners();
        },
      );

      // Ler conteúdo dos arquivos encontrados
      if (_lastScanResult.filesFound.isNotEmpty) {
        _progressStatus = 'Lendo conteúdo...';
        notifyListeners();

        _contentCache = await _reader.readMultipleSamples(
          _lastScanResult.filesFound,
          sampleSize: _deepScan ? CookieFileReader.deepScanSize : CookieFileReader.defaultSampleSize,
          onProgress: (current, total) {
            _progress = 0.8 + (0.1 * current / total);
            _progressStatus = 'Lendo arquivo $current/$total';
            notifyListeners();
          },
        );

        // Analisar riscos
        _progressStatus = 'Analisando riscos...';
        _progress = 0.9;
        notifyListeners();

        final results = CookieRiskGuard.analyzeMultipleWithContent(_contentCache);
        
        _riskResults = {};
        for (final result in results) {
          _riskResults[result.file] = result;
        }
      }

      _progress = 1.0;
      _progressStatus = 'Concluído!';
      _error = null;

      // Salvar histórico
      await _saveToHistory();
    } catch (e) {
      _error = 'Erro durante varredura: $e';
      debugPrint('[CookieScannerProvider] $e');
    } finally {
      _isScanning = false;
      notifyListeners();
    }
  }

  /// Cancela varredura em andamento
  void cancelScan() {
    if (_isScanning) {
      _isScanning = false;
      _error = 'Varredura cancelada pelo usuário';
      _lastScanResult = _lastScanResult.copyWith(
        status: ScanStatus.cancelled,
      );
      notifyListeners();
    }
  }

  /// Obtém resultado de risco para um arquivo
  CookieRiskResult? getRiskResult(CookieFileHit file) {
    return _riskResults[file];
  }

  /// Obtém conteúdo em cache de um arquivo
  String? getCachedContent(CookieFileHit file) {
    return _contentCache[file];
  }

  /// Filtra arquivos por nível de risco
  List<CookieFileHit> filterByRiskLevel(RiskLevel minLevel) {
    final filtered = CookieRiskGuard.filterByRiskLevel(
      _riskResults.values.toList(),
      minLevel,
    );
    return filtered.map((r) => r.file).toList();
  }

  /// Filtra arquivos por palavra-chave
  List<CookieFileHit> filterByKeyword(String keyword) {
    if (keyword.isEmpty) return foundFiles;
    
    final keywordLower = keyword.toLowerCase();
    return foundFiles.where((file) {
      return file.fileName.toLowerCase().contains(keywordLower) ||
             file.path.toLowerCase().contains(keywordLower);
    }).toList();
  }

  /// Lê conteúdo completo de um arquivo
  Future<String> readFullContent(CookieFileHit file) async {
    // Verificar cache primeiro
    if (_contentCache.containsKey(file)) {
      return _contentCache[file]!;
    }

    // Ler do disco
    final content = await _reader.readFull(file);
    _contentCache[file] = content;
    
    return content;
  }

  /// Gera relatório de risco
  String generateRiskReport() {
    return CookieRiskGuard.generateReport(_riskResults.values.toList());
  }

  /// Limpa resultados
  void clearResults() {
    _lastScanResult = CookieScanResult.empty();
    _riskResults = {};
    _contentCache = {};
    _error = null;
    _progress = 0.0;
    _progressStatus = '';
    notifyListeners();
  }

  /// Obtém estatísticas
  Map<String, dynamic> getStatistics() {
    final byBrowser = _lastScanResult.filesByBrowser;
    final byType = _lastScanResult.filesByType;
    
    final riskCounts = <RiskLevel, int>{};
    for (final result in _riskResults.values) {
      riskCounts[result.riskLevel] = (riskCounts[result.riskLevel] ?? 0) + 1;
    }

    // Detecções específicas
    final jwtCount = _riskResults.values.where((r) => 
      r.signals.any((s) => s.id == 'jwt_detected')
    ).length;
    
    final oauthCount = _riskResults.values.where((r) => 
      r.signals.any((s) => s.id == 'oauth_tokens')
    ).length;
    
    final chromiumCount = _riskResults.values.where((r) => 
      r.signals.any((s) => s.id == 'chromium_structure')
    ).length;

    return {
      'total_files': totalFilesFound,
      'total_size': _lastScanResult.formattedTotalSize,
      'scan_duration': _lastScanResult.scanDuration.inSeconds,
      'deep_scan': _deepScan,
      'scope': _selectedScope,
      'browsers': byBrowser.keys.toList(),
      'browser_counts': byBrowser.map((k, v) => MapEntry(k, v.length)),
      'type_counts': byType.map((k, v) => MapEntry(k.name, v.length)),
      'risk_counts': riskCounts.map((k, v) => MapEntry(k.name, v)),
      'jwt_detections': jwtCount,
      'oauth_detections': oauthCount,
      'chromium_dbs': chromiumCount,
    };
  }

  /// Salva scan no histórico
  Future<void> _saveToHistory() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      
      final history = {
        'timestamp': DateTime.now().toIso8601String(),
        'scope': _selectedScope,
        'deep_scan': _deepScan,
        'files_found': totalFilesFound,
        'duration_seconds': _lastScanResult.scanDuration.inSeconds,
        'high_risk_count': filterByRiskLevel(RiskLevel.high).length,
      };

      await prefs.setString('last_cookie_scan', jsonEncode(history));
    } catch (e) {
      debugPrint('[CookieScannerProvider] Error saving history: $e');
    }
  }

  /// Carrega último scan do histórico
  Future<Map<String, dynamic>?> loadLastScanHistory() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final historyJson = prefs.getString('last_cookie_scan');
      
      if (historyJson != null) {
        return jsonDecode(historyJson);
      }
    } catch (e) {
      debugPrint('[CookieScannerProvider] Error loading history: $e');
    }
    
    return null;
  }

  /// Obtém aviso de limitações
  String getAccessLimitationsWarning() {
    return CookieFileLocator.getAccessLimitationsWarning();
  }
}
