import 'cookie_file_hit.dart';

/// Resultado de uma varredura de cookies
class CookieScanResult {
  final DateTime scanStartTime;
  final DateTime scanEndTime;
  final List<CookieFileHit> filesFound;
  final List<String> scannedPaths;
  final int totalFilesScanned;
  final List<String> errors;
  final ScanStatus status;

  CookieScanResult({
    required this.scanStartTime,
    required this.scanEndTime,
    required this.filesFound,
    required this.scannedPaths,
    required this.totalFilesScanned,
    required this.errors,
    required this.status,
  });

  /// Cria um resultado vazio
  factory CookieScanResult.empty() {
    final now = DateTime.now();
    return CookieScanResult(
      scanStartTime: now,
      scanEndTime: now,
      filesFound: [],
      scannedPaths: [],
      totalFilesScanned: 0,
      errors: [],
      status: ScanStatus.idle,
    );
  }

  /// Cria um resultado em progresso
  factory CookieScanResult.inProgress({
    required DateTime startTime,
    required List<String> scannedPaths,
    required int totalScanned,
  }) {
    return CookieScanResult(
      scanStartTime: startTime,
      scanEndTime: DateTime.now(),
      filesFound: [],
      scannedPaths: scannedPaths,
      totalFilesScanned: totalScanned,
      errors: [],
      status: ScanStatus.scanning,
    );
  }

  /// Duração da varredura
  Duration get scanDuration => scanEndTime.difference(scanStartTime);

  /// Número de arquivos de cookies encontrados
  int get cookieFilesCount => filesFound.length;

  /// Agrupa arquivos por navegador
  Map<String, List<CookieFileHit>> get filesByBrowser {
    final Map<String, List<CookieFileHit>> grouped = {};
    
    for (final file in filesFound) {
      final browser = file.browserName ?? 'Unknown';
      grouped.putIfAbsent(browser, () => []).add(file);
    }
    
    return grouped;
  }

  /// Agrupa arquivos por tipo
  Map<CookieFileType, List<CookieFileHit>> get filesByType {
    final Map<CookieFileType, List<CookieFileHit>> grouped = {};
    
    for (final file in filesFound) {
      grouped.putIfAbsent(file.type, () => []).add(file);
    }
    
    return grouped;
  }

  /// Tamanho total dos arquivos encontrados
  int get totalSizeBytes {
    return filesFound.fold(0, (sum, file) => sum + file.sizeBytes);
  }

  /// Tamanho total formatado
  String get formattedTotalSize {
    if (totalSizeBytes < 1024) return '$totalSizeBytes B';
    if (totalSizeBytes < 1024 * 1024) {
      return '${(totalSizeBytes / 1024).toStringAsFixed(2)} KB';
    }
    return '${(totalSizeBytes / (1024 * 1024)).toStringAsFixed(2)} MB';
  }

  /// Verifica se há erros
  bool get hasErrors => errors.isNotEmpty;

  /// Verifica se a varredura foi bem-sucedida
  bool get isSuccessful => status == ScanStatus.completed && !hasErrors;

  /// Cria uma cópia com valores atualizados
  CookieScanResult copyWith({
    DateTime? scanStartTime,
    DateTime? scanEndTime,
    List<CookieFileHit>? filesFound,
    List<String>? scannedPaths,
    int? totalFilesScanned,
    List<String>? errors,
    ScanStatus? status,
  }) {
    return CookieScanResult(
      scanStartTime: scanStartTime ?? this.scanStartTime,
      scanEndTime: scanEndTime ?? this.scanEndTime,
      filesFound: filesFound ?? this.filesFound,
      scannedPaths: scannedPaths ?? this.scannedPaths,
      totalFilesScanned: totalFilesScanned ?? this.totalFilesScanned,
      errors: errors ?? this.errors,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'scanStartTime': scanStartTime.toIso8601String(),
      'scanEndTime': scanEndTime.toIso8601String(),
      'filesFound': filesFound.map((f) => f.toJson()).toList(),
      'scannedPaths': scannedPaths,
      'totalFilesScanned': totalFilesScanned,
      'errors': errors,
      'status': status.name,
    };
  }

  factory CookieScanResult.fromJson(Map<String, dynamic> json) {
    return CookieScanResult(
      scanStartTime: DateTime.tryParse(json['scanStartTime']) ?? DateTime.now(),
      scanEndTime: DateTime.tryParse(json['scanEndTime']) ?? DateTime.now(),
      filesFound: (json['filesFound'] as List)
          .map((f) => CookieFileHit.fromJson(f))
          .toList(),
      scannedPaths: List<String>.from(json['scannedPaths']),
      totalFilesScanned: json['totalFilesScanned'],
      errors: List<String>.from(json['errors']),
      status: ScanStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => ScanStatus.idle,
      ),
    );
  }

  @override
  String toString() {
    return 'CookieScanResult(found: $cookieFilesCount, scanned: $totalFilesScanned, status: ${status.name})';
  }
}

/// Status da varredura
enum ScanStatus {
  idle,       // Não iniciada
  scanning,   // Em andamento
  completed,  // Concluída com sucesso
  failed,     // Falhou
  cancelled,  // Cancelada pelo usuário
}
