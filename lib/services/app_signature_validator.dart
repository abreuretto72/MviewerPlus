import 'dart:convert';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';

/// Serviço para gerenciar hashes de apps confiáveis via Firebase Remote Config
/// Permite atualizar assinaturas sem lançar nova versão do app
class TrustedAppHashesService {
  static const String _configKey = 'trusted_app_hashes';
  static const Duration _fetchTimeout = Duration(seconds: 10);
  static const Duration _minimumFetchInterval = Duration(hours: 1);

  static TrustedAppHashesService? _instance;
  static TrustedAppHashesService get instance => _instance ??= TrustedAppHashesService._();
  
  TrustedAppHashesService._();

  FirebaseRemoteConfig? _remoteConfig;
  Map<String, List<String>> _hashes = {};
  bool _isInitialized = false;

  /// Defaults embutidos no código (fallback offline)
  // Hashes padrão (fallback) caso o Firebase falhe
  final Map<String, List<String>> _defaultHashes = {
    'com.whatsapp': [
      // Hash real capturado dos logs para garantir funcionamento offline/fallback
      '3987D043D10AEFAF5A8710B3671418FE57E0E19B653C9DF82558FEB5FFCE5D44',
    ],
    'com.android.chrome': ['F0FD6C5B410F25CB25C3B53346C8972FAE30F8EE7411DF910480AD6B2D60DB83'],
    'com.instagram.android': ['5F3E50F435583C9AE626302A71F7340044087A7E2C60ADACFC254205A993E305'],
    'com.facebook.katana': ['E3F9E1E0CF99D0E56A055BA65E241B3399F7CEA524326B0CDD6EC1327ED0FDC1'],
    'org.telegram.messenger': ['49C1522548EBACD46CE322B6FD47F6092BB745D0F88082145CAF35E14DCC38E1'],
    'com.nu.production': ['PLACEHOLDER_NUBANK'],
    'br.com.intermedium': ['PLACEHOLDER_INTER'],
    'com.itau': ['9781EFEBE132B139EF9E3FDFA539E21104B552C14D0BA700B4C6D1D5C0779BEE'],
    'br.gov.meugovbr': ['E133067FC50BDA439C1FC61AA80CD5F238DC65B34D8D303BFF4A33AE2F4705AB'],
  };

  /// Inicializa o Remote Config
  Future<void> initialize() async {
    if (_isInitialized) return;

    try {
      _remoteConfig = FirebaseRemoteConfig.instance;
      
      // Configurar settings
      await _remoteConfig!.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: _fetchTimeout,
          minimumFetchInterval: _minimumFetchInterval,
        ),
      );

      // Definir defaults
      await _remoteConfig!.setDefaults({
        _configKey: jsonEncode(_defaultHashes),
      });

      debugPrint('[TrustedAppHashes] Initialized with defaults');
      
      // Carregar valores atuais
      _loadHashes();
      
      _isInitialized = true;
      
