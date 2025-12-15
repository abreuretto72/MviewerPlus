import 'package:flutter/foundation.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../data/services/webview_cookie_service.dart';
import '../../data/services/http_cookie_service.dart';
import '../../data/services/auth_service.dart';
import '../../data/services/cookie_export_service.dart';
import '../../domain/models/cookie_entry.dart';
import '../../domain/security/cookie_security_guard.dart';

/// Provider para gerenciar o estado do Cookie Inspector
class CookieInspectorProvider extends ChangeNotifier {
  final WebViewCookieService _webViewService = WebViewCookieService();
  final HttpCookieService _httpService = HttpCookieService();
  final AuthService _authService = AuthService();
  final CookieExportService _exportService = CookieExportService();

  List<CookieEntry> _webViewCookies = [];
  List<CookieEntry> _httpCookies = [];
  bool _isLoading = false;
  String? _error;
  String _currentUrl = '';
  Map<String, SecurityAnalysis> _securityCache = {};

  // Getters
  List<CookieEntry> get webViewCookies => _webViewCookies;
  List<CookieEntry> get httpCookies => _httpCookies;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String get currentUrl => _currentUrl;

  /// Inicializa o provider
  Future<void> initialize() async {
    try {
      await _httpService.initialize();
    } catch (e) {
      _error = 'Erro ao inicializar serviços: $e';
      notifyListeners();
    }
  }

  /// Carrega cookies do WebView
  Future<void> loadWebViewCookies({
    required WebViewController controller,
    required String url,
  }) async {
    _setLoading(true);
    _currentUrl = url;

    try {
      _webViewCookies = await _webViewService.getCookiesFromJavaScript(
        controller,
        url,
      );
      _error = null;
      _updateSecurityCache(_webViewCookies);
    } catch (e) {
      _error = 'Erro ao carregar cookies do WebView: $e';
      _webViewCookies = [];
    } finally {
      _setLoading(false);
    }
  }

  /// Carrega cookies HTTP
  Future<void> loadHttpCookies(String url) async {
    _setLoading(true);
    _currentUrl = url;

    try {
      _httpCookies = await _httpService.getCookiesForUri(url);
      _error = null;
      _updateSecurityCache(_httpCookies);
    } catch (e) {
      _error = 'Erro ao carregar cookies HTTP: $e';
      _httpCookies = [];
    } finally {
      _setLoading(false);
    }
  }

  /// Carrega todos os cookies HTTP (todos os domínios)
  Future<void> loadAllHttpCookies() async {
    _setLoading(true);

    try {
      _httpCookies = await _httpService.getAllCookies();
      _error = null;
      _updateSecurityCache(_httpCookies);
    } catch (e) {
      _error = 'Erro ao carregar todos os cookies HTTP: $e';
      _httpCookies = [];
    } finally {
      _setLoading(false);
    }
  }

  /// Adiciona ou atualiza um cookie do WebView
  Future<bool> setWebViewCookie({
    required String url,
    required CookieEntry cookie,
  }) async {
    final success = await _webViewService.setCookie(
      url: url,
      name: cookie.name,
      value: cookie.value,
      domain: cookie.domain,
      path: cookie.path,
      expires: cookie.expires,
      secure: cookie.secure,
      httpOnly: cookie.httpOnly,
    );

    if (success) {
      notifyListeners();
    }

    return success;
  }

  /// Adiciona ou atualiza um cookie HTTP
  Future<bool> setHttpCookie({
    required String url,
    required CookieEntry cookie,
  }) async {
    final success = await _httpService.setCookie(
      url: url,
      name: cookie.name,
      value: cookie.value,
      domain: cookie.domain,
      path: cookie.path,
      expires: cookie.expires,
      secure: cookie.secure,
      httpOnly: cookie.httpOnly,
    );

    if (success) {
      notifyListeners();
    }

    return success;
  }

  /// Exclui um cookie do WebView
  Future<bool> deleteWebViewCookie({
    required String url,
    required String name,
    String? domain,
  }) async {
    final success = await _webViewService.deleteCookie(
      url: url,
      name: name,
      domain: domain,
    );

    if (success) {
      _webViewCookies.removeWhere((c) => c.name == name);
      notifyListeners();
    }

    return success;
  }

