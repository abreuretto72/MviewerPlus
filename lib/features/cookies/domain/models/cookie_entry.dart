/// Enumeração para identificar a fonte do cookie
enum CookieSource {
  webview,
  http,
}

/// Modelo unificado para representar cookies de diferentes fontes
class CookieEntry {
  final CookieSource source;
  final String name;
  final String value;
  final String domain;
  final String path;
  final DateTime? expires;
  final bool secure;
  final bool httpOnly;
  final String? sameSite;
  final DateTime? creationTime;
  final DateTime? lastAccessTime;

  CookieEntry({
    required this.source,
    required this.name,
    required this.value,
    required this.domain,
    this.path = '/',
    this.expires,
    this.secure = false,
    this.httpOnly = false,
    this.sameSite,
    this.creationTime,
    this.lastAccessTime,
  });

  /// Cria um CookieEntry a partir de um cookie HTTP (dart:io Cookie)
  factory CookieEntry.fromHttpCookie(
    dynamic cookie,
    CookieSource source,
  ) {
    return CookieEntry(
      source: source,
      name: cookie.name,
      value: cookie.value,
      domain: cookie.domain ?? '',
      path: cookie.path ?? '/',
      expires: cookie.expires,
      secure: cookie.secure,
      httpOnly: cookie.httpOnly,
      sameSite: _parseSameSite(cookie),
      creationTime: DateTime.now(),
    );
  }

  /// Cria um CookieEntry a partir de dados do WebView
  factory CookieEntry.fromWebView({
    required String name,
    required String value,
    required String domain,
    String path = '/',
    DateTime? expires,
    bool secure = false,
    bool httpOnly = false,
    String? sameSite,
  }) {
    return CookieEntry(
      source: CookieSource.webview,
      name: name,
      value: value,
      domain: domain,
      path: path,
      expires: expires,
      secure: secure,
      httpOnly: httpOnly,
      sameSite: sameSite,
      creationTime: DateTime.now(),
    );
  }

  /// Converte para Map para serialização
  Map<String, dynamic> toJson() {
    return {
      'source': source.name,
      'name': name,
      'value': value,
      'domain': domain,
      'path': path,
      'expires': expires?.toIso8601String(),
      'secure': secure,
      'httpOnly': httpOnly,
      'sameSite': sameSite,
      'creationTime': creationTime?.toIso8601String(),
      'lastAccessTime': lastAccessTime?.toIso8601String(),
    };
  }

  /// Cria um CookieEntry a partir de JSON
  factory CookieEntry.fromJson(Map<String, dynamic> json) {
    return CookieEntry(
      source: CookieSource.values.firstWhere(
        (e) => e.name == json['source'],
        orElse: () => CookieSource.http,
      ),
      name: json['name'] ?? '',
      value: json['value'] ?? '',
      domain: json['domain'] ?? '',
      path: json['path'] ?? '/',
      expires: json['expires'] != null
          ? DateTime.parse(json['expires'])
          : null,
      secure: json['secure'] ?? false,
      httpOnly: json['httpOnly'] ?? false,
      sameSite: json['sameSite'],
      creationTime: json['creationTime'] != null
          ? DateTime.parse(json['creationTime'])
          : null,
      lastAccessTime: json['lastAccessTime'] != null
          ? DateTime.parse(json['lastAccessTime'])
          : null,
    );
  }

  /// Cria uma cópia do cookie com valores modificados
  CookieEntry copyWith({
    CookieSource? source,
    String? name,
    String? value,
    String? domain,
    String? path,
    DateTime? expires,
    bool? secure,
    bool? httpOnly,
    String? sameSite,
    DateTime? creationTime,
    DateTime? lastAccessTime,
  }) {
    return CookieEntry(
      source: source ?? this.source,
      name: name ?? this.name,
      value: value ?? this.value,
      domain: domain ?? this.domain,
      path: path ?? this.path,
      expires: expires ?? this.expires,
      secure: secure ?? this.secure,
      httpOnly: httpOnly ?? this.httpOnly,
      sameSite: sameSite ?? this.sameSite,
      creationTime: creationTime ?? this.creationTime,
      lastAccessTime: lastAccessTime ?? this.lastAccessTime,
    );
  }

  /// Retorna o valor mascarado do cookie
  String get maskedValue {
    if (value.length <= 8) {
      return '***';
    }
    return '${value.substring(0, 4)}...${value.substring(value.length - 4)}';
  }

  /// Verifica se o cookie está expirado
  bool get isExpired {
    if (expires == null) return false;
    return DateTime.now().isAfter(expires!);
  }

  static String? _parseSameSite(dynamic cookie) {
    try {
      // Tenta acessar a propriedade sameSite se existir
      final sameSite = cookie.sameSite;
      if (sameSite != null) {
        return sameSite.toString();
      }
    } catch (e) {
      // Propriedade não existe ou erro ao acessar
    }
    return null;
  }

  @override
  String toString() {
    return 'CookieEntry(name: $name, domain: $domain, source: ${source.name})';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CookieEntry &&
        other.name == name &&
        other.domain == domain &&
        other.path == path;
  }

  @override
  int get hashCode => Object.hash(name, domain, path);
}