      // Tentar buscar do servidor
      await fetchAndActivate();
    } catch (e) {
      debugPrint('[TrustedAppHashes] Error initializing: $e');
      // Usar defaults em caso de erro
      _hashes = Map.from(_defaultHashes);
      _isInitialized = true;
    }
  }

  /// Busca e ativa novos valores do Firebase
  Future<bool> fetchAndActivate() async {
    if (_remoteConfig == null) {
      debugPrint('[TrustedAppHashes] Not initialized');
      return false;
    }

    try {
      debugPrint('[TrustedAppHashes] Fetching from Firebase...');
      
      final activated = await _remoteConfig!.fetchAndActivate();
      
      if (activated) {
        debugPrint('[TrustedAppHashes] New config activated');
        _loadHashes();
        return true;
      } else {
        debugPrint('[TrustedAppHashes] No new config available');
        return false;
      }
    } catch (e) {
      debugPrint('[TrustedAppHashes] Error fetching: $e');
      // Continuar usando valores atuais/defaults
      return false;
    }
  }

  /// Carrega hashes do Remote Config
  void _loadHashes() {
    try {
      final jsonString = _remoteConfig!.getString(_configKey);
      debugPrint('[TrustedAppHashes] RAW CONFIG ($_configKey): $jsonString');
      
      if (jsonString.isEmpty) {
        debugPrint('[TrustedAppHashes] Empty config, using defaults');
        _hashes = Map.from(_defaultHashes);
        return;
      }

      final Map<String, dynamic> decoded = jsonDecode(jsonString);
      
      // Converter para Map<String, List<String>>
      _hashes = decoded.map((key, value) {
        if (value is List) {
          return MapEntry(key, value.map((e) => e.toString()).toList());
        } else if (value is String) {
          return MapEntry(key, [value]);
        } else {
          return MapEntry(key, <String>[]);
        }
      });

      debugPrint('[TrustedAppHashes] Loaded ${_hashes.length} apps');
    } catch (e) {
      debugPrint('[TrustedAppHashes] Error loading hashes: $e');
      _hashes = Map.from(_defaultHashes);
    }
  }

  /// Obtém hashes válidos para um pacote
  List<String> getHashesForPackage(String packageName) {
    if (!_isInitialized) {
      debugPrint('[TrustedAppHashes] Not initialized, using defaults');
      return _defaultHashes[packageName] ?? [];
    }

    final hashes = _hashes[packageName] ?? [];
    
    // Retornar hashes (incluindo placeholders para fins de UI de "configuração pendente")
    return hashes;
  }

  /// Verifica se um hash é válido para um pacote
  bool isValidHash(String packageName, String actualHash) {
    final validHashes = getHashesForPackage(packageName);
    
    if (validHashes.isEmpty) {
      // Se não tem hashes configurados, considerar válido
      return true;
    }

    return validHashes.contains(actualHash);
  }

  /// Obtém todos os pacotes monitorados
  List<String> getAllMonitoredPackages() {
    // Failsafe: Se estiver vazio, carregar defaults imediatamente
    if (_hashes.isEmpty) {
       debugPrint('[TrustedAppHashes] Hashes empty in getAll, forcing defaults!');
       _hashes = Map.from(_defaultHashes);
    }
    return _hashes.keys.toList();
  }

  /// Obtém todos os apps confiáveis
  List<TrustedAppInfo> getAllTrustedApps() {
    return getAllMonitoredPackages().map((pkg) {
      return TrustedAppInfo(
        packageName: pkg,
        name: _getAppName(pkg),
        validHashes: getHashesForPackage(pkg),
        category: _getAppCategory(pkg),
      );
    }).toList();
  }



  /// Obtém nome amigável do app
  String _getAppName(String packageName) {
    const names = {
      'com.whatsapp': 'WhatsApp',
      'com.instagram.android': 'Instagram',
      'com.facebook.katana': 'Facebook',
      'org.telegram.messenger': 'Telegram',
      'com.nu.production': 'Nubank',
      'br.com.intermedium': 'Banco Inter',
      'com.itau': 'Itaú',
      'br.gov.meugovbr': 'Gov.br',
    };
    
    return names[packageName] ?? packageName;
  }

  /// Obtém categoria do app
  String _getAppCategory(String packageName) {
    if (packageName.contains('whatsapp') || 
        packageName.contains('instagram') ||
        packageName.contains('facebook') ||
        packageName.contains('telegram')) {
      return 'social';
    }
    
    if (packageName.contains('nu.production') ||
        packageName.contains('intermedium') ||
        packageName.contains('itau') ||
        packageName.contains('bradesco') ||
        packageName.contains('santander') ||
        packageName.contains('bb.android')) {
      return 'financial';
    }
    
    if (packageName.contains('gov.br')) {
      return 'government';
    }
    
    return 'other';
  }

  /// Verifica se é app brasileiro
  bool _isBrazilianApp(String packageName) {
    return packageName.startsWith('br.') ||
           packageName.contains('nu.production') ||
           packageName.contains('itau') ||
           packageName.contains('bradesco') ||
           packageName.contains('santander');
  }

  /// Status da última busca
  RemoteConfigFetchStatus get lastFetchStatus {
    return _remoteConfig?.lastFetchStatus ?? RemoteConfigFetchStatus.noFetchYet;
  }

  /// Timestamp da última busca bem-sucedida
  DateTime get lastFetchTime {
    return _remoteConfig?.lastFetchTime ?? DateTime.fromMillisecondsSinceEpoch(0);
  }

  /// Força atualização imediata
  Future<bool> forceUpdate() async {
    if (_remoteConfig == null) return false;

    try {
      // Temporariamente reduzir intervalo mínimo para 0
      await _remoteConfig!.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: _fetchTimeout,
          minimumFetchInterval: Duration.zero,
        ),
      );

      final result = await fetchAndActivate();

      // Restaurar intervalo normal
      await _remoteConfig!.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: _fetchTimeout,
          minimumFetchInterval: _minimumFetchInterval,
        ),
      );

      return result;
    } catch (e) {
      debugPrint('[TrustedAppHashes] Error forcing update: $e');
      return false;
    }
  }

  /// Reseta para defaults
  Future<void> resetToDefaults() async {
    _hashes = Map.from(_defaultHashes);
    debugPrint('[TrustedAppHashes] Reset to defaults');
  }
}

/// Informações de um app confiável
class TrustedAppInfo {
  final String packageName;
  final List<String> validHashes;
  final String name;
  final String category;

  TrustedAppInfo({
    required this.packageName,
    required this.validHashes,
    required this.name,
    required this.category,
  });

  bool hasValidHashes() => validHashes.isNotEmpty;
}
