import 'package:flutter/foundation.dart';
import 'package:file_viewer/l10n/app_localizations.dart';
import 'package:file_viewer/services/app_signature_validator.dart';
import 'native_security_checker.dart';
import 'secure_http_client.dart';

/// Serviço principal de segurança
/// Integra todas as verificações de segurança e gerencia alertas
class SecurityService {
  static SecurityService? _instance;
  static SecurityService get instance => _instance ??= SecurityService._();
  
  SecurityService._();

  SecurityCheckResult? _lastCheckResult;
  DateTime? _lastCheckTime;
  
  /// Duração do cache (5 minutos)
  static const Duration _cacheDuration = Duration(minutes: 5);

  /// Executa verificação completa de segurança
  Future<SecurityCheckResult> performSecurityCheck({bool forceRefresh = false}) async {
    // Usar cache se disponível e não expirado
    if (!forceRefresh && 
        _lastCheckResult != null && 
        _lastCheckTime != null &&
        DateTime.now().difference(_lastCheckTime!) < _cacheDuration) {
      debugPrint('[SecurityService] Using cached security check result');
      return _lastCheckResult!;
    }

    if (forceRefresh) {
      debugPrint('[SecurityService] Forcing update of trusted app hashes...');
      await TrustedAppHashesService.instance.forceUpdate();
    }

    debugPrint('[SecurityService] Performing full security check...');
    
    try {
      // Executar todas as verificações
      final result = await NativeSecurityChecker.performFullSecurityCheck();
      
      // Atualizar cache
      _lastCheckResult = result;
      _lastCheckTime = DateTime.now();

      // Log dos resultados
      _logSecurityResults(result);

      return result;
    } catch (e) {
      debugPrint('[SecurityService] Error during security check: $e');
      
      // Retornar resultado seguro em caso de erro
      return SecurityCheckResult(
        isRooted: false,
        isDebuggerAttached: false,
        isHookingDetected: false,
        isEmulator: false,
        isAppTampered: false,
        isOSOutdated: false,
        isScreenLockDisabled: false,
        hasUnknownSources: false,
        alwaysLocationAppsCount: 0,
        hasLockScreenNotifications: false,
        isSecurityPatchOutdated: false,
        isUSBDebuggingEnabled: false,
        isProxyConfigured: false,
        wifiSecurity: {'isSecure': true, 'securityType': 'unknown'},
      );
    }
  }

  /// Verifica SSL Pinning
  Future<bool> checkSSLPinning(String url) async {
    debugPrint('[SecurityService] Checking SSL pinning for $url');
    return await SecureHttpClient.testSSLConnection(url);
  }

