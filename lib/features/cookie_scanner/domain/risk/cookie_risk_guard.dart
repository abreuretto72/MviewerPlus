import '../models/cookie_file_hit.dart';
import '../models/cookie_risk_result.dart';
import 'cookie_risk_rules.dart';

/// Guarda de segurança que analisa riscos de arquivos de cookies
/// Usa padrões reais de Chromium, WebKit, JWT e OAuth
class CookieRiskGuard {
  /// Analisa um arquivo de cookie com conteúdo (amostra)
  static CookieRiskResult analyzeWithContent(
    CookieFileHit file,
    String contentSample,
  ) {
    final signals = <RiskSignal>[];

    // ========================================================================
    // GRUPO A: Confirmação de "Cookie Store" (Estrutura)
    // ========================================================================
    
    final sqliteSignal = CookieRiskRules.checkSQLiteSignature(contentSample);
    if (sqliteSignal != null) signals.add(sqliteSignal);

    final tableSignal = CookieRiskRules.checkCookieTables(contentSample);
    if (tableSignal != null) signals.add(tableSignal);

    final chromiumSignal = CookieRiskRules.checkChromiumColumns(contentSample);
    if (chromiumSignal != null) signals.add(chromiumSignal);

    final encryptedSignal = CookieRiskRules.checkEncryptedValues(contentSample);
    if (encryptedSignal != null) signals.add(encryptedSignal);

    // ========================================================================
    // GRUPO B: Cookie de Sessão/Autenticação
    // ========================================================================
    
    final sessionSignal = CookieRiskRules.checkSessionPatterns(contentSample);
    if (sessionSignal != null) signals.add(sessionSignal);

    // ========================================================================
    // GRUPO C: Flags de Segurança
    // ========================================================================
    
    final flagsSignal = CookieRiskRules.checkSecurityFlags(contentSample);
    if (flagsSignal != null) signals.add(flagsSignal);

    final headersSignal = CookieRiskRules.checkHTTPHeaders(contentSample);
    if (headersSignal != null) signals.add(headersSignal);

    // ========================================================================
    // GRUPO D: Tokens
    // ========================================================================
    
    final jwtSignal = CookieRiskRules.checkJWTTokens(contentSample);
    if (jwtSignal != null) signals.add(jwtSignal);

    final oauthSignal = CookieRiskRules.checkOAuthTokens(contentSample);
    if (oauthSignal != null) signals.add(oauthSignal);

    final entropySignal = CookieRiskRules.checkHighEntropy(contentSample);
    if (entropySignal != null) signals.add(entropySignal);

    // ========================================================================
    // PADRÕES WEBKIT
    // ========================================================================
    
    final webkitSignal = CookieRiskRules.checkWebKitPatterns(contentSample);
    if (webkitSignal != null) signals.add(webkitSignal);

    // ========================================================================
    // CÁLCULO FINAL
    // ========================================================================
    
    // Verificar se é realmente um cookie file
    if (!CookieRiskRules.isLikelyCookieFile(signals)) {
      // Não é um cookie file, retornar risco baixo
      return CookieRiskResult(
        file: file,
        riskScore: 0,
        riskLevel: RiskLevel.none,
        signals: [],
        analyzedAt: DateTime.now(),
        metadata: {
          'is_cookie_file': false,
          'reason': 'Insufficient cookie-related signals',
        },
      );
    }

    // Calcular score final
    final riskScore = CookieRiskRules.calculateFinalScore(signals);
    final riskLevel = _determineRiskLevel(riskScore);

    // Obter motivo principal
    final primaryReason = CookieRiskRules.getPrimaryReason(signals);

    // Metadados
    final metadata = {
      'is_cookie_file': true,
      'primary_reason': primaryReason,
      'total_signals': signals.length,
      'categories': signals.map((s) => s.category.name).toSet().toList(),
      'max_severity': signals.isEmpty
          ? 0
          : signals.map((s) => s.severity).reduce((a, b) => a > b ? a : b),
      'content_sample_size': contentSample.length,
    };

    return CookieRiskResult(
      file: file,
      riskScore: riskScore,
      riskLevel: riskLevel,
      signals: signals,
      analyzedAt: DateTime.now(),
      metadata: metadata,
    );
  }

  /// Analisa um arquivo sem conteúdo (apenas metadados)
  static CookieRiskResult analyzeWithoutContent(CookieFileHit file) {
    // Análise básica sem conteúdo
    return CookieRiskResult(
      file: file,
      riskScore: 0,
      riskLevel: RiskLevel.none,
      signals: [],
      analyzedAt: DateTime.now(),
      metadata: {
        'analyzed_with_content': false,
        'note': 'Run deep scan to analyze file content',
      },
    );
  }

  /// Analisa múltiplos arquivos com conteúdo
  static List<CookieRiskResult> analyzeMultipleWithContent(
    Map<CookieFileHit, String> filesWithContent,
  ) {
    final results = <CookieRiskResult>[];

    for (final entry in filesWithContent.entries) {
      results.add(analyzeWithContent(entry.key, entry.value));
    }

    return results;
  }

