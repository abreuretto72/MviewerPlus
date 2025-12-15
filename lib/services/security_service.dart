import 'package:flutter/foundation.dart';
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
        isDebugging: false,
        isHooked: false,
        isEmulator: false,
        hasValidIntegrity: true,
        hasUpdatedOS: true,
        hasScreenLock: true,
      );
    }
  }

  /// Verifica SSL Pinning
  Future<bool> checkSSLPinning(String url) async {
    debugPrint('[SecurityService] Checking SSL pinning for $url');
    return await SecureHttpClient.testSSLConnection(url);
  }

  /// Obtém ações recomendadas baseadas no resultado
  List<SecurityAction> getRecommendedActions(SecurityCheckResult result) {
    final actions = <SecurityAction>[];

    if (result.isRooted) {
      actions.add(SecurityAction(
        type: SecurityActionType.critical,
        title: 'Dispositivo com Root Detectado',
        description: 'Seu dispositivo está com privilégios de superusuário (root). '
            'Isso compromete a segurança do aplicativo.',
        recommendation: 'Remova o root do dispositivo ou use um dispositivo sem root.',
        action: SecurityActionCode.blockCriticalFeatures,
      ));
    }

    if (result.isDebugging) {
      actions.add(SecurityAction(
        type: SecurityActionType.critical,
        title: 'Debugger Detectado',
        description: 'Um debugger está anexado ao aplicativo. '
            'Isso pode indicar tentativa de análise ou modificação do app.',
        recommendation: 'Feche todas as ferramentas de desenvolvimento e reinicie o app.',
        action: SecurityActionCode.blockCriticalFeatures,
      ));
    }

    if (result.isHooked) {
      actions.add(SecurityAction(
        type: SecurityActionType.critical,
        title: 'Framework de Hooking Detectado',
        description: 'Foi detectado um framework de hooking (Frida, Xposed, etc.). '
            'Isso pode permitir modificação do comportamento do app.',
        recommendation: 'Remova frameworks de hooking e reinicie o dispositivo.',
        action: SecurityActionCode.blockCriticalFeatures,
      ));
    }

    if (!result.hasValidIntegrity) {
      actions.add(SecurityAction(
        type: SecurityActionType.critical,
        title: 'Integridade do App Comprometida',
        description: 'A assinatura do aplicativo não corresponde à esperada. '
            'O app pode ter sido modificado.',
        recommendation: 'Reinstale o app da loja oficial (Google Play/App Store).',
        action: SecurityActionCode.blockCriticalFeatures,
      ));
    }

    if (!result.hasUpdatedOS) {
      actions.add(SecurityAction(
        type: SecurityActionType.warning,
        title: 'Sistema Operacional Desatualizado',
        description: 'Seu sistema operacional está desatualizado e pode conter '
            'vulnerabilidades de segurança.',
        recommendation: 'Atualize seu sistema operacional para a versão mais recente.',
        action: SecurityActionCode.showWarning,
      ));
    }

    if (!result.hasScreenLock) {
      actions.add(SecurityAction(
        type: SecurityActionType.warning,
        title: 'Bloqueio de Tela Não Configurado',
        description: 'Seu dispositivo não possui bloqueio de tela configurado. '
            'Isso facilita acesso não autorizado.',
        recommendation: 'Configure um PIN, senha, padrão ou biometria nas configurações.',
        action: SecurityActionCode.showWarning,
      ));
    }

    if (result.isEmulator) {
      actions.add(SecurityAction(
        type: SecurityActionType.warning,
        title: 'Executando em Emulador',
        description: 'O app está rodando em um emulador. '
            'Algumas funcionalidades podem estar limitadas.',
        recommendation: 'Use um dispositivo físico para melhor experiência.',
        action: SecurityActionCode.showWarning,
      ));
    }

    // P-3: Fontes Desconhecidas
    if (result.unknownSourcesEnabled) {
      actions.add(SecurityAction(
        type: SecurityActionType.warning,
        title: 'P-3: Instalação de Fontes Desconhecidas Habilitada',
        description: 'Seu dispositivo permite instalação de apps de fontes desconhecidas. '
            'Isso facilita a instalação de malware e spyware.',
        recommendation: 'Desabilite "Instalar apps de fontes desconhecidas" nas configurações de segurança.',
        action: SecurityActionCode.showWarning,
        settingsAction: 'android.settings.MANAGE_UNKNOWN_APP_SOURCES',
      ));
    }

    // P-4: Permissão de Localização Permanente
    if (result.alwaysLocationAppsCount > 0) {
      actions.add(SecurityAction(
        type: SecurityActionType.warning,
        title: 'P-4: Apps com Localização "Sempre" Detectados',
        description: '${result.alwaysLocationAppsCount} app(s) têm permissão de rastreamento '
            'de localização em segundo plano. Isso representa risco de privacidade.',
        recommendation: 'Revise as permissões de localização e mude para "Apenas durante o uso" quando possível.',
        action: SecurityActionCode.showWarning,
        settingsAction: 'android.settings.LOCATION_SOURCE_SETTINGS',
      ));
    }

    // P-5: Notificações Sensíveis na Tela de Bloqueio
    if (result.showsSensitiveNotifications) {
      actions.add(SecurityAction(
        type: SecurityActionType.warning,
        title: 'P-5: Notificações Sensíveis Visíveis na Tela de Bloqueio',
        description: 'Prévias de notificações (mensagens, códigos 2FA) são exibidas na tela de bloqueio. '
            'Isso pode permitir interceptação de dados sensíveis.',
        recommendation: 'Configure para ocultar conteúdo sensível nas notificações da tela de bloqueio.',
        action: SecurityActionCode.showWarning,
        settingsAction: 'android.settings.SETTINGS',
      ));
    }

    // P-2: Patch de Segurança Antigo
    if (result.hasOldSecurityPatch) {
      actions.add(SecurityAction(
        type: SecurityActionType.warning,
        title: 'P-2: Patch de Segurança Desatualizado',
        description: 'O patch de segurança do seu dispositivo tem mais de 60 dias. '
            'Vulnerabilidades conhecidas podem não estar corrigidas.',
        recommendation: 'Verifique por atualizações do sistema nas configurações.',
        action: SecurityActionCode.showWarning,
        settingsAction: 'android.settings.SYSTEM_UPDATE_SETTINGS',
      ));
    }

    // P-6: Sugestão de 2FA (sempre mostrar)
    actions.add(SecurityAction(
      type: SecurityActionType.warning,
      title: 'P-6: Ative a Autenticação de Dois Fatores (2FA)',
      description: 'A autenticação de dois fatores adiciona uma camada extra de segurança '
          'às suas contas críticas (Google/Apple ID).',
      recommendation: 'Ative o 2FA nas configurações de segurança da sua conta.',
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
