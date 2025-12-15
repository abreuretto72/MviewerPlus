import '../models/cookie_risk_result.dart';

/// Regras avançadas de análise de risco para arquivos de cookies
/// Baseadas em padrões reais de Chromium, WebKit e estruturas de sessão
class CookieRiskRules {
  // ============================================================================
  // GRUPO A: Confirmação de "Cookie Store" (Estrutura)
  // ============================================================================

  /// Assinatura SQLite
  static const String sqliteSignature = 'SQLite format 3';

  /// Tabelas típicas de cookies
  static const List<String> cookieTables = ['cookies', 'meta'];

  /// Colunas típicas da tabela cookies (Chromium/WebView)
  static const List<String> chromiumCookieColumns = [
    'host_key',
    'name',
    'value',
    'path',
    'expires_utc',
    'is_secure',
    'is_httponly',
    'last_access_utc',
    'has_expires',
    'is_persistent',
    'priority',
    'samesite',
    'source_scheme',
    'source_port',
    'encrypted_value',
    'creation_utc',
  ];

  /// Colunas relacionadas a criptografia (muito forte)
  static const List<String> encryptionColumns = [
    'encrypted_value',
    'value',
  ];

  /// Strings de criação de tabela
  static const List<String> sqliteCreateStatements = [
    'CREATE TABLE cookies',
    'INSERT INTO "cookies"',
  ];

  // ============================================================================
  // GRUPO B: Cookie de Sessão/Autenticação
  // ============================================================================

  /// Padrões de sessão
  static const List<String> sessionPatterns = [
    'sessionid',
    'sid',
    'JSESSIONID',
    'PHPSESSID',
    'csrftoken',
    'XSRF-TOKEN',
    'xsrf',
    'auth',
    'token',
  ];

  // ============================================================================
  // GRUPO C: Flags de Segurança
  // ============================================================================

  /// Flags de segurança HTTP
  static const List<String> securityFlags = [
    'HttpOnly',
    'Secure',
    'SameSite',
  ];

  /// Headers HTTP de cookies
  static const List<String> httpCookieHeaders = [
    'Set-Cookie:',
    'Cookie:',
  ];

  // ============================================================================
  // GRUPO D: Tokens
  // ============================================================================

  /// Padrões de tokens OAuth/JWT
  static const List<String> tokenPatterns = [
    'access_token',
    'refresh_token',
    'id_token',
    'bearer',
  ];

  /// Regex para JWT (eyJ... . ... . ...)
  static final RegExp jwtPattern = RegExp(
    r'eyJ[A-Za-z0-9_-]+\.eyJ[A-Za-z0-9_-]+\.[A-Za-z0-9_-]+',
  );

  // ============================================================================
  // PADRÕES WEBKIT (iOS/Safari)
  // ============================================================================

  /// Assinaturas WebKit
  static const List<String> webkitPatterns = [
    'NSHTTPCookie',
    'HTTPCookieStorage',
    'Cookies.binarycookies',
    'WebKit',
    'WKWebsiteDataStore',
  ];

  // ============================================================================
  // REGRAS DE PONTUAÇÃO
  // ============================================================================

  /// Verifica assinatura SQLite no conteúdo
  static RiskSignal? checkSQLiteSignature(String content) {
    if (content.contains(sqliteSignature)) {
      return RiskSignal(
        id: 'sqlite_signature',
        title: 'Banco SQLite Detectado',
        description: 'Arquivo contém assinatura SQLite format 3. '
            'Provavelmente é um banco de dados de cookies.',
        category: RiskCategory.content,
        severity: 25,
        recommendation: 'Verificar se contém dados sensíveis de cookies.',
      );
    }
    return null;
  }

  /// Verifica tabelas de cookies
  static RiskSignal? checkCookieTables(String content) {
    final contentLower = content.toLowerCase();
    
    for (final table in cookieTables) {
      if (contentLower.contains(table)) {
        return RiskSignal(
          id: 'cookie_table',
          title: 'Tabela de Cookies Detectada',
          description: 'Encontrada tabela "$table" típica de armazenamento de cookies.',
          category: RiskCategory.content,
          severity: 20,
        );
      }
    }
    return null;
  }

  /// Verifica colunas típicas do Chromium
  static RiskSignal? checkChromiumColumns(String content) {
    final contentLower = content.toLowerCase();
    int matchCount = 0;
    final foundColumns = <String>[];

    for (final column in chromiumCookieColumns) {
      if (contentLower.contains(column.toLowerCase())) {
        matchCount++;
        foundColumns.add(column);
      }
    }

    if (matchCount >= 2) {
      return RiskSignal(
        id: 'chromium_structure',
        title: 'Estrutura Chromium/WebView Detectada',
        description: 'Encontradas $matchCount colunas típicas de cookies do Chromium: '
            '${foundColumns.take(5).join(", ")}. '
            'Este é MUITO PROVAVELMENTE um banco de cookies real.',
        category: RiskCategory.content,
        severity: 40,
        recommendation: 'ALTO RISCO: Contém estrutura completa de cookies.',
      );
    }

    return null;
  }

