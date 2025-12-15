import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/cookie_logger.dart';

/// Serviço para gerenciar autenticação biométrica e PIN
class AuthService {
  final LocalAuthentication _localAuth = LocalAuthentication();
  static const String _pinKey = 'cookie_inspector_pin';
  static const String _biometricEnabledKey = 'biometric_enabled';

  /// Verifica se o dispositivo suporta biometria
  Future<bool> canCheckBiometrics() async {
    try {
      return await _localAuth.canCheckBiometrics;
    } catch (e) {
      CookieLogger.error('Erro ao verificar suporte biométrico', e);
      return false;
    }
  }

  /// Verifica se há biometria disponível
  Future<bool> isDeviceSupported() async {
    try {
      return await _localAuth.isDeviceSupported();
    } catch (e) {
      CookieLogger.error('Erro ao verificar dispositivo', e);
      return false;
    }
  }

  /// Lista os tipos de biometria disponíveis
  Future<List<BiometricType>> getAvailableBiometrics() async {
    try {
      return await _localAuth.getAvailableBiometrics();
    } catch (e) {
      CookieLogger.error('Erro ao obter biometrias disponíveis', e);
      return [];
    }
  }

  /// Autentica usando biometria
  Future<bool> authenticateWithBiometrics({
    required String reason,
  }) async {
    try {
      final canCheck = await canCheckBiometrics();
      if (!canCheck) {
        return false;
      }

      return await _localAuth.authenticate(
        localizedReason: reason,
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
    } catch (e) {
      CookieLogger.error('Erro na autenticação biométrica', e);
      return false;
    }
  }

  /// Verifica se a biometria está habilitada nas configurações
  Future<bool> isBiometricEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_biometricEnabledKey) ?? false;
  }

  /// Habilita/desabilita biometria
  Future<void> setBiometricEnabled(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_biometricEnabledKey, enabled);
  }

  /// Define um PIN
  Future<bool> setPin(String pin) async {
    try {
      if (pin.length < 4) {
        return false;
      }

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_pinKey, pin);
      return true;
    } catch (e) {
      CookieLogger.error('Erro ao definir PIN', e);
      return false;
    }
  }

  /// Verifica se há PIN configurado
  Future<bool> hasPin() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(_pinKey);
  }

  /// Valida um PIN
  Future<bool> validatePin(String pin) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final storedPin = prefs.getString(_pinKey);
      return storedPin == pin;
    } catch (e) {
      CookieLogger.error('Erro ao validar PIN', e);
      return false;
    }
  }

  /// Remove o PIN
  Future<bool> removePin() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_pinKey);
      return true;
    } catch (e) {
      CookieLogger.error('Erro ao remover PIN', e);
      return false;
    }
  }

  /// Autentica usando biometria ou PIN (fallback)
  Future<bool> authenticate({
    required String reason,
    bool allowPinFallback = true,
  }) async {
    // Tenta biometria primeiro se estiver habilitada
    final biometricEnabled = await isBiometricEnabled();
    final canUseBiometric = await canCheckBiometrics();

    if (biometricEnabled && canUseBiometric) {
      final authenticated = await authenticateWithBiometrics(reason: reason);
      if (authenticated) {
        return true;
      }
    }

    // Fallback para PIN se permitido
    if (allowPinFallback) {
      final hasConfiguredPin = await hasPin();
      if (!hasConfiguredPin) {
        // Sem PIN configurado, retorna false
        return false;
      }
      // Retorna false aqui - a UI deve solicitar o PIN
      return false;
    }

    return false;
  }

  /// Obtém descrição dos métodos de autenticação disponíveis
  Future<String> getAuthMethodDescription() async {
    final biometricEnabled = await isBiometricEnabled();
    final canUseBiometric = await canCheckBiometrics();
    final hasConfiguredPin = await hasPin();

    if (biometricEnabled && canUseBiometric) {
      final biometrics = await getAvailableBiometrics();
      if (biometrics.contains(BiometricType.face)) {
        return 'Reconhecimento Facial';
      } else if (biometrics.contains(BiometricType.fingerprint)) {
        return 'Impressão Digital';
      } else if (biometrics.contains(BiometricType.iris)) {
        return 'Reconhecimento de Íris';
      }
      return 'Biometria';
    }

    if (hasConfiguredPin) {
      return 'PIN';
    }

    return 'Nenhum método configurado';
  }
}
