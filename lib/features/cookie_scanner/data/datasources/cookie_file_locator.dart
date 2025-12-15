import 'dart:io';
import 'package:flutter/foundation.dart';
import '../../domain/models/cookie_file_hit.dart';

/// Localizador avançado de arquivos de cookies no sistema
/// Usa heurísticas de nome, extensão e localização
class CookieFileLocator {
  /// Padrões de nomes de arquivos de cookies (case-insensitive)
  static const List<String> cookieNamePatterns = [
    'cookie',
    'cookies',
    'cookiejar',
    'webkit',
    'webview',
    'chromium',
    'session',
    'sessions',
  ];

  /// Padrões fracos (menor prioridade)
  static const List<String> weakPatterns = [
    'auth',
    'token',
  ];

  /// Extensões comuns de arquivos de cookies
  static const List<String> cookieExtensions = [
    'db',
    'sqlite',
    'sqlite3',
    'dat',
    'bin',
    'txt',
    'json',
    'log',
  ];

  /// Diretórios Android acessíveis (sem root)
  static List<String> get androidAccessiblePaths {
    // Nota: Estes caminhos dependem de permissões
    final paths = <String>[];
    
    try {
      // Storage externo (se disponível)
      if (Platform.isAndroid) {
        final externalStorage = Directory('/storage/emulated/0');
        if (externalStorage.existsSync()) {
          paths.addAll([
            '/storage/emulated/0/Download',
            '/storage/emulated/0/Downloads',
            '/storage/emulated/0/Documents',
            '/storage/emulated/0/Android/media',
          ]);
        }
      }
    } catch (e) {
      debugPrint('[CookieFileLocator] Error getting Android paths: $e');
    }
    
    return paths;
  }

  /// Diretórios comuns de navegadores (Windows)
  static List<String> get _windowsBrowserPaths {
    final appData = Platform.environment['APPDATA'] ?? '';
    final localAppData = Platform.environment['LOCALAPPDATA'] ?? '';
    
    return [
      '$localAppData\\Google\\Chrome\\User Data\\Default',
      '$localAppData\\Google\\Chrome\\User Data\\Profile 1',
      '$localAppData\\Microsoft\\Edge\\User Data\\Default',
      '$appData\\Mozilla\\Firefox\\Profiles',
      '$localAppData\\Opera Software\\Opera Stable',
      '$localAppData\\BraveSoftware\\Brave-Browser\\User Data\\Default',
      '$localAppData\\Vivaldi\\User Data\\Default',
    ];
  }

  /// Diretórios comuns de navegadores (Linux)
  static List<String> get _linuxBrowserPaths {
    final home = Platform.environment['HOME'] ?? '';
    
    return [
      '$home/.config/google-chrome/Default',
      '$home/.config/google-chrome/Profile 1',
      '$home/.mozilla/firefox',
      '$home/.config/chromium/Default',
      '$home/.config/opera',
      '$home/.config/BraveSoftware/Brave-Browser/Default',
      '$home/.config/vivaldi/Default',
    ];
  }

  /// Diretórios comuns de navegadores (macOS)
  static List<String> get _macOsBrowserPaths {
    final home = Platform.environment['HOME'] ?? '';
    
    return [
      '$home/Library/Application Support/Google/Chrome/Default',
      '$home/Library/Application Support/Google/Chrome/Profile 1',
      '$home/Library/Application Support/Firefox/Profiles',
      '$home/Library/Application Support/Microsoft Edge/Default',
      '$home/Library/Application Support/Opera',
      '$home/Library/Application Support/BraveSoftware/Brave-Browser/Default',
      '$home/Library/Application Support/Vivaldi/Default',
      '$home/Library/Cookies',
    ];
  }

  /// Obtém os diretórios de navegadores baseado no sistema operacional
  static List<String> getBrowserDirectories() {
    if (Platform.isWindows) {
      return _windowsBrowserPaths;
    } else if (Platform.isLinux) {
      return _linuxBrowserPaths;
    } else if (Platform.isMacOS) {
      return _macOsBrowserPaths;
    } else if (Platform.isAndroid) {
      return androidAccessiblePaths;
    }
    return [];
  }

  /// Localiza arquivos de cookies nos diretórios padrão
  Future<List<CookieFileHit>> locateInDefaultPaths({
    Function(String)? onProgress,
  }) async {
    final results = <CookieFileHit>[];
    final directories = getBrowserDirectories();

    for (final dirPath in directories) {
      try {
        onProgress?.call('Scanning: $dirPath');
        
        final dir = Directory(dirPath);
        if (!await dir.exists()) continue;

        final files = await _scanDirectory(
          dir,
          onProgress: onProgress,
        );
        results.addAll(files);
      } catch (e) {
        debugPrint('[CookieFileLocator] Error scanning $dirPath: $e');
      }
    }

    return results;
  }

  /// Localiza arquivos de cookies em um diretório específico
  Future<List<CookieFileHit>> locateInDirectory(
    String path, {
    Function(String)? onProgress,
  }) async {
    try {
      final dir = Directory(path);
      if (!await dir.exists()) {
        return [];
      }

      return await _scanDirectory(
        dir,
        onProgress: onProgress,
      );
    } catch (e) {
      debugPrint('[CookieFileLocator] Error scanning $path: $e');
      return [];
    }
  }