  /// Verifica colunas de criptografia
  static RiskSignal? checkEncryptedValues(String content) {
    final contentLower = content.toLowerCase();
    
    if (contentLower.contains('encrypted_value')) {
      return RiskSignal(
        id: 'encrypted_cookies',
        title: 'Cookies Criptografados Detectados',
        description: 'Encontrada coluna "encrypted_value". '
            'Indica cookies criptografados do Chrome/Edge.',
        category: RiskCategory.content,
        severity: 35,
        recommendation: 'CRÍTICO: Cookies podem conter dados de autenticação criptografados.',
      );
    }

    return null;
  }

  /// Verifica padrões de sessão
  static RiskSignal? checkSessionPatterns(String content) {
    final contentLower = content.toLowerCase();
    final foundPatterns = <String>[];

    for (final pattern in sessionPatterns) {
      if (contentLower.contains(pattern.toLowerCase())) {
        foundPatterns.add(pattern);
      }
    }

    if (foundPatterns.isNotEmpty) {
      return RiskSignal(
        id: 'session_detected',
        title: 'Cookie de Sessão/Autenticação Detectado',
        description: 'Encontrados padrões de sessão: ${foundPatterns.join(", ")}. '
            'Estes cookies geralmente contêm tokens de autenticação.',
        category: RiskCategory.content,
        severity: 30,
        recommendation: 'ATENÇÃO: Cookies de sessão podem permitir acesso não autorizado.',
      );
    }

    return null;
  }

  /// Verifica flags de segurança HTTP
  static RiskSignal? checkSecurityFlags(String content) {
    int flagCount = 0;
    final foundFlags = <String>[];

    for (final flag in securityFlags) {
      if (content.contains(flag)) {
        flagCount++;
        foundFlags.add(flag);
      }
    }

    if (flagCount > 0) {
      final severity = flagCount == 3 ? 30 : flagCount * 10;
      
      return RiskSignal(
        id: 'security_flags',
        title: 'Flags de Segurança HTTP Encontradas',
        description: 'Encontradas flags: ${foundFlags.join(", ")}. '
            'Indica cookies com configurações de segurança.',
        category: RiskCategory.content,
        severity: severity,
        recommendation: flagCount == 3
            ? 'Cookies bem configurados com todas as flags de segurança.'
            : 'Cookies com algumas flags de segurança.',
      );
    }

    return null;
  }

  /// Verifica headers HTTP de cookies
  static RiskSignal? checkHTTPHeaders(String content) {
    for (final header in httpCookieHeaders) {
      if (content.contains(header)) {
        return RiskSignal(
          id: 'http_headers',
          title: 'Headers HTTP de Cookies Detectados',
          description: 'Encontrado header "$header". '
              'Arquivo pode conter dump de tráfego HTTP com cookies.',
          category: RiskCategory.content,
          severity: 25,
        );
      }
    }
    return null;
  }

  /// Verifica tokens JWT
  static RiskSignal? checkJWTTokens(String content) {
    if (jwtPattern.hasMatch(content)) {
      return RiskSignal(
        id: 'jwt_detected',
        title: '🚨 JWT (JSON Web Token) DETECTADO',
        description: 'Encontrado token JWT no formato eyJ...eyJ...signature. '
            'JWTs geralmente contêm informações de autenticação e autorização.',
        category: RiskCategory.content,
        severity: 50,
        recommendation: 'CRÍTICO: JWT pode permitir acesso completo à conta do usuário!',
      );
    }
    return null;
  }

  /// Verifica tokens OAuth
  static RiskSignal? checkOAuthTokens(String content) {
    final contentLower = content.toLowerCase();
    final foundTokens = <String>[];

    for (final pattern in tokenPatterns) {
      if (contentLower.contains(pattern.toLowerCase())) {
        foundTokens.add(pattern);
      }
    }

    if (foundTokens.isNotEmpty) {
      return RiskSignal(
        id: 'oauth_tokens',
        title: '🚨 Tokens OAuth/API DETECTADOS',
        description: 'Encontrados tokens: ${foundTokens.join(", ")}. '
            'Estes são tokens de autenticação de APIs.',
        category: RiskCategory.content,
        severity: 40,
        recommendation: 'CRÍTICO: Tokens OAuth podem dar acesso total a APIs!',
      );
    }

    return null;
  }

