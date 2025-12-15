import 'dart:convert';
import 'package:crypto/crypto.dart';
import '../models/cookie_entry.dart';

/// Nível de risco de segurança do cookie
enum RiskLevel {
  none,
  low,
  medium,
  high,
}

/// Resultado da análise de segurança de um cookie
class SecurityAnalysis {
  final int riskScore;
  final RiskLevel riskLevel;
  final List<String> signals;
  final bool isSensitive;

  SecurityAnalysis({
    required this.riskScore,
    required this.riskLevel,
    required this.signals,
    required this.isSensitive,
  });

  factory SecurityAnalysis.safe() {
    return SecurityAnalysis(
      riskScore: 0,
      riskLevel: RiskLevel.none,
      signals: [],
      isSensitive: false,
    );
  }
}

/// Serviço responsável por detectar cookies sensíveis e avaliar riscos de segurança
class CookieSecurityGuard {
  // Padrões de nomes de cookies relacionados a autenticação/sessão
  static final _authPatterns = [
    'session',
    'sessid',
    'phpsessid',
    'jsessionid',
    'csrftoken',
    'xsrf',
    'auth',
    'login',
    'sid',
    'token',
  ];

  // Padrões de tokens
  static final _tokenPatterns = [
    'access_token',
    'refresh_token',
    'id_token',
    'bearer',
    'api_key',
    'apikey',
  ];

  // Padrões OAuth/OpenID
  static final _oauthPatterns = [
    'oauth',
    'openid',
    'authorize',
    'callback',
  ];

  // Padrões 2FA/MFA
  static final _mfaPatterns = [
    'otp',
    '2fa',
    'mfa',
    'totp',
    'one_time',
    'authenticator',
    'verification',
  ];

  /// Analisa um cookie e retorna a avaliação de segurança
  static SecurityAnalysis analyze(CookieEntry cookie) {
    int score = 0;
    final signals = <String>[];

    final nameLower = cookie.name.toLowerCase();
    final valueLower = cookie.value.toLowerCase();

    // Verifica padrões de autenticação/sessão
    for (final pattern in _authPatterns) {
      if (nameLower.contains(pattern)) {
        score += 30;
        signals.add('Cookie de sessão/autenticação detectado: $pattern');
        break;
      }
    }

    // Verifica padrões de tokens
    for (final pattern in _tokenPatterns) {
      if (nameLower.contains(pattern) || valueLower.contains(pattern)) {
        score += 40;
        signals.add('Token de acesso detectado: $pattern');
        break;
      }
    }

    // Verifica padrões OAuth/OpenID
    for (final pattern in _oauthPatterns) {
      if (nameLower.contains(pattern)) {
        score += 35;
        signals.add('Cookie OAuth/OpenID detectado: $pattern');
        break;
      }
    }

    // Verifica padrões 2FA/MFA
    for (final pattern in _mfaPatterns) {
      if (nameLower.contains(pattern)) {
        score += 30;
        signals.add('Cookie de autenticação multifator detectado: $pattern');
        break;
      }
    }

    // Detecta JWT (formato: xxxxx.yyyyy.zzzzz)
    if (_isJWT(cookie.value)) {
      score += 50;
      signals.add('JWT (JSON Web Token) detectado');
    }

    // Verifica alta entropia (possível token)
    final entropy = _calculateEntropy(cookie.value);
    if (entropy > 4.5 && cookie.value.length > 32) {
      score += 15;
      signals.add('Alta entropia detectada (possível token criptográfico)');
    }

    // Verifica se é Base64 longo
    if (_isLikelyBase64(cookie.value) && cookie.value.length > 40) {
      score += 10;
      signals.add('Valor codificado em Base64 detectado');
    }

    // Flags de segurança aumentam a pontuação (indicam cookie importante)
    if (cookie.httpOnly) {
      score += 10;
      signals.add('Flag httpOnly ativada (boa prática de segurança)');
    }

    if (cookie.secure) {
      score += 10;
      signals.add('Flag secure ativada (boa prática de segurança)');
    }

    // Determina o nível de risco
    final riskLevel = _determineRiskLevel(score);
    final isSensitive = score >= 40;

    return SecurityAnalysis(
      riskScore: score.clamp(0, 100),
      riskLevel: riskLevel,
      signals: signals,
      isSensitive: isSensitive,
    );
  }

  /// Verifica se o valor parece ser um JWT
  static bool _isJWT(String value) {
    // JWT tem formato: header.payload.signature
    final parts = value.split('.');
    if (parts.length != 3) return false;

    // Cada parte deve ser Base64
    return parts.every((part) => _isLikelyBase64(part));
  }

  /// Verifica se o valor parece ser Base64
  static bool _isLikelyBase64(String value) {
    if (value.isEmpty) return false;

    // Base64 usa caracteres A-Z, a-z, 0-9, +, /, =
    final base64Regex = RegExp(r'^[A-Za-z0-9+/]+=*$');
    return base64Regex.hasMatch(value);
  }

  /// Calcula a entropia de Shannon de uma string
  /// Valores mais altos indicam maior aleatoriedade (típico de tokens)
  static double _calculateEntropy(String value) {
    if (value.isEmpty) return 0.0;

    final frequencies = <String, int>{};
    for (int i = 0; i < value.length; i++) {
      final char = value[i];
      frequencies[char] = (frequencies[char] ?? 0) + 1;
    }

    double entropy = 0.0;
    final length = value.length;

    for (final count in frequencies.values) {
      final probability = count / length;
      entropy -= probability * (probability > 0 ? (probability * 3.321928094887362) : 0); // log2
    }

    return entropy;
  }

  /// Determina o nível de risco baseado na pontuação
  static RiskLevel _determineRiskLevel(int score) {
    if (score >= 70) return RiskLevel.high;
    if (score >= 40) return RiskLevel.medium;
    if (score >= 20) return RiskLevel.low;
    return RiskLevel.none;
  }

  /// Retorna a cor associada ao nível de risco
  static String getRiskColor(RiskLevel level) {
    switch (level) {
      case RiskLevel.high:
        return '#D32F2F'; // Vermelho
      case RiskLevel.medium:
        return '#F57C00'; // Laranja
      case RiskLevel.low:
        return '#FBC02D'; // Amarelo
      case RiskLevel.none:
        return '#388E3C'; // Verde
    }
  }

  /// Retorna o ícone associado ao nível de risco
  static String getRiskIcon(RiskLevel level) {
    switch (level) {
      case RiskLevel.high:
        return '🔴';
      case RiskLevel.medium:
        return '🟠';
      case RiskLevel.low:
        return '🟡';
      case RiskLevel.none:
        return '🟢';
    }
  }

  /// Retorna a descrição do nível de risco
  static String getRiskDescription(RiskLevel level) {
    switch (level) {
      case RiskLevel.high:
        return 'Alto Risco - Cookie crítico de autenticação';
      case RiskLevel.medium:
        return 'Risco Médio - Cookie sensível';
      case RiskLevel.low:
        return 'Risco Baixo - Cookie potencialmente importante';
      case RiskLevel.none:
        return 'Sem Risco - Cookie comum';
    }
  }
}
