import 'dart:io';

/// Representa um arquivo de cookie encontrado no sistema
class CookieFileHit {
  final String path;
  final String fileName;
  final int sizeBytes;
  final DateTime lastModified;
  final String? extension;
  final CookieFileType type;
  final String? browserName;
  
  CookieFileHit({
    required this.path,
    required this.fileName,
    required this.sizeBytes,
    required this.lastModified,
    this.extension,
    required this.type,
    this.browserName,
  });

  /// Cria um CookieFileHit a partir de um File
  factory CookieFileHit.fromFile(
    File file, {
    CookieFileType? type,
    String? browserName,
  }) {
    final stat = file.statSync();
    final fileName = file.path.split(Platform.pathSeparator).last;
    final extension = fileName.contains('.') 
        ? fileName.split('.').last.toLowerCase()
        : null;

    return CookieFileHit(
      path: file.path,
      fileName: fileName,
      sizeBytes: stat.size,
      lastModified: stat.modified,
      extension: extension,
      type: type ?? _detectType(fileName, extension),
      browserName: browserName ?? _detectBrowser(file.path),
    );
  }

  /// Detecta o tipo de arquivo de cookie
  static CookieFileType _detectType(String fileName, String? extension) {
    final nameLower = fileName.toLowerCase();
    
    // SQLite databases (Chrome, Firefox, Edge)
    if (extension == 'sqlite' || 
        nameLower == 'cookies' || 
        nameLower.contains('cookies.db')) {
      return CookieFileType.sqlite;
    }
    
    // Text-based cookies
    if (extension == 'txt' || nameLower.contains('cookies.txt')) {
      return CookieFileType.text;
    }
    
    // JSON cookies
    if (extension == 'json' || nameLower.contains('cookies.json')) {
      return CookieFileType.json;
    }
    
    // Binary/proprietary
    if (extension == 'dat' || extension == 'bin') {
      return CookieFileType.binary;
    }
    
    return CookieFileType.unknown;
  }

  /// Detecta o navegador baseado no caminho
  static String? _detectBrowser(String path) {
    final pathLower = path.toLowerCase();
    
    if (pathLower.contains('chrome')) return 'Chrome';
    if (pathLower.contains('firefox')) return 'Firefox';
    if (pathLower.contains('edge')) return 'Edge';
    if (pathLower.contains('opera')) return 'Opera';
    if (pathLower.contains('brave')) return 'Brave';
    if (pathLower.contains('safari')) return 'Safari';
    if (pathLower.contains('vivaldi')) return 'Vivaldi';
    
    return null;
  }

  /// Retorna o tamanho formatado
  String get formattedSize {
    if (sizeBytes < 1024) return '$sizeBytes B';
    if (sizeBytes < 1024 * 1024) {
      return '${(sizeBytes / 1024).toStringAsFixed(2)} KB';
    }
    return '${(sizeBytes / (1024 * 1024)).toStringAsFixed(2)} MB';
  }

  /// Retorna o ícone apropriado para o tipo
  String get typeIcon {
    switch (type) {
      case CookieFileType.sqlite:
        return '🗄️';
      case CookieFileType.text:
        return '📄';
      case CookieFileType.json:
        return '📋';
      case CookieFileType.binary:
        return '💾';
      case CookieFileType.unknown:
        return '❓';
    }
  }

  /// Retorna o ícone do navegador
  String get browserIcon {
    if (browserName == null) return '🌐';
    
    switch (browserName!.toLowerCase()) {
      case 'chrome':
        return '🔵';
      case 'firefox':
        return '🦊';
      case 'edge':
        return '🔷';
      case 'opera':
        return '🔴';
      case 'brave':
        return '🦁';
      case 'safari':
        return '🧭';
      default:
        return '🌐';
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'path': path,
      'fileName': fileName,
      'sizeBytes': sizeBytes,
      'lastModified': lastModified.toIso8601String(),
      'extension': extension,
      'type': type.name,
      'browserName': browserName,
    };
  }

  factory CookieFileHit.fromJson(Map<String, dynamic> json) {
    return CookieFileHit(
      path: json['path'],
      fileName: json['fileName'],
      sizeBytes: json['sizeBytes'],
      lastModified: DateTime.tryParse(json['lastModified']) ?? DateTime.now(),
      extension: json['extension'],
      type: CookieFileType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => CookieFileType.unknown,
      ),
      browserName: json['browserName'],
    );
  }

  @override
  String toString() {
    return 'CookieFileHit(fileName: $fileName, type: ${type.name}, browser: $browserName)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CookieFileHit && other.path == path;
  }

  @override
  int get hashCode => path.hashCode;
}

/// Tipos de arquivos de cookies
enum CookieFileType {
  sqlite,   // Chrome, Firefox, Edge (SQLite database)
  text,     // Netscape format (cookies.txt)
  json,     // JSON format
  binary,   // Binary/proprietary format
  unknown,  // Unknown format
}
