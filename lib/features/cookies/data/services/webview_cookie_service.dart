import 'package:webview_flutter/webview_flutter.dart';
import '../../domain/models/cookie_entry.dart';
import '../../utils/cookie_logger.dart';

/// Serviço para gerenciar cookies do WebView
class WebViewCookieService {
  final WebViewCookieManager _cookieManager = WebViewCookieManager();

  /// Lista todos os cookies de um domínio específico via JavaScript
  /// Nota: Cookies httpOnly não serão visíveis via JavaScript
  Future<List<CookieEntry>> getCookiesFromJavaScript(
    WebViewController controller,
    String url,
  ) async {
    try {
      // Injeta JavaScript para ler document.cookie
      final result = await controller.runJavaScriptReturningResult(
        'document.cookie',
      );

      final cookieString = result.toString().replaceAll('"', '');
      
      if (cookieString.isEmpty || cookieString == 'null') {
        return [];
      }

      final cookies = <CookieEntry>[];
      final pairs = cookieString.split(';');

      final uri = Uri.parse(url);
      final domain = uri.host;

      for (final pair in pairs) {
        final trimmed = pair.trim();
        if (trimmed.isEmpty) continue;

        final separatorIndex = trimmed.indexOf('=');
        if (separatorIndex == -1) continue;

        final name = trimmed.substring(0, separatorIndex).trim();
        final value = trimmed.substring(separatorIndex + 1).trim();

        cookies.add(CookieEntry.fromWebView(
          name: name,
          value: value,
          domain: domain,
        ));
      }

      return cookies;
    } catch (e) {
      CookieLogger.error('Erro ao obter cookies via JavaScript', e);
      return [];
    }
  }

  /// Define um cookie no WebView
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
    try {
      final uri = Uri.parse(url);
      
      final cookie = WebViewCookie(
        name: name,
        value: value,
        domain: domain ?? uri.host,
        path: path ?? '/',
      );

      await _cookieManager.setCookie(cookie);
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
    try {
      final uri = Uri.parse(url);
      
      // Define o cookie com data de expiração no passado para removê-lo
      final cookie = WebViewCookie(
        name: name,
        value: '',
        domain: domain ?? uri.host,
        path: '/',
      );

      await _cookieManager.setCookie(cookie);
      return true;
    } catch (e) {
      CookieLogger.error('Erro ao deletar cookie', e);
      return false;
    }
  }

  /// Remove todos os cookies do WebView
  Future<bool> clearAllCookies() async {
    try {
      final result = await _cookieManager.clearCookies();
      return result;
    } catch (e) {
      CookieLogger.error('Erro ao limpar todos os cookies', e);
      return false;
    }
  }

  /// Verifica se há suporte para cookies
  static Future<bool> hasCookieSupport() async {
    try {
      // Tenta acessar o cookie manager
      final manager = WebViewCookieManager();
      await manager.clearCookies();
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Cria um backup dos cookies antes de modificações
  Future<List<CookieEntry>> createBackup(
    WebViewController controller,
    String url,
  ) async {
    return await getCookiesFromJavaScript(controller, url);
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

  /// Obtém informações sobre limitações do WebView
  String getLimitationsWarning() {
    return 'Aviso: Cookies com flags httpOnly e secure podem não ser visíveis '
        'através do JavaScript. Para visualizar todos os cookies, use ferramentas '
        'de desenvolvedor do navegador ou acesse via HTTP Cookie Manager.';
  }
}
