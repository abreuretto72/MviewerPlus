import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:file_viewer/services/app_signature_validator.dart';

/// Gerencia a comunicação com o código nativo para verificações de segurança
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
    // Verificações base
    final List<dynamic> results = await _channel.invokeMethod('performFullSecurityCheck');
    
    // Verificações avançadas (Módulos B e C)
    final wifiSecurity = await checkWifiSecurity();
    final sideloadedApps = await checkSideloadedApps();
    final thirdPartyKeyboards = await checkThirdPartyKeyboards();
    final accessibilityAbuse = await checkAccessibilityAbuse();

    // Verificação de Assinaturas (Trusted Apps) - INTEGRAÇÃO ATIVADA
    // Validação de Assinaturas (Módulo App Integrity)
    final List<Map<String, dynamic>> signatureMismatches = [];
    final List<Map<String, dynamic>> monitoredAppsStatus = [];

    try {
      final trustedApps = TrustedAppHashesService.instance.getAllTrustedApps();
    


    // Checking installed apps against trusted hashes from Firebase
      for (final app in trustedApps) {
        // Log para debug
        debugPrint('[SignatureCheck] Checking ${app.packageName}...');
        
        if (app.validHashes.isEmpty) {
             debugPrint('[SignatureCheck] Warning: No valid hashes for ${app.packageName}. Skipping.');
             continue;
        }

        final validation = await checkAppSignature(app.packageName, app.validHashes.first); 
        
        // Coleta status para diagnóstico
        if (validation['isInstalled'] == true) {
             monitoredAppsStatus.add({
                 'packageName': app.packageName,
                 'appName': app.name,
                 'status': 'INSTALLED',
                 'isValid': validation['isValid'],
                 'actualHash': validation['actualHash'],
                 'expectedHash': app.validHashes.first
             });
        } else {
             monitoredAppsStatus.add({
                 'packageName': app.packageName,
                 'appName': app.name,
                 'status': 'NOT_INSTALLED',
             });
        }

        if (validation['isInstalled'] == true) {
             final actualHash = validation['actualHash'];
             final expectedHash = app.validHashes.first;
             debugPrint('[SignatureCheck] ${app.packageName} - Installed: $actualHash | Expected: $expectedHash');
             
             if (validation['isValid'] == false) {
                debugPrint('[SignatureCheck] ❌ MISMATCH DETECTED for ${app.packageName}!');
                signatureMismatches.add({
                  'packageName': app.packageName,
                  'appName': app.name,
                  'expectedHash': expectedHash,
                  'actualHash': actualHash
                });
             } else {
                debugPrint('[SignatureCheck] ✅ MATCH for ${app.packageName}');
             }
        } else {
             debugPrint('[SignatureCheck] ${app.packageName} not installed.');
        }
      }
    } catch (e) {
      debugPrint('Error validating app signatures: $e');
    }

    return SecurityCheckResult(
      isRooted: results[0],
      isDebuggerAttached: results[1],
      isHookingDetected: results[2],
      isEmulator: results[3],
      isAppTampered: !results[4],
      isOSOutdated: !results[5],
      isScreenLockDisabled: !results[6], // Assumindo ordem do Kotlin
      hasUnknownSources: results.length > 7 ? results[7] : false, // Prevent index oob if kotlin mismatch
      alwaysLocationAppsCount: results.length > 8 ? results[8] : 0,
      hasLockScreenNotifications: results.length > 9 ? results[9] : false,
      isSecurityPatchOutdated: results.length > 10 ? results[10] : false,
      isUSBDebuggingEnabled: results.length > 11 ? results[11] : false,
      isProxyConfigured: results.length > 12 ? results[12] : false,
      wifiSecurity: wifiSecurity,
      sideloadedApps: sideloadedApps,
      thirdPartyKeyboards: thirdPartyKeyboards,
      accessibilityAbuseApps: accessibilityAbuse,
      signatureMismatches: signatureMismatches,
      monitoredAppsStatus: monitoredAppsStatus,
    );
  }
}

/// Resultado da verificação de segurança
class SecurityCheckResult {
  final bool isRooted;
  final bool isDebuggerAttached;
  final bool isHookingDetected;
  final bool isEmulator;
  final bool isAppTampered;
  final bool isOSOutdated;
  final bool isScreenLockDisabled;
  
  // Novos campos (Módulo A)
  final bool hasUnknownSources;                  // P-3
  final int alwaysLocationAppsCount;             // P-4
  final bool hasLockScreenNotifications;         // P-5
  final bool isSecurityPatchOutdated;            // Patch < 60 dias
  
  // Novos campos (Módulo B e C completo)
  final bool isUSBDebuggingEnabled;                    // Módulo A - Crítico
  final bool isProxyConfigured;                          // Módulo B - Crítico
  final Map<String, dynamic> wifiSecurity;           // Módulo B - Aviso
  final List<Map<String, String>> sideloadedApps;    // Módulo C - Aviso
  final List<String> thirdPartyKeyboards;            // Módulo C - Aviso
  final List<Map<String, String>> accessibilityAbuseApps; // Módulo C - Aviso
  final List<Map<String, dynamic>> signatureMismatches; // Validação de Assinaturas - Crítico
  final List<Map<String, dynamic>> monitoredAppsStatus; // Diagnóstico
  final String? debugError; // Campo para mostrar erro interno na UI

