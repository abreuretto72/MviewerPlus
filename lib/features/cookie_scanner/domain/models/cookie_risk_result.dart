import 'cookie_file_hit.dart';

/// Resultado da análise de risco de um arquivo de cookie
class CookieRiskResult {
  final CookieFileHit file;
  final int riskScore;
  final RiskLevel riskLevel;
  final List<RiskSignal> signals;
  final DateTime analyzedAt;
  final Map<String, dynamic> metadata;

  CookieRiskResult({
    required this.file,
    required this.riskScore,
    required this.riskLevel,
    required this.signals,
    required this.analyzedAt,
    this.metadata = const {},
  });

  /// Cria um resultado sem risco
  factory CookieRiskResult.safe(CookieFileHit file) {
    return CookieRiskResult(
      file: file,
      riskScore: 0,
      riskLevel: RiskLevel.none,
      signals: [],
      analyzedAt: DateTime.now(),
    );
  }

  /// Verifica se o arquivo é considerado de risco
  bool get isRisky => riskLevel != RiskLevel.none;

  /// Verifica se é alto risco
  bool get isHighRisk => riskLevel == RiskLevel.high || riskLevel == RiskLevel.critical;

  /// Retorna a cor associada ao nível de risco
  String get riskColor {
    switch (riskLevel) {
      case RiskLevel.none:
        return '#4CAF50'; // Verde
      case RiskLevel.low:
        return '#FFC107'; // Amarelo
      case RiskLevel.medium:
        return '#FF9800'; // Laranja
      case RiskLevel.high:
        return '#F44336'; // Vermelho
      case RiskLevel.critical:
        return '#B71C1C'; // Vermelho escuro
    }
  }

  /// Retorna o ícone associado ao nível de risco
  String get riskIcon {
    switch (riskLevel) {
      case RiskLevel.none:
        return '✅';
      case RiskLevel.low:
        return '⚠️';
      case RiskLevel.medium:
        return '🟠';
      case RiskLevel.high:
        return '🔴';
      case RiskLevel.critical:
        return '🚨';
    }
  }

  /// Retorna a descrição do nível de risco
  String get riskDescription {
    switch (riskLevel) {
      case RiskLevel.none:
        return 'Sem risco detectado';
      case RiskLevel.low:
        return 'Risco baixo';
      case RiskLevel.medium:
        return 'Risco médio - Requer atenção';
      case RiskLevel.high:
        return 'Alto risco - Ação recomendada';
      case RiskLevel.critical:
        return 'CRÍTICO - Ação imediata necessária';
    }
  }

  /// Agrupa sinais por categoria
  Map<RiskCategory, List<RiskSignal>> get signalsByCategory {
    final Map<RiskCategory, List<RiskSignal>> grouped = {};
    
    for (final signal in signals) {
      grouped.putIfAbsent(signal.category, () => []).add(signal);
    }
    
    return grouped;
  }

  /// Retorna os sinais mais críticos
  List<RiskSignal> get criticalSignals {
    return signals.where((s) => s.severity >= 70).toList()
      ..sort((a, b) => b.severity.compareTo(a.severity));
  }

  Map<String, dynamic> toJson() {
    return {
      'file': file.toJson(),
      'riskScore': riskScore,
      'riskLevel': riskLevel.name,
      'signals': signals.map((s) => s.toJson()).toList(),
      'analyzedAt': analyzedAt.toIso8601String(),
      'metadata': metadata,
    };
  }

  factory CookieRiskResult.fromJson(Map<String, dynamic> json) {
    return CookieRiskResult(
      file: CookieFileHit.fromJson(json['file']),
      riskScore: json['riskScore'],
      riskLevel: RiskLevel.values.firstWhere(
        (e) => e.name == json['riskLevel'],
        orElse: () => RiskLevel.none,
      ),
      signals: (json['signals'] as List)
          .map((s) => RiskSignal.fromJson(s))
          .toList(),
      analyzedAt: DateTime.parse(json['analyzedAt']),
      metadata: Map<String, dynamic>.from(json['metadata'] ?? {}),
    );
  }

  @override
  String toString() {
    return 'CookieRiskResult(file: ${file.fileName}, level: ${riskLevel.name}, score: $riskScore)';
  }
}

/// Níveis de risco
enum RiskLevel {
  none,      // 0-19
  low,       // 20-39
  medium,    // 40-59
  high,      // 60-79
  critical,  // 80-100
}

/// Sinal de risco detectado
class RiskSignal {
  final String id;
  final String title;
  final String description;
  final RiskCategory category;
  final int severity; // 0-100
  final String? recommendation;

  RiskSignal({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.severity,
    this.recommendation,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category.name,
      'severity': severity,
      'recommendation': recommendation,
    };
  }

  factory RiskSignal.fromJson(Map<String, dynamic> json) {
    return RiskSignal(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      category: RiskCategory.values.firstWhere(
        (e) => e.name == json['category'],
        orElse: () => RiskCategory.other,
      ),
      severity: json['severity'],
      recommendation: json['recommendation'],
    );
  }

  @override
  String toString() {
    return 'RiskSignal(id: $id, severity: $severity, category: ${category.name})';
  }
}

/// Categorias de risco
enum RiskCategory {
  size,          // Tamanho anormal do arquivo
  age,           // Arquivo muito antigo ou muito recente
  location,      // Localização suspeita
  permissions,   // Permissões inadequadas
  modification,  // Modificações recentes suspeitas
  content,       // Conteúdo potencialmente perigoso
  browser,       // Relacionado ao navegador
  other,         // Outros riscos
}