  /// Verifica padrões WebKit (iOS/Safari)
  static RiskSignal? checkWebKitPatterns(String content) {
    for (final pattern in webkitPatterns) {
      if (content.contains(pattern)) {
        return RiskSignal(
          id: 'webkit_detected',
          title: 'Estrutura WebKit/Safari Detectada',
          description: 'Encontrado padrão "$pattern". '
              'Indica cookies do Safari ou WKWebView (iOS).',
          category: RiskCategory.content,
          severity: 30,
        );
      }
    }
    return null;
  }

  /// Verifica alta entropia (base64/hex longos)
  static RiskSignal? checkHighEntropy(String content) {
    // Procura por strings longas de base64 ou hex
    final base64Pattern = RegExp(r'[A-Za-z0-9+/=]{40,}');
    final hexPattern = RegExp(r'[0-9a-fA-F]{40,}');

    if (base64Pattern.hasMatch(content) || hexPattern.hasMatch(content)) {
      return RiskSignal(
        id: 'high_entropy',
        title: 'Alta Entropia Detectada',
        description: 'Encontradas strings longas em base64 ou hexadecimal. '
            'Podem ser tokens criptográficos ou dados codificados.',
        category: RiskCategory.content,
        severity: 15,
      );
    }

    return null;
  }

  /// Calcula score final baseado em múltiplos sinais
  static int calculateFinalScore(List<RiskSignal> signals) {
    if (signals.isEmpty) return 0;

    // Soma total das severidades
    int totalSeverity = signals.fold(0, (sum, signal) => sum + signal.severity);

    // Média ponderada
    int baseScore = (totalSeverity / signals.length).round();

    // Bônus por combinações perigosas
    final hasJWT = signals.any((s) => s.id == 'jwt_detected');
    final hasOAuth = signals.any((s) => s.id == 'oauth_tokens');
    final hasChromium = signals.any((s) => s.id == 'chromium_structure');
    final hasSession = signals.any((s) => s.id == 'session_detected');
    final hasEncrypted = signals.any((s) => s.id == 'encrypted_cookies');

    // Upgrade forçado
    if (hasJWT || hasOAuth) {
      baseScore = baseScore < 60 ? 60 : baseScore; // Mínimo High
    }

    if (hasChromium && hasSession) {
      baseScore = baseScore < 70 ? 70 : baseScore; // Quase sempre Critical
    }

    if (hasChromium && hasEncrypted && hasSession) {
      baseScore = baseScore < 80 ? 80 : baseScore; // Critical garantido
    }

    return baseScore.clamp(0, 100);
  }

  /// Determina o motivo principal (para exibição)
  static String getPrimaryReason(List<RiskSignal> signals) {
    // Prioridade de exibição
    if (signals.any((s) => s.id == 'jwt_detected')) {
      return 'Tokens (JWT/OAuth) detectados em cookies';
    }
    if (signals.any((s) => s.id == 'oauth_tokens')) {
      return 'Tokens (JWT/OAuth) detectados em cookies';
    }
    if (signals.any((s) => s.id == 'chromium_structure')) {
      return 'Banco de cookies (SQLite/Chromium) detectado';
    }
    if (signals.any((s) => s.id == 'session_detected')) {
      return 'Cookie de sessão/autenticação detectado';
    }
    if (signals.any((s) => s.id == 'security_flags')) {
      return 'Flags Secure/HttpOnly/SameSite encontradas';
    }
    if (signals.any((s) => s.id == 'high_entropy')) {
      return 'Alta entropia (possível token)';
    }
    if (signals.any((s) => s.id == 'sqlite_signature')) {
      return 'Banco SQLite detectado';
    }

    return 'Arquivo de cookies detectado';
  }

  /// Verifica se é realmente um cookie file (anti-falso-positivo)
  static bool isLikelyCookieFile(List<RiskSignal> signals) {
    // Só considerar "cookie DB" se:
    final hasSQLite = signals.any((s) => s.id == 'sqlite_signature');
    final hasCookieTable = signals.any((s) => s.id == 'cookie_table');
    final hasChromium = signals.any((s) => s.id == 'chromium_structure');
    final hasEncrypted = signals.any((s) => s.id == 'encrypted_cookies');
    final hasSession = signals.any((s) => s.id == 'session_detected');
    final hasHTTPHeaders = signals.any((s) => s.id == 'http_headers');

    // SQLite + (cookies table + 2+ colunas) OU (host_key + expires_utc)
    if (hasSQLite && (hasCookieTable || hasChromium)) {
      return true;
    }

    // Encrypted value + httponly/secure
    if (hasEncrypted && signals.any((s) => s.id == 'security_flags')) {
      return true;
    }

    // Session + HTTP headers
    if (hasSession && hasHTTPHeaders) {
      return true;
    }

    // JWT ou OAuth sempre é cookie-related
    if (signals.any((s) => s.id == 'jwt_detected' || s.id == 'oauth_tokens')) {
      return true;
    }

    // Se tem menos de 2 sinais, provavelmente não é cookie file
    return signals.length >= 2;
  }
}
