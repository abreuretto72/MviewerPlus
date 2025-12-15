import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';

/// Verificador de segurança nativo usando Platform Channels
/// Detecta Root/Jailbreak, Debugging, Hooking e outras ameaças
class NativeSecurityChecker {
  static const MethodChannel _channel = MethodChannel('com.multiversodigital.mviewerplus/security');

  /// Verifica se o dispositivo está com Root (Android) ou Jailbreak (iOS)
  static Future<bool> checkRootJailbreak() async {
    try {
      final bool isRooted = await _channel.invokeMethod('checkRootJailbreak');
      return isRooted;
    } on PlatformException catch (e) {
      debugPrint('[SecurityChecker] Error checking root/jailbreak: $e');
      return false;
    }
  }

  /// Verifica se o app está sendo debugado
  static Future<bool> checkDebugger() async {
    try {
      final bool isDebugging = await _channel.invokeMethod('checkDebugger');
      return isDebugging;
    } on PlatformException catch (e) {
      debugPrint('[SecurityChecker] Error checking debugger: $e');
      return false;
    }
  }

  /// Verifica se há frameworks de hooking (Frida, Xposed, etc.)
  static Future<bool> checkHooking() async {
    try {
      final bool isHooked = await _channel.invokeMethod('checkHooking');
      return isHooked;
    } on PlatformException catch (e) {
      debugPrint('[SecurityChecker] Error checking hooking: $e');
      return false;
    }
  }

  /// Verifica se o app está rodando em emulador
  static Future<bool> checkEmulator() async {
    try {
      final bool isEmulator = await _channel.invokeMethod('checkEmulator');
      return isEmulator;
    } on PlatformException catch (e) {
      debugPrint('[SecurityChecker] Error checking emulator: $e');
      return false;
    }
  }

  /// Verifica a integridade do APK/IPA (assinatura)
  static Future<bool> checkAppIntegrity() async {
    try {
      final bool isValid = await _channel.invokeMethod('checkAppIntegrity');
      return isValid;
    } on PlatformException catch (e) {
      debugPrint('[SecurityChecker] Error checking app integrity: $e');
      return true; // Assume válido em caso de erro
    }
  }

  /// Verifica se o sistema operacional está atualizado
  static Future<bool> checkOSVersion() async {
    try {
      final bool isUpdated = await _channel.invokeMethod('checkOSVersion');
      return isUpdated;
    } on PlatformException catch (e) {
      debugPrint('[SecurityChecker] Error checking OS version: $e');
      return true;
    }
  }

  /// Verifica se o bloqueio de tela está ativado
  static Future<bool> checkScreenLock() async {
    try {
      final bool hasScreenLock = await _channel.invokeMethod('checkScreenLock');
      return hasScreenLock;
    } on PlatformException catch (e) {
      debugPrint('[SecurityChecker] Error checking screen lock: $e');
      return true;
    }
  }

  /// P-3: Verifica se "Fontes Desconhecidas" está habilitada (Android)
  static Future<bool> checkUnknownSources() async {
    try {
      final bool isEnabled = await _channel.invokeMethod('checkUnknownSources');
      return isEnabled;
    } on PlatformException catch (e) {
      debugPrint('[SecurityChecker] Error checking unknown sources: $e');
      return false;
    }
  }

  /// P-4: Conta apps com permissão de localização "Sempre"
  static Future<int> checkAlwaysLocationApps() async {
    try {
      final int count = await _channel.invokeMethod('checkAlwaysLocationApps');
      return count;
    } on PlatformException catch (e) {
      debugPrint('[SecurityChecker] Error checking location permissions: $e');
      return 0;
    }
  }

  /// P-5: Verifica se notificações sensíveis aparecem na tela de bloqueio
  static Future<bool> checkLockScreenNotifications() async {
    try {
      final bool showsSensitive = await _channel.invokeMethod('checkLockScreenNotifications');
      return showsSensitive;
    } on PlatformException catch (e) {
      debugPrint('[SecurityChecker] Error checking lockscreen notifications: $e');
      return false;
    }
  }

  /// Verifica se o patch de segurança tem mais de 60 dias (Android)
  static Future<bool> checkSecurityPatchAge() async {
    try {
      final bool isOld = await _channel.invokeMethod('checkSecurityPatchAge');
      return isOld;
    } on PlatformException catch (e) {
      debugPrint('[SecurityChecker] Error checking security patch: $e');
      return false;
    }
  }