  SecurityCheckResult({
    required this.isRooted,
    required this.isDebuggerAttached,
    required this.isHookingDetected,
    required this.isEmulator,
    required this.isAppTampered,
    required this.isOSOutdated,
    required this.isScreenLockDisabled,
    required this.hasUnknownSources,
    required this.alwaysLocationAppsCount,
    required this.hasLockScreenNotifications,
    required this.isSecurityPatchOutdated,
    required this.isUSBDebuggingEnabled,
    required this.isProxyConfigured,
    this.wifiSecurity = const {},
    this.sideloadedApps = const [],
    this.thirdPartyKeyboards = const [],
    this.accessibilityAbuseApps = const [],
    this.signatureMismatches = const [],
    this.monitoredAppsStatus = const [],
    this.debugError,
  });

  /// Verifica se há ameaças críticas (VERMELHO)
  bool get hasCriticalThreats {
    return isRooted || 
           isDebuggerAttached || 
           isHookingDetected || 
           isAppTampered ||
           isUSBDebuggingEnabled ||
           isProxyConfigured ||
           signatureMismatches.isNotEmpty;
  }

  /// Verifica se há avisos (AMARELO)
  bool get hasWarnings {
    return isOSOutdated || 
           isScreenLockDisabled || 
           isEmulator ||
           hasUnknownSources ||
           alwaysLocationAppsCount > 0 ||
           hasLockScreenNotifications ||
           isSecurityPatchOutdated ||
           !(wifiSecurity['isSecure'] as bool? ?? true) ||
           sideloadedApps.isNotEmpty ||
           thirdPartyKeyboards.isNotEmpty ||
           accessibilityAbuseApps.isNotEmpty;
  }

  /// Nível de segurança geral
  SecurityLevel get securityLevel {
    if (hasCriticalThreats) return SecurityLevel.critical;
    if (hasWarnings) return SecurityLevel.warning;
    return SecurityLevel.safe;
  }

  /// Lista de ameaças encontradas (para exibição)
  List<String> get threats {
    final list = <String>[];
    if (isRooted) list.add('O dispositivo possui acesso Root/Jailbreak');
    if (isDebuggerAttached) list.add('O aplicativo está em modo de depuração');
    if (isHookingDetected) list.add('Frameworks de hooking detectados (ex: Frida)');
    if (!isAppTampered) list.add('A integridade do aplicativo está comprometida');
    if (isUSBDebuggingEnabled) list.add('Depuração USB ativada (Risco Crítico)');
    if (isProxyConfigured) list.add('Proxy de rede detectado (Possível interceptação)');
    
    if (signatureMismatches.isNotEmpty) {
      list.add('Apps com assinatura inválida detectados (${signatureMismatches.length})');
    }

    return list;
  }

  /// Lista de avisos encontrados
  List<String> get warnings {
    final list = <String>[];
    if (isOSOutdated) list.add('O sistema operacional está desatualizado');
    if (isScreenLockDisabled) list.add('Nenhum bloqueio de tela configurado');
    if (isEmulator) list.add('O dispositivo parece ser um emulador');
    if (hasUnknownSources) list.add('Instalação de fontes desconhecidas habilitada');
    if (alwaysLocationAppsCount > 0) list.add('$alwaysLocationAppsCount apps com localização "Sempre"');
    if (hasLockScreenNotifications) list.add('Notificações sensíveis na tela de bloqueio');
    if (isSecurityPatchOutdated) list.add('Patch de segurança antigo (>60 dias)');
    
    if (!(wifiSecurity['isSecure'] as bool? ?? true)) {
      list.add('Wi-Fi inseguro detectado (${wifiSecurity['securityType']})');
    }
    if (sideloadedApps.isNotEmpty) {
      list.add('${sideloadedApps.length} apps instalados fora da loja (Sideloading)');
    }
    if (thirdPartyKeyboards.isNotEmpty) {
      list.add('${thirdPartyKeyboards.length} teclados de terceiros detectados');
    }
    if (accessibilityAbuseApps.isNotEmpty) {
      list.add('${accessibilityAbuseApps.length} apps com acessibilidade abusiva');
    }

    return list;
  }

  /// Pontuação de risco (0-100, onde 100 é o mais seguro)
  int get riskScore {
    int score = 100;

    // Penalidades críticas
    if (isRooted) score -= 30;
    if (isDebuggerAttached) score -= 20;
    if (isHookingDetected) score -= 20;
    if (isEmulator) score -= 10;
    if (isAppTampered) score -= 20;
    if (isOSOutdated) score -= 10;
    if (isScreenLockDisabled) score -= 10;
    if (hasUnknownSources) score -= 10;
    if (alwaysLocationAppsCount > 0) score -= 5;
    if (hasLockScreenNotifications) score -= 5;
    if (isSecurityPatchOutdated) score -= 5;
    if (isUSBDebuggingEnabled) score -= 20;
    if (isProxyConfigured) score -= 15;
    if (wifiSecurity['isSecure'] == false) score -= 10;
    if (sideloadedApps.isNotEmpty) score -= 15;
    if (thirdPartyKeyboards.isNotEmpty) score -= 10;
    if (accessibilityAbuseApps.isNotEmpty) score -= 15;
    if (signatureMismatches.isNotEmpty) score -= 25;

    return score.clamp(0, 100);
  }

  Map<String, dynamic> toJson() {
    return {
      'isRooted': isRooted,
      'isDebuggerAttached': isDebuggerAttached,
      'isHookingDetected': isHookingDetected,
      'isEmulator': isEmulator,
      'isAppTampered': isAppTampered,
      'isOSOutdated': isOSOutdated,
      'isScreenLockDisabled': isScreenLockDisabled,
      'hasUnknownSources': hasUnknownSources,
      'alwaysLocationAppsCount': alwaysLocationAppsCount,
      'hasLockScreenNotifications': hasLockScreenNotifications,
      'isSecurityPatchOutdated': isSecurityPatchOutdated,
      'isUSBDebuggingEnabled': isUSBDebuggingEnabled,
      'isProxyConfigured': isProxyConfigured,
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