  /// Escaneia um diretório recursivamente
  Future<List<CookieFileHit>> _scanDirectory(
    Directory dir, {
    int maxDepth = 3,
    int currentDepth = 0,
    Function(String)? onProgress,
  }) async {
    final results = <CookieFileHit>[];

    if (currentDepth >= maxDepth) return results;

    try {
      await for (final entity in dir.list()) {
        if (entity is File) {
          if (_isCookieFile(entity)) {
            try {
              final hit = CookieFileHit.fromFile(entity);
              results.add(hit);
              
              onProgress?.call('Found: ${hit.fileName}');
            } catch (e) {
              debugPrint('[CookieFileLocator] Error processing file ${entity.path}: $e');
            }
          }
        } else if (entity is Directory) {
          // Recursão em subdiretórios
          final subResults = await _scanDirectory(
            entity,
            maxDepth: maxDepth,
            currentDepth: currentDepth + 1,
            onProgress: onProgress,
          );
          results.addAll(subResults);
        }
      }
    } catch (e) {
      debugPrint('[CookieFileLocator] Error listing directory ${dir.path}: $e');
    }

    return results;
  }

  /// Verifica se um arquivo é um arquivo de cookies (heurísticas)
  bool _isCookieFile(File file) {
    final fileName = file.path.split(Platform.pathSeparator).last.toLowerCase();
    final extension = fileName.contains('.') 
        ? fileName.split('.').last
        : null;

    // Verificar por nome exato
    for (final pattern in cookieNamePatterns) {
      if (fileName == pattern.toLowerCase() ||
          fileName == '$pattern.db' ||
          fileName == '$pattern.sqlite' ||
          fileName == '$pattern.txt' ||
          fileName == '$pattern.json') {
        return true;
      }
    }

    // Verificar se o nome contém padrões fortes
    for (final pattern in cookieNamePatterns) {
      if (fileName.contains(pattern.toLowerCase())) {
        // Se contém padrão forte + extensão válida
        if (extension != null && cookieExtensions.contains(extension)) {
          return true;
        }
      }
    }

    // Verificar padrões fracos (apenas se tiver extensão válida)
    if (extension != null && cookieExtensions.contains(extension)) {
      for (final pattern in weakPatterns) {
        if (fileName.contains(pattern.toLowerCase())) {
          return true;
        }
      }
    }

    // Verificar nomes específicos conhecidos
    final knownNames = [
      'cookies',
      'cookies.db',
      'cookies.sqlite',
      'cookies.txt',
      'cookies.json',
      'cookie.db',
      'cookiejar',
      'webkit',
      'webview',
    ];

    for (final known in knownNames) {
      if (fileName == known) {
        return true;
      }
    }

    return false;
  }

  /// Busca arquivos de cookies por nome
  Future<List<CookieFileHit>> searchByName(
    String searchPath,
    String searchTerm, {
    Function(String)? onProgress,
  }) async {
    final results = <CookieFileHit>[];
    
    try {
      final dir = Directory(searchPath);
      if (!await dir.exists()) return results;

      await for (final entity in dir.list(recursive: true)) {
        if (entity is File) {
          final fileName = entity.path.split(Platform.pathSeparator).last;
          
          if (fileName.toLowerCase().contains(searchTerm.toLowerCase())) {
            if (_isCookieFile(entity)) {
              try {
                final hit = CookieFileHit.fromFile(entity);
                results.add(hit);
                
                onProgress?.call('Found: ${hit.fileName}');
              } catch (e) {
                debugPrint('[CookieFileLocator] Error processing file: $e');
              }
            }
          }
        }
      }
    } catch (e) {
      debugPrint('[CookieFileLocator] Error searching: $e');
    }

    return results;
  }

  /// Obtém estatísticas dos diretórios
  Future<Map<String, int>> getDirectoryStats() async {
    final stats = <String, int>{};
    final directories = getBrowserDirectories();

    for (final dirPath in directories) {
      try {
        final dir = Directory(dirPath);
        if (await dir.exists()) {
          final files = await _scanDirectory(dir);
          stats[dirPath] = files.length;
        } else {
          stats[dirPath] = 0;
        }
      } catch (e) {
        stats[dirPath] = -1; // Indica erro
      }
    }

    return stats;
  }

  /// Verifica se um caminho é acessível
  Future<bool> isPathAccessible(String path) async {
    try {
      final dir = Directory(path);
      return await dir.exists();
    } catch (e) {
      return false;
    }
  }

  /// Obtém sugestões de pastas para scan (Android)
  static List<String> getAndroidScanSuggestions() {
    return [
      '/storage/emulated/0/Download',
      '/storage/emulated/0/Downloads',
      '/storage/emulated/0/Documents',
      '/storage/emulated/0/Android/media',
    ];
  }

  /// Obtém aviso sobre limitações de acesso
  static String getAccessLimitationsWarning() {
    if (Platform.isAndroid) {
      return 'A varredura só acessa pastas às quais o app tem permissão. '
          'Arquivos em /data/data/ (navegadores instalados) não são acessíveis sem root.';
    } else if (Platform.isIOS) {
      return 'No iOS, apenas arquivos no sandbox do app ou importados são acessíveis. '
          'Cookies de navegadores instalados não podem ser acessados.';
    }
    
    return 'A varredura só acessa pastas às quais o app tem permissão.';
  }
}