  /// Verifica se USB Debugging está ativo
  static Future<bool> checkUSBDebugging() async {
    try {
      final bool isEnabled = await _channel.invokeMethod('checkUSBDebugging');
      return isEnabled;
    } on PlatformException catch (e) {
      debugPrint('[SecurityChecker] Error checking USB debugging: $e');
      return false;
    }
  }

  /// Verifica se há proxy configurado
  static Future<bool> checkProxy() async {
    try {
      final bool hasProxy = await _channel.invokeMethod('checkProxy');
      return hasProxy;
    } on PlatformException catch (e) {
      debugPrint('[SecurityChecker] Error checking proxy: $e');
      return false;
    }
  }

  /// Verifica segurança do Wi-Fi
  static Future<Map<String, dynamic>> checkWifiSecurity() async {
    try {
      final Map<dynamic, dynamic> result = await _channel.invokeMethod('checkWifiSecurity');
      return Map<String, dynamic>.from(result);
    } on PlatformException catch (e) {
      debugPrint('[SecurityChecker] Error checking wifi security: $e');
      return {'isSecure': true, 'securityType': 'unknown'};
    }
  }

  /// Verifica apps instalados de fontes desconhecidas (sideloading)
  static Future<List<Map<String, String>>> checkSideloadedApps() async {
    try {
      final List<dynamic> result = await _channel.invokeMethod('checkSideloadedApps');
      return result.map((e) => Map<String, String>.from(e)).toList();
    } on PlatformException catch (e) {
      debugPrint('[SecurityChecker] Error checking sideloaded apps: $e');
      return [];
    }
  }

  /// Verifica teclados de terceiros
  static Future<List<String>> checkThirdPartyKeyboards() async {
    try {
      final List<dynamic> result = await _channel.invokeMethod('checkThirdPartyKeyboards');
      return result.map((e) => e.toString()).toList();
    } on PlatformException catch (e) {
      debugPrint('[SecurityChecker] Error checking keyboards: $e');
      return [];
    }
  }

  /// Verifica apps com permissões de acessibilidade suspeitas
  static Future<List<Map<String, String>>> checkAccessibilityAbuse() async {
    try {
      final List<dynamic> result = await _channel.invokeMethod('checkAccessibilityAbuse');
      return result.map((e) => Map<String, String>.from(e)).toList();
    } on PlatformException catch (e) {
      debugPrint('[SecurityChecker] Error checking accessibility: $e');
      return [];
    }
  }

  /// Verifica assinatura SHA-256 de um app específico
  static Future<Map<String, dynamic>> checkAppSignature(
    String packageName,
    String expectedHash,
  ) async {
    try {
      final Map<dynamic, dynamic> result = await _channel.invokeMethod(
        'checkAppSignature',
        {
          'packageName': packageName,
          'expectedHash': expectedHash,
        },
      );
      return Map<String, dynamic>.from(result);
    } on PlatformException catch (e) {
      debugPrint('[SecurityChecker] Error checking app signature: $e');
      return {
        'isInstalled': false,
        'isValid': null,
        'actualHash': null,
        'error': e.message,
      };
    }
  }

  /// Executa todas as verificações de segurança
  static Future<SecurityCheckResult> performFullSecurityCheck() async {
    final results = await Future.wait([
      checkRootJailbreak(),
      checkDebugger(),
      checkHooking(),
      checkEmulator(),
      checkAppIntegrity(),
      checkOSVersion(),
      checkScreenLock(),
      checkUnknownSources(),
      checkAlwaysLocationApps(),
      checkLockScreenNotifications(),
      checkSecurityPatchAge(),
      checkUSBDebugging(),
      checkProxy(),
    ]);

    final wifiSecurity = await checkWifiSecurity();
    final sideloadedApps = await checkSideloadedApps();
    final thirdPartyKeyboards = await checkThirdPartyKeyboards();
    final accessibilityAbuse = await checkAccessibilityAbuse();

    return SecurityCheckResult(
      isRooted: results[0] as bool,
      isDebugging: results[1] as bool,
      isHooked: results[2] as bool,
      isEmulator: results[3] as bool,
      hasValidIntegrity: results[4] as bool,
      hasUpdatedOS: results[5] as bool,
      hasScreenLock: results[6] as bool,
      unknownSourcesEnabled: results[7] as bool,
      alwaysLocationAppsCount: results[8] as int,
      showsSensitiveNotifications: results[9] as bool,
      hasOldSecurityPatch: results[10] as bool,
      usbDebuggingEnabled: results[11] as bool,
      proxyDetected: results[12] as bool,
      wifiSecurity: wifiSecurity,
      sideloadedApps: sideloadedApps,
      thirdPartyKeyboards: thirdPartyKeyboards,
      accessibilityAbuse: accessibilityAbuse,
    );
  }
}

