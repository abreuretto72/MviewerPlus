import 'dart:io';
import 'package:dio/dio.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:path_provider/path_provider.dart';
import '../../domain/models/cookie_entry.dart';
import '../../utils/cookie_logger.dart';

/// Serviço para gerenciar cookies HTTP usando Dio e CookieJar
class HttpCookieService {
  late Dio _dio;
  late PersistCookieJar _cookieJar;
  bool _initialized = false;

  /// Inicializa o serviço de cookies HTTP
  Future<void> initialize() async {
    if (_initialized) return;

    try {
      final appDocDir = await getApplicationDocumentsDirectory();
      final cookiePath = '${appDocDir.path}/.cookies/';

      _cookieJar = PersistCookieJar(
        storage: FileStorage(cookiePath),
      );

      _dio = Dio();
      _dio.interceptors.add(CookieManager(_cookieJar));

      _initialized = true;
    } catch (e) {
      CookieLogger.error('Erro ao inicializar HttpCookieService', e);
      rethrow;
    }
  }

  /// Garante que o serviço está inicializado
  Future<void> _ensureInitialized() async {
    if (!_initialized) {
      await initialize();
    }
  }

  /// Lista todos os cookies para uma URI específica
  Future<List<CookieEntry>> getCookiesForUri(String url) async {
    await _ensureInitialized();

    try {
      final uri = Uri.parse(url);
      final cookies = await _cookieJar.loadForRequest(uri);

      return cookies.map((cookie) {
        return CookieEntry.fromHttpCookie(cookie, CookieSource.http);
      }).toList();
    } catch (e) {
      CookieLogger.error('Erro ao obter cookies para URI', e);
      return [];
    }
  }

  /// Lista todos os cookies armazenados (todos os domínios)
  Future<List<CookieEntry>> getAllCookies() async {
    await _ensureInitialized();

    try {
      final allCookies = <CookieEntry>[];
      
      // Obtém todos os domínios armazenados
      final domains = await _getAllDomains();

      for (final domain in domains) {
        final uri = Uri.parse('https://$domain');
        final cookies = await getCookiesForUri(uri.toString());
        allCookies.addAll(cookies);
      }

      return allCookies;
    } catch (e) {
      CookieLogger.error('Erro ao obter todos os cookies', e);
      return [];
    }
  }

  /// Obtém todos os domínios que têm cookies armazenados
  Future<List<String>> _getAllDomains() async {
    try {
      final appDocDir = await getApplicationDocumentsDirectory();
      final cookiePath = '${appDocDir.path}/.cookies/';
      final cookieDir = Directory(cookiePath);

      if (!await cookieDir.exists()) {
        return [];
      }

      final domains = <String>[];
      await for (final entity in cookieDir.list()) {
        if (entity is File) {
          final fileName = entity.path.split(Platform.pathSeparator).last;
          if (fileName.endsWith('.cookie')) {
            domains.add(fileName.replaceAll('.cookie', ''));
          }
        }
      }

      return domains;
    } catch (e) {
      CookieLogger.error('Erro ao obter domínios', e);
      return [];
    }
  }

  /// Define um novo cookie
  Future<bool> setCookie({
    required String url,
    required String name,
    required String value,
    String? domain,
    String? path,
    DateTime? expires,
    bool secure = false,
    bool httpOnly = false,
  }) async {
    await _ensureInitialized();

    try {
      final uri = Uri.parse(url);
      
      final cookie = Cookie(name, value)
        ..domain = domain ?? uri.host
        ..path = path ?? '/'
        ..expires = expires
        ..secure = secure
        ..httpOnly = httpOnly;

      await _cookieJar.saveFromResponse(uri, [cookie]);
      return true;
    } catch (e) {
      CookieLogger.error('Erro ao definir cookie', e);
      return false;
    }
  }

  /// Atualiza um cookie existente
  Future<bool> updateCookie({
    required String url,
    required CookieEntry cookie,
  }) async {
    // Remove o cookie antigo
    await deleteCookie(
      url: url,
      name: cookie.name,
      domain: cookie.domain,
    );

    // Adiciona o cookie atualizado
    return await setCookie(
      url: url,
      name: cookie.name,
      value: cookie.value,
      domain: cookie.domain,
      path: cookie.path,
      expires: cookie.expires,
      secure: cookie.secure,
      httpOnly: cookie.httpOnly,
    );
  }

  /// Remove um cookie específico
  Future<bool> deleteCookie({
    required String url,
    required String name,
    String? domain,
  }) async {
    await _ensureInitialized();

    try {
      final uri = Uri.parse(url);
      final cookies = await _cookieJar.loadForRequest(uri);

      // Remove o cookie específico
      cookies.removeWhere((cookie) => cookie.name == name);

      // Salva a lista atualizada
      await _cookieJar.saveFromResponse(uri, cookies);
      return true;
    } catch (e) {
      CookieLogger.error('Erro ao deletar cookie', e);
      return false;
    }
  }

  /// Remove todos os cookies de um domínio
  Future<bool> deleteCookiesForDomain(String domain) async {
    await _ensureInitialized();

    try {
      final uri = Uri.parse('https://$domain');
      await _cookieJar.delete(uri);
      return true;
    } catch (e) {
      CookieLogger.error('Erro ao deletar cookies do domínio', e);
      return false;
    }
  }

  /// Remove todos os cookies armazenados
  Future<bool> deleteAllCookies() async {
    await _ensureInitialized();

    try {
      await _cookieJar.deleteAll();
      return true;
    } catch (e) {
      CookieLogger.error('Erro ao deletar todos os cookies', e);
      return false;
    }
  }

  /// Cria um backup dos cookies de uma URI
  Future<List<CookieEntry>> createBackup(String url) async {
    return await getCookiesForUri(url);
  }

  /// Restaura cookies de um backup
  Future<bool> restoreFromBackup({
    required String url,
    required List<CookieEntry> backup,
  }) async {
    try {
      for (final cookie in backup) {
        await setCookie(
          url: url,
          name: cookie.name,
          value: cookie.value,
          domain: cookie.domain,
          path: cookie.path,
          expires: cookie.expires,
          secure: cookie.secure,
          httpOnly: cookie.httpOnly,
        );
      }
      return true;
    } catch (e) {
      CookieLogger.error('Erro ao restaurar backup', e);
      return false;
    }
  }

  /// Exporta cookies para JSON
  Future<String> exportToJson(List<CookieEntry> cookies) async {
    final jsonList = cookies.map((c) => c.toJson()).toList();
    return jsonList.toString();
  }

  /// Obtém estatísticas dos cookies
  Future<Map<String, dynamic>> getStatistics() async {
    await _ensureInitialized();

    final allCookies = await getAllCookies();
    final domains = await _getAllDomains();

    return {
      'total_cookies': allCookies.length,
      'total_domains': domains.length,
      'secure_cookies': allCookies.where((c) => c.secure).length,
      'http_only_cookies': allCookies.where((c) => c.httpOnly).length,
      'expired_cookies': allCookies.where((c) => c.isExpired).length,
    };
  }
}