  /// Determina o nível de risco baseado na pontuação
  static RiskLevel _determineRiskLevel(int score) {
    if (score >= 80) return RiskLevel.critical;
    if (score >= 60) return RiskLevel.high;
    if (score >= 40) return RiskLevel.medium;
    if (score >= 20) return RiskLevel.low;
    return RiskLevel.none;
  }

  /// Gera um relatório de risco em texto
  static String generateReport(List<CookieRiskResult> results) {
    final buffer = StringBuffer();
    buffer.writeln('=== COOKIE SCANNER RISK REPORT ===\n');
    buffer.writeln('Generated: ${DateTime.now()}\n');

    // Filtrar apenas cookie files reais
    final cookieFiles = results.where((r) {
      return r.metadata['is_cookie_file'] == true;
    }).toList();

    // Estatísticas gerais
    final totalFiles = cookieFiles.length;
    final criticalCount = cookieFiles.where((r) => r.riskLevel == RiskLevel.critical).length;
    final highCount = cookieFiles.where((r) => r.riskLevel == RiskLevel.high).length;
    final mediumCount = cookieFiles.where((r) => r.riskLevel == RiskLevel.medium).length;
    final lowCount = cookieFiles.where((r) => r.riskLevel == RiskLevel.low).length;
    final safeCount = cookieFiles.where((r) => r.riskLevel == RiskLevel.none).length;

    buffer.writeln('SUMMARY:');
    buffer.writeln('Cookie Files Found: $totalFiles');
    buffer.writeln('🚨 Critical Risk: $criticalCount');
    buffer.writeln('🔴 High Risk: $highCount');
    buffer.writeln('🟠 Medium Risk: $mediumCount');
    buffer.writeln('🟡 Low Risk: $lowCount');
    buffer.writeln('✅ Safe: $safeCount');
    buffer.writeln();

    // Arquivos de alto risco
    final highRiskFiles = cookieFiles.where((r) => r.isHighRisk).toList();
    if (highRiskFiles.isNotEmpty) {
      buffer.writeln('HIGH RISK COOKIE FILES:');
      for (final result in highRiskFiles) {
        buffer.writeln('  ${result.riskIcon} ${result.file.fileName}');
        buffer.writeln('     Score: ${result.riskScore}/100');
        buffer.writeln('     Reason: ${result.metadata['primary_reason']}');
        buffer.writeln('     Location: ${result.file.path}');
        
        if (result.criticalSignals.isNotEmpty) {
          buffer.writeln('     Critical Signals:');
          for (final signal in result.criticalSignals) {
            buffer.writeln('       - ${signal.title}');
            if (signal.recommendation != null) {
              buffer.writeln('         → ${signal.recommendation}');
            }
          }
        }
        buffer.writeln();
      }
    }

    // Detecções específicas
    final jwtFiles = cookieFiles.where((r) => 
      r.signals.any((s) => s.id == 'jwt_detected')
    ).length;
    
    final oauthFiles = cookieFiles.where((r) => 
      r.signals.any((s) => s.id == 'oauth_tokens')
    ).length;
    
    final chromiumFiles = cookieFiles.where((r) => 
      r.signals.any((s) => s.id == 'chromium_structure')
    ).length;

    if (jwtFiles > 0 || oauthFiles > 0 || chromiumFiles > 0) {
      buffer.writeln('SPECIFIC DETECTIONS:');
      if (jwtFiles > 0) buffer.writeln('  JWT Tokens: $jwtFiles files');
      if (oauthFiles > 0) buffer.writeln('  OAuth Tokens: $oauthFiles files');
      if (chromiumFiles > 0) buffer.writeln('  Chromium Cookie DBs: $chromiumFiles files');
      buffer.writeln();
    }

    // Recomendações gerais
    if (criticalCount > 0 || highCount > 0) {
      buffer.writeln('⚠️  URGENT RECOMMENDATIONS:');
      buffer.writeln('  • Review and secure high-risk cookie files immediately');
      buffer.writeln('  • Delete or encrypt files containing JWT/OAuth tokens');
      buffer.writeln('  • Move cookie databases to secure locations');
      buffer.writeln('  • Clear old browser cookies regularly');
      buffer.writeln('  • Enable device encryption if not already enabled');
    }

    return buffer.toString();
  }

  /// Filtra resultados por nível de risco
  static List<CookieRiskResult> filterByRiskLevel(
    List<CookieRiskResult> results,
    RiskLevel minLevel,
  ) {
    final levelIndex = RiskLevel.values.indexOf(minLevel);
    return results.where((r) {
      final resultIndex = RiskLevel.values.indexOf(r.riskLevel);
      return resultIndex >= levelIndex;
    }).toList();
  }

  /// Ordena resultados por risco (maior primeiro)
  static List<CookieRiskResult> sortByRisk(
    List<CookieRiskResult> results,
  ) {
    final sorted = List<CookieRiskResult>.from(results);
    sorted.sort((a, b) => b.riskScore.compareTo(a.riskScore));
    return sorted;
  }

  /// Filtra apenas cookie files reais
  static List<CookieRiskResult> filterCookieFilesOnly(
    List<CookieRiskResult> results,
  ) {
    return results.where((r) {
      return r.metadata['is_cookie_file'] == true;
    }).toList();
  }
}