  /// Obtém ações recomendadas baseadas no resultado
  List<SecurityAction> getRecommendedActions(SecurityCheckResult result, AppLocalizations t) {
    final actions = <SecurityAction>[];

    if (result.isRooted) {
      actions.add(SecurityAction(
        type: SecurityActionType.critical,
        title: t.actionRootTitle,
        description: t.actionRootDesc,
        recommendation: t.actionRootRec,
        action: SecurityActionCode.blockCriticalFeatures,
      ));
    }

    if (result.isDebuggerAttached) {
      actions.add(SecurityAction(
        type: SecurityActionType.critical,
        title: t.actionDebuggerTitle,
        description: t.actionDebuggerDesc,
        recommendation: t.actionDebuggerRec,
        action: SecurityActionCode.blockCriticalFeatures,
      ));
    }

    if (result.isHookingDetected) {
      actions.add(SecurityAction(
        type: SecurityActionType.critical,
        title: t.actionHookingTitle,
        description: t.actionHookingDesc,
        recommendation: t.actionHookingRec,
        action: SecurityActionCode.blockCriticalFeatures,
      ));
    }

    if (result.isAppTampered) {
      actions.add(SecurityAction(
        type: SecurityActionType.critical,
        title: t.actionIntegrityTitle,
        description: t.actionIntegrityDesc,
        recommendation: t.actionIntegrityRec,
        action: SecurityActionCode.blockCriticalFeatures,
      ));
    }

    if (result.isOSOutdated) {
      actions.add(SecurityAction(
        type: SecurityActionType.warning,
        title: t.actionOSTitle,
        description: t.actionOSDesc,
        recommendation: t.actionOSRec,
        action: SecurityActionCode.showWarning,
      ));
    }

    if (result.isScreenLockDisabled) {
      actions.add(SecurityAction(
        type: SecurityActionType.warning,
        title: t.actionLockTitle,
        description: t.actionLockDesc,
        recommendation: t.actionLockRec,
        action: SecurityActionCode.showWarning,
      ));
    }

    if (result.isEmulator) {
      actions.add(SecurityAction(
        type: SecurityActionType.warning,
        title: t.actionEmulatorTitle,
        description: t.actionEmulatorDesc,
        recommendation: t.actionEmulatorRec,
        action: SecurityActionCode.showWarning,
      ));
    }

    // P-3: Fontes Desconhecidas
    if (result.hasUnknownSources) {
      actions.add(SecurityAction(
        type: SecurityActionType.warning,
        title: t.actionUnknownSourcesTitle,
        description: t.actionUnknownSourcesDesc,
        recommendation: t.actionUnknownSourcesRec,
        action: SecurityActionCode.showWarning,
        settingsAction: 'android.settings.MANAGE_UNKNOWN_APP_SOURCES',
      ));
    }

    // P-4: Permissão de Localização Permanente
    if (result.alwaysLocationAppsCount > 0) {
      actions.add(SecurityAction(
        type: SecurityActionType.warning,
        title: t.actionLocationTitle,
        description: t.actionLocationDesc(result.alwaysLocationAppsCount),
        recommendation: t.actionLocationRec,
        action: SecurityActionCode.showWarning,
        settingsAction: 'android.settings.LOCATION_SOURCE_SETTINGS',
      ));
    }

    // P-5: Notificações Sensíveis na Tela de Bloqueio
    if (result.hasLockScreenNotifications) {
      actions.add(SecurityAction(
        type: SecurityActionType.warning,
        title: t.actionNotifTitle,
        description: t.actionNotifDesc,
        recommendation: t.actionNotifRec,
        action: SecurityActionCode.showWarning,
        settingsAction: 'android.settings.SETTINGS',
      ));
    }

    // P-2: Patch de Segurança Antigo
    if (result.isSecurityPatchOutdated) {
      actions.add(SecurityAction(
        type: SecurityActionType.warning,
        title: t.actionPatchTitle,
        description: t.actionPatchDesc,
        recommendation: t.actionPatchRec,
        action: SecurityActionCode.showWarning,
        settingsAction: 'android.settings.SYSTEM_UPDATE_SETTINGS',
      ));
    }

    // P-6: Sugestão de 2FA (sempre mostrar)
    actions.add(SecurityAction(
      type: SecurityActionType.warning,
      title: t.action2FATitle,
      description: t.action2FADesc,
      recommendation: t.action2FARec,
      action: SecurityActionCode.showWarning,
      settingsAction: 'https://myaccount.google.com/security', // Link para configurações
      isReminder: true,
    ));

    return actions;
  }

  /// Verifica se deve bloquear funcionalidades críticas
  bool shouldBlockCriticalFeatures(SecurityCheckResult result) {
    return result.hasCriticalThreats;
  }

  /// Log dos resultados de segurança
  void _logSecurityResults(SecurityCheckResult result) {
    debugPrint('[SecurityService] ========== SECURITY CHECK RESULTS ==========');
    debugPrint('[SecurityService] Security Level: ${result.securityLevel.name.toUpperCase()}');
    
    if (result.threats.isNotEmpty) {
      debugPrint('[SecurityService] 🔴 THREATS DETECTED:');
      for (final threat in result.threats) {
        debugPrint('[SecurityService]   - $threat');
      }
    }

    if (result.warnings.isNotEmpty) {
      debugPrint('[SecurityService] 🟡 WARNINGS:');
      for (final warning in result.warnings) {
        debugPrint('[SecurityService]   - $warning');
      }
    }

    if (!result.hasCriticalThreats && !result.hasWarnings) {
      debugPrint('[SecurityService] ✅ All security checks passed');
    }

    debugPrint('[SecurityService] ============================================');
  }

  /// Limpa o cache
  void clearCache() {
    _lastCheckResult = null;
    _lastCheckTime = null;
  }
}

/// Ação de segurança recomendada
class SecurityAction {
  final SecurityActionType type;
  final String title;
  final String description;
  final String recommendation;
  final SecurityActionCode action;
  final String? settingsAction;  // Intent do Android ou URL para abrir configurações
  final bool isReminder;         // Se é apenas um lembrete (P-6)

  SecurityAction({
    required this.type,
    required this.title,
    required this.description,
    required this.recommendation,
    required this.action,
    this.settingsAction,
    this.isReminder = false,
  });
}

/// Tipo de ação de segurança
enum SecurityActionType {
  critical,  // Vermelho - Bloquear funcionalidades
  warning,   // Amarelo - Apenas avisar
}

/// Código de ação
enum SecurityActionCode {
  blockCriticalFeatures,  // Bloquear funcionalidades críticas
  showWarning,            // Mostrar aviso
  logout,                 // Fazer logout
  none,                   // Nenhuma ação
}