/// Resultado da verificação de segurança
class SecurityCheckResult {
  final bool isRooted;
  final bool isDebugging;
  final bool isHooked;
  final bool isEmulator;
  final bool hasValidIntegrity;
  final bool hasUpdatedOS;
  final bool hasScreenLock;
  
  // Campos de postura de segurança (P-1 a P-6)
  final bool unknownSourcesEnabled;        // P-3
  final int alwaysLocationAppsCount;       // P-4
  final bool showsSensitiveNotifications;  // P-5
  final bool hasOldSecurityPatch;          // P-2 (complemento)
  
  // Novos campos (Módulo B e C completo)
  final bool usbDebuggingEnabled;                    // Módulo A - Crítico
  final bool proxyDetected;                          // Módulo B - Crítico
  final Map<String, dynamic> wifiSecurity;           // Módulo B - Aviso
  final List<Map<String, String>> sideloadedApps;    // Módulo C - Aviso
  final List<String> thirdPartyKeyboards;            // Módulo C - Aviso
  final List<Map<String, String>> accessibilityAbuse; // Módulo C - Aviso

  SecurityCheckResult({
    required this.isRooted,
    required this.isDebugging,
    required this.isHooked,
    required this.isEmulator,
    required this.hasValidIntegrity,
    required this.hasUpdatedOS,
    required this.hasScreenLock,
    this.unknownSourcesEnabled = false,
    this.alwaysLocationAppsCount = 0,
    this.showsSensitiveNotifications = false,
    this.hasOldSecurityPatch = false,
    this.usbDebuggingEnabled = false,
    this.proxyDetected = false,
    this.wifiSecurity = const {'isSecure': true, 'securityType': 'unknown'},
    this.sideloadedApps = const [],
    this.thirdPartyKeyboards = const [],
    this.accessibilityAbuse = const [],
  });

  /// Verifica se há ameaças críticas (VERMELHO)
  bool get hasCriticalThreats {
    return isRooted || 
           isDebugging || 
           isHooked || 
           !hasValidIntegrity ||
           usbDebuggingEnabled ||
           proxyDetected;
  }

  /// Verifica se há avisos (AMARELO)
  bool get hasWarnings {
    return !hasUpdatedOS || 
           !hasScreenLock || 
           isEmulator ||
           unknownSourcesEnabled ||
           alwaysLocationAppsCount > 0 ||
           showsSensitiveNotifications ||
           hasOldSecurityPatch ||
           !(wifiSecurity['isSecure'] as bool? ?? true) ||
           sideloadedApps.isNotEmpty ||
           thirdPartyKeyboards.isNotEmpty ||
           accessibilityAbuse.isNotEmpty;
  }

  /// Nível de segurança geral
  SecurityLevel get securityLevel {
    if (hasCriticalThreats) return SecurityLevel.critical;
    if (hasWarnings) return SecurityLevel.warning;
    return SecurityLevel.safe;
  }

  /// Lista de ameaças detectadas (VERMELHO)
  List<String> get threats {
    final threats = <String>[];
    
    if (isRooted) threats.add('Dispositivo com Root/Jailbreak detectado');
    if (isDebugging) threats.add('Debugger ativo detectado');
    if (isHooked) threats.add('Framework de hooking detectado');
    if (!hasValidIntegrity) threats.add('Integridade do app comprometida');
    if (usbDebuggingEnabled) threats.add('Depuração USB ativa - Risco de extração de dados');
    if (proxyDetected) threats.add('Proxy detectado - Tráfego pode estar sendo interceptado');
    
    return threats;
  }

