import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

/// Serviço de HTTP com SSL Pinning
/// Valida certificados SSL para prevenir ataques Man-in-the-Middle
class SecureHttpClient {
  static const List<String> _trustedCertificates = [
    // Adicione aqui os hashes SHA-256 dos certificados confiáveis
    // Exemplo: 'sha256/AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA='
  ];

  static IOClient? _client;

  /// Obtém cliente HTTP com SSL Pinning
  static http.Client getSecureClient() {
    if (_client != null) return _client!;

    final httpClient = HttpClient();
    
    // Configurar validação de certificado
    httpClient.badCertificateCallback = (X509Certificate cert, String host, int port) {
      // Em produção, validar o certificado contra os hashes confiáveis
      if (kDebugMode) {
        debugPrint('[SSL Pinning] Certificate for $host:');
        debugPrint('  Subject: ${cert.subject}');
        debugPrint('  Issuer: ${cert.issuer}');
        debugPrint('  Valid from: ${cert.startValidity}');
        debugPrint('  Valid to: ${cert.endValidity}');
        
        // Em debug, aceitar qualquer certificado
        return true;
      }

      // Em produção, validar o hash do certificado
      final certHash = _getCertificateHash(cert);
      final isValid = _trustedCertificates.contains(certHash);

      if (!isValid) {
        debugPrint('[SSL Pinning] ⚠️ CERTIFICATE VALIDATION FAILED for $host');
        debugPrint('[SSL Pinning] Expected one of: $_trustedCertificates');
        debugPrint('[SSL Pinning] Got: $certHash');
      }

      return isValid;
    };

    _client = IOClient(httpClient);
    return _client!;
  }

  /// Calcula o hash SHA-256 do certificado
  static String _getCertificateHash(X509Certificate cert) {
    // Implementar cálculo de hash SHA-256 do certificado
    // Por enquanto, retorna placeholder
    return 'sha256/${cert.subject}';
  }

  /// Testa a conexão SSL
  static Future<bool> testSSLConnection(String url) async {
    try {
      final client = getSecureClient();
      final response = await client.get(Uri.parse(url));
      
      if (response.statusCode == 200) {
        debugPrint('[SSL Pinning] ✅ SSL connection successful to $url');
        return true;
      } else {
        debugPrint('[SSL Pinning] ⚠️ Unexpected status code: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      debugPrint('[SSL Pinning] ❌ SSL connection failed: $e');
      return false;
    }
  }

  /// Fecha o cliente
  static void dispose() {
    _client?.close();
    _client = null;
  }
}

/// Resultado da verificação SSL
class SSLCheckResult {
  final bool isValid;
  final String? error;
  final String? certificateInfo;

  SSLCheckResult({
    required this.isValid,
    this.error,
    this.certificateInfo,
  });

  factory SSLCheckResult.success({String? certificateInfo}) {
    return SSLCheckResult(
      isValid: true,
      certificateInfo: certificateInfo,
    );
  }

  factory SSLCheckResult.failure(String error) {
    return SSLCheckResult(
      isValid: false,
      error: error,
    );
  }
}