  /// Exclui um cookie HTTP
  Future<bool> deleteHttpCookie({
    required String url,
    required String name,
    String? domain,
  }) async {
    final success = await _httpService.deleteCookie(
      url: url,
      name: name,
      domain: domain,
    );

    if (success) {
      _httpCookies.removeWhere((c) => c.name == name);
      notifyListeners();
    }

    return success;
  }

  /// Limpa todos os cookies do WebView
  Future<bool> clearAllWebViewCookies() async {
    final success = await _webViewService.clearAllCookies();

    if (success) {
      _webViewCookies.clear();
      notifyListeners();
    }

    return success;
  }

  /// Limpa todos os cookies HTTP
  Future<bool> clearAllHttpCookies() async {
    final success = await _httpService.deleteAllCookies();

    if (success) {
      _httpCookies.clear();
      notifyListeners();
    }

    return success;
  }

  /// Obtém análise de segurança de um cookie (com cache)
  SecurityAnalysis getSecurityAnalysis(CookieEntry cookie) {
    final key = '${cookie.name}_${cookie.domain}';
    
    if (_securityCache.containsKey(key)) {
      return _securityCache[key]!;
    }

    final analysis = CookieSecurityGuard.analyze(cookie);
    _securityCache[key] = analysis;
    return analysis;
  }

  /// Atualiza o cache de análise de segurança
  void _updateSecurityCache(List<CookieEntry> cookies) {
    _securityCache.clear();
    for (final cookie in cookies) {
      final key = '${cookie.name}_${cookie.domain}';
      _securityCache[key] = CookieSecurityGuard.analyze(cookie);
    }
  }

  /// Exporta cookies para JSON
  String exportToJson({
    required List<CookieEntry> cookies,
    required String source,
    bool maskSensitiveValues = true,
  }) {
    return _exportService.exportToJson(
      cookies: cookies,
      source: source,
      domain: _currentUrl,
      maskSensitiveValues: maskSensitiveValues,
    );
  }

  /// Exporta cookies para CSV
  String exportToCsv({
    required List<CookieEntry> cookies,
    bool maskSensitiveValues = true,
  }) {
    return _exportService.exportToCsv(
      cookies: cookies,
      maskSensitiveValues: maskSensitiveValues,
    );
  }

  /// Exporta cookies para PDF
  Future<void> exportToPdf({
    required List<CookieEntry> cookies,
    required String source,
    bool maskSensitiveValues = true,
  }) async {
    await _exportService.exportToPdf(
      cookies: cookies,
      source: source,
      domain: _currentUrl,
      maskSensitiveValues: maskSensitiveValues,
    );
  }

  /// Gera relatório de segurança
  String generateSecurityReport(List<CookieEntry> cookies) {
    return _exportService.generateSecurityReport(cookies);
  }

  /// Autentica usando biometria ou PIN
  Future<bool> authenticate(String reason) async {
    return await _authService.authenticate(reason: reason);
  }

  /// Valida PIN
  Future<bool> validatePin(String pin) async {
    return await _authService.validatePin(pin);
  }

  /// Verifica se há PIN configurado
  Future<bool> hasPin() async {
    return await _authService.hasPin();
  }

  /// Define um novo PIN
  Future<bool> setPin(String pin) async {
    return await _authService.setPin(pin);
  }

  /// Obtém aviso sobre limitações do WebView
  String getWebViewLimitationsWarning() {
    return _webViewService.getLimitationsWarning();
  }

  /// Verifica se biometria está disponível
  Future<bool> canUseBiometrics() async {
    return await _authService.canCheckBiometrics();
  }

  /// Obtém estatísticas dos cookies HTTP
  Future<Map<String, dynamic>> getHttpStatistics() async {
    return await _httpService.getStatistics();
  }

  /// Define o estado de carregamento
  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  /// Limpa o erro
  void clearError() {
    _error = null;
    notifyListeners();
  }

  @override
  void dispose() {
    _securityCache.clear();
    super.dispose();
  }
}