  /// Lista de avisos (AMARELO)
  List<String> get warnings {
    final warnings = <String>[];
    
    // P-1: Bloqueio de Tela
    if (!hasScreenLock) {
      warnings.add('P-1: Bloqueio de tela não configurado');
    }
    
    // P-2: Sistema Operacional Desatualizado
    if (!hasUpdatedOS) {
      warnings.add('P-2: Sistema operacional desatualizado');
    }
    
    if (hasOldSecurityPatch) {
      warnings.add('P-2: Patch de segurança com mais de 60 dias');
    }
    
    // P-3: Fontes Desconhecidas
    if (unknownSourcesEnabled) {
      warnings.add('P-3: Instalação de fontes desconhecidas habilitada');
    }
    
    // P-4: Permissão de Localização Permanente
    if (alwaysLocationAppsCount > 0) {
      warnings.add('P-4: $alwaysLocationAppsCount app(s) com localização "Sempre"');
    }
    
    // P-5: Notificações Sensíveis na Tela de Bloqueio
    if (showsSensitiveNotifications) {
      warnings.add('P-5: Notificações sensíveis visíveis na tela de bloqueio');
    }
    
    if (isEmulator) {
      warnings.add('Executando em emulador');
    }
    
    // Wi-Fi Inseguro
    if (!(wifiSecurity['isSecure'] as bool? ?? true)) {
      final secType = wifiSecurity['securityType'] as String? ?? 'unknown';
      warnings.add('Wi-Fi inseguro detectado (${secType.toUpperCase()})');
    }
    
    // Apps Sideloaded
    if (sideloadedApps.isNotEmpty) {
      warnings.add('${sideloadedApps.length} app(s) sensível(is) de fonte desconhecida');
    }
    
    // Teclados de Terceiros
    if (thirdPartyKeyboards.isNotEmpty) {
      warnings.add('${thirdPartyKeyboards.length} teclado(s) de terceiros detectado(s)');
    }
    
    // Permissões de Acessibilidade Abusivas
    if (accessibilityAbuse.isNotEmpty) {
      warnings.add('${accessibilityAbuse.length} app(s) com permissão de acessibilidade suspeita');
    }
    
    return warnings;
  }

  /// Pontuação de risco (0-100)
  int get riskScore {
    int score = 0;
    
    // Ameaças críticas (20 pontos cada)
    if (isRooted) score += 20;
    if (isDebugging) score += 20;
    if (isHooked) score += 20;
    if (!hasValidIntegrity) score += 20;
    if (usbDebuggingEnabled) score += 20;
    if (proxyDetected) score += 20;
    
    // Avisos (5-10 pontos cada)
    if (!hasScreenLock) score += 10;
    if (!hasUpdatedOS) score += 10;
    if (hasOldSecurityPatch) score += 5;
    if (unknownSourcesEnabled) score += 10;
    if (alwaysLocationAppsCount > 0) score += (alwaysLocationAppsCount * 2).clamp(0, 10);
    if (showsSensitiveNotifications) score += 5;
    if (isEmulator) score += 5;
    if (!(wifiSecurity['isSecure'] as bool? ?? true)) score += 10;
    if (sideloadedApps.isNotEmpty) score += (sideloadedApps.length * 3).clamp(0, 15);
    if (thirdPartyKeyboards.isNotEmpty) score += (thirdPartyKeyboards.length * 2).clamp(0, 10);
    if (accessibilityAbuse.isNotEmpty) score += (accessibilityAbuse.length * 5).clamp(0, 15);
    
    return score.clamp(0, 100);
  }

  Map<String, dynamic> toJson() {
    return {
      'isRooted': isRooted,
      'isDebugging': isDebugging,
      'isHooked': isHooked,
      'isEmulator': isEmulator,
      'hasValidIntegrity': hasValidIntegrity,
      'hasUpdatedOS': hasUpdatedOS,
      'hasScreenLock': hasScreenLock,
      'unknownSourcesEnabled': unknownSourcesEnabled,
      'alwaysLocationAppsCount': alwaysLocationAppsCount,
      'showsSensitiveNotifications': showsSensitiveNotifications,
      'hasOldSecurityPatch': hasOldSecurityPatch,
      'securityLevel': securityLevel.name,
      'threats': threats,
      'warnings': warnings,
      'riskScore': riskScore,
    };
  }
}

/// Níveis de segurança
enum SecurityLevel {
  safe,      // Verde - Tudo OK
  warning,   // Amarelo - Avisos
  critical,  // Vermelho - Ameaças críticas
}
