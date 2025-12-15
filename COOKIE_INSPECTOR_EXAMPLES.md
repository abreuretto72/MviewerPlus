# 🍪 Cookie Inspector - Exemplos de Uso

## Exemplos Práticos de Código

### 1. Usando o CookieInspectorProvider

```dart
import 'package:provider/provider.dart';
import 'package:file_viewer/features/cookies/presentation/providers/cookie_inspector_provider.dart';

// Em um Widget
class MeuWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CookieInspectorProvider>();
    
    return Column(
      children: [
        Text('Total de cookies HTTP: ${provider.httpCookies.length}'),
        ElevatedButton(
          onPressed: () async {
            await provider.loadHttpCookies('https://example.com');
          },
          child: Text('Carregar Cookies'),
        ),
      ],
    );
  }
}
```

### 2. Analisando Segurança de um Cookie

```dart
import 'package:file_viewer/features/cookies/domain/models/cookie_entry.dart';
import 'package:file_viewer/features/cookies/domain/security/cookie_security_guard.dart';

void analisarCookie(CookieEntry cookie) {
  final analysis = CookieSecurityGuard.analyze(cookie);
  
  print('Cookie: ${cookie.name}');
  print('Risco: ${analysis.riskLevel.name}');
  print('Pontuação: ${analysis.riskScore}');
  print('É sensível: ${analysis.isSensitive}');
  
  if (analysis.signals.isNotEmpty) {
    print('Sinais detectados:');
    for (final signal in analysis.signals) {
      print('  - $signal');
    }
  }
}

// Exemplo de uso
void main() {
  final cookie = CookieEntry(
    source: CookieSource.http,
    name: 'access_token',
    value: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...',
    domain: 'example.com',
    secure: true,
    httpOnly: true,
  );
  
  analisarCookie(cookie);
  // Output:
  // Cookie: access_token
  // Risco: high
  // Pontuação: 90
  // É sensível: true
  // Sinais detectados:
  //   - Token de acesso detectado: access_token
  //   - JWT (JSON Web Token) detectado
  //   - Flag httpOnly ativada (boa prática de segurança)
  //   - Flag secure ativada (boa prática de segurança)
}
```

### 3. Exportando Cookies para JSON

```dart
import 'package:file_viewer/features/cookies/presentation/providers/cookie_inspector_provider.dart';

Future<void> exportarCookies(CookieInspectorProvider provider) async {
  final cookies = provider.httpCookies;
  
  // Exportar com valores mascarados
  final jsonMasked = provider.exportToJson(
    cookies: cookies,
    source: 'http',
    maskSensitiveValues: true,
  );
  
  print('JSON Mascarado:');
  print(jsonMasked);
  
  // Exportar com valores reais (requer autenticação)
  final authenticated = await provider.authenticate('Exportar valores reais');
  if (authenticated) {
    final jsonReal = provider.exportToJson(
      cookies: cookies,
      source: 'http',
      maskSensitiveValues: false,
    );
    
    print('JSON Real:');
    print(jsonReal);
  }
}
```

### 4. Configurando Autenticação

```dart
import 'package:file_viewer/features/cookies/data/services/auth_service.dart';

Future<void> configurarAutenticacao() async {
  final authService = AuthService();
  
  // Verificar se dispositivo suporta biometria
  final canUseBiometric = await authService.canCheckBiometrics();
  print('Suporta biometria: $canUseBiometric');
  
  if (canUseBiometric) {
    // Obter tipos disponíveis
    final biometrics = await authService.getAvailableBiometrics();
    print('Biometrias disponíveis: $biometrics');
    
    // Habilitar biometria
    await authService.setBiometricEnabled(true);
  }
  
  // Configurar PIN como fallback
  final pinSet = await authService.setPin('1234');
  print('PIN configurado: $pinSet');
  
  // Validar PIN
  final valid = await authService.validatePin('1234');
  print('PIN válido: $valid');
}
```

### 5. Criando um Cookie Personalizado

```dart
import 'package:file_viewer/features/cookies/domain/models/cookie_entry.dart';

void criarCookiePersonalizado() {
  final cookie = CookieEntry(
    source: CookieSource.http,
    name: 'meu_cookie',
    value: 'valor_secreto',
    domain: 'meusite.com',
    path: '/',
    expires: DateTime.now().add(Duration(days: 30)),
    secure: true,
    httpOnly: true,
    sameSite: 'Strict',
    creationTime: DateTime.now(),
  );
  
  print('Cookie criado:');
  print('Nome: ${cookie.name}');
  print('Valor mascarado: ${cookie.maskedValue}');
  print('Expira em: ${cookie.expires}');
  print('Está expirado: ${cookie.isExpired}');
  
  // Serializar para JSON
  final json = cookie.toJson();
  print('JSON: $json');
  
  // Deserializar de JSON
  final cookieFromJson = CookieEntry.fromJson(json);
  print('Cookie restaurado: ${cookieFromJson.name}');
}
```

### 6. Gerenciando Cookies HTTP

```dart
import 'package:file_viewer/features/cookies/data/services/http_cookie_service.dart';

Future<void> gerenciarCookiesHttp() async {
  final service = HttpCookieService();
  await service.initialize();
  
  // Listar cookies de uma URL
  final cookies = await service.getCookiesForUri('https://example.com');
  print('Cookies encontrados: ${cookies.length}');
  
  // Adicionar um novo cookie
  await service.setCookie(
    url: 'https://example.com',
    name: 'session_id',
    value: 'abc123',
    secure: true,
    httpOnly: true,
  );
  
  // Obter estatísticas
  final stats = await service.getStatistics();
  print('Total de cookies: ${stats['total_cookies']}');
  print('Total de domínios: ${stats['total_domains']}');
  print('Cookies secure: ${stats['secure_cookies']}');
  
  // Deletar um cookie
  await service.deleteCookie(
    url: 'https://example.com',
    name: 'session_id',
  );
  
  // Deletar todos os cookies
  await service.deleteAllCookies();
}
```

### 7. Trabalhando com WebView Cookies

```dart
import 'package:webview_flutter/webview_flutter.dart';
import 'package:file_viewer/features/cookies/data/services/webview_cookie_service.dart';

Future<void> gerenciarCookiesWebView(WebViewController controller) async {
  final service = WebViewCookieService();
  
  // Obter cookies via JavaScript
  final cookies = await service.getCookiesFromJavaScript(
    controller,
    'https://example.com',
  );
  
  print('Cookies do WebView: ${cookies.length}');
  
  // Criar backup
  final backup = await service.createBackup(controller, 'https://example.com');
  print('Backup criado com ${backup.length} cookies');
  
  // Definir um cookie
  await service.setCookie(
    url: 'https://example.com',
    name: 'user_pref',
    value: 'dark_mode',
  );
  
  // Restaurar backup
  await service.restoreFromBackup(
    url: 'https://example.com',
    backup: backup,
  );
  
  // Limpar todos os cookies
  await service.clearAllCookies();
  
  // Obter aviso de limitações
  final warning = service.getLimitationsWarning();
  print(warning);
}
```

### 8. Gerando Relatório de Segurança

```dart
import 'package:file_viewer/features/cookies/presentation/providers/cookie_inspector_provider.dart';

void gerarRelatorioSeguranca(CookieInspectorProvider provider) {
  final allCookies = [
    ...provider.httpCookies,
    ...provider.webViewCookies,
  ];
  
  final report = provider.generateSecurityReport(allCookies);
  
  print(report);
  // Output:
  // === COOKIE SECURITY REPORT ===
  //
  // Generated: 2025-12-15 08:30:20.000
  //
  // SUMMARY:
  // Total Cookies: 15
  // High Risk: 3
  // Medium Risk: 5
  // Low Risk: 4
  // No Risk: 3
  //
  // SENSITIVE COOKIES DETECTED:
  // - access_token (api.example.com): Token de acesso detectado, JWT detectado
  // - session_id (example.com): Cookie de sessão/autenticação detectado
  // - oauth_token (auth.example.com): Cookie OAuth/OpenID detectado
}
```

### 9. Exportando para PDF

```dart
import 'package:file_viewer/features/cookies/presentation/providers/cookie_inspector_provider.dart';

Future<void> exportarParaPdf(CookieInspectorProvider provider) async {
  final cookies = provider.httpCookies;
  
  // Exportar com valores mascarados
  await provider.exportToPdf(
    cookies: cookies,
    source: 'HTTP',
    maskSensitiveValues: true,
  );
  
  // O PDF será exibido automaticamente para impressão/salvamento
  // usando o pacote 'printing'
}
```

### 10. Fluxo Completo de Uso

```dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:file_viewer/features/cookies/presentation/providers/cookie_inspector_provider.dart';

class ExemploCompletoScreen extends StatefulWidget {
  @override
  _ExemploCompletoScreenState createState() => _ExemploCompletoScreenState();
}

class _ExemploCompletoScreenState extends State<ExemploCompletoScreen> {
  final _urlController = TextEditingController();
  
  @override
  void initState() {
    super.initState();
    // Inicializar provider
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CookieInspectorProvider>().initialize();
    });
  }
  
  Future<void> _analisarCookies() async {
    final provider = context.read<CookieInspectorProvider>();
    final url = _urlController.text;
    
    // 1. Carregar cookies
    await provider.loadHttpCookies(url);
    
    // 2. Analisar cada cookie
    for (final cookie in provider.httpCookies) {
      final analysis = provider.getSecurityAnalysis(cookie);
      
      print('Cookie: ${cookie.name}');
      print('Risco: ${analysis.riskLevel.name}');
      
      // 3. Se for sensível, proteger
      if (analysis.isSensitive) {
        print('⚠️ Cookie sensível detectado!');
        print('Sinais: ${analysis.signals.join(', ')}');
      }
    }
    
    // 4. Gerar relatório
    final report = provider.generateSecurityReport(provider.httpCookies);
    print(report);
    
    // 5. Exportar (com autenticação se necessário)
    final authenticated = await provider.authenticate('Exportar cookies');
    if (authenticated) {
      final json = provider.exportToJson(
        cookies: provider.httpCookies,
        source: 'HTTP',
        maskSensitiveValues: false,
      );
      print('Cookies exportados: $json');
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Exemplo Completo')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _urlController,
              decoration: InputDecoration(
                labelText: 'URL',
                hintText: 'https://example.com',
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _analisarCookies,
              child: Text('Analisar Cookies'),
            ),
            SizedBox(height: 16),
            Consumer<CookieInspectorProvider>(
              builder: (context, provider, child) {
                if (provider.isLoading) {
                  return CircularProgressIndicator();
                }
                
                return Expanded(
                  child: ListView.builder(
                    itemCount: provider.httpCookies.length,
                    itemBuilder: (context, index) {
                      final cookie = provider.httpCookies[index];
                      final analysis = provider.getSecurityAnalysis(cookie);
                      
                      return ListTile(
                        leading: Text(
                          CookieSecurityGuard.getRiskIcon(analysis.riskLevel),
                          style: TextStyle(fontSize: 24),
                        ),
                        title: Text(cookie.name),
                        subtitle: Text(cookie.domain),
                        trailing: Text(analysis.riskLevel.name),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
  
  @override
  void dispose() {
    _urlController.dispose();
    super.dispose();
  }
}
```

---

## Casos de Uso Reais

### Caso 1: Debugar Problemas de Sessão

```dart
// Usuário reporta que está sendo deslogado constantemente
Future<void> debugarSessao(String url) async {
  final provider = CookieInspectorProvider();
  await provider.initialize();
  await provider.loadHttpCookies(url);
  
  // Procurar cookies de sessão
  for (final cookie in provider.httpCookies) {
    if (cookie.name.toLowerCase().contains('session')) {
      print('Cookie de sessão encontrado: ${cookie.name}');
      print('Expira em: ${cookie.expires}');
      print('Está expirado: ${cookie.isExpired}');
      
      if (cookie.isExpired) {
        print('⚠️ PROBLEMA: Cookie de sessão expirado!');
      }
    }
  }
}
```

### Caso 2: Auditoria de Segurança

```dart
// Verificar se há cookies inseguros
Future<void> auditarSeguranca(String url) async {
  final provider = CookieInspectorProvider();
  await provider.initialize();
  await provider.loadHttpCookies(url);
  
  final problemas = <String>[];
  
  for (final cookie in provider.httpCookies) {
    final analysis = provider.getSecurityAnalysis(cookie);
    
    // Verificar cookies sensíveis sem flags de segurança
    if (analysis.isSensitive) {
      if (!cookie.secure) {
        problemas.add('${cookie.name}: Cookie sensível sem flag SECURE');
      }
      if (!cookie.httpOnly) {
        problemas.add('${cookie.name}: Cookie sensível sem flag HTTPONLY');
      }
      if (cookie.sameSite == null || cookie.sameSite == 'None') {
        problemas.add('${cookie.name}: Cookie sensível sem SameSite adequado');
      }
    }
  }
  
  if (problemas.isNotEmpty) {
    print('⚠️ PROBLEMAS DE SEGURANÇA ENCONTRADOS:');
    for (final problema in problemas) {
      print('  - $problema');
    }
  } else {
    print('✅ Nenhum problema de segurança encontrado');
  }
}
```

### Caso 3: Migração de Cookies

```dart
// Migrar cookies de um domínio para outro
Future<void> migrarCookies(String oldUrl, String newUrl) async {
  final provider = CookieInspectorProvider();
  await provider.initialize();
  
  // Carregar cookies do domínio antigo
  await provider.loadHttpCookies(oldUrl);
  final backup = List<CookieEntry>.from(provider.httpCookies);
  
  print('Cookies a migrar: ${backup.length}');
  
  // Criar novos cookies no domínio novo
  for (final cookie in backup) {
    final newCookie = cookie.copyWith(
      domain: Uri.parse(newUrl).host,
    );
    
    await provider.setHttpCookie(url: newUrl, cookie: newCookie);
    print('Migrado: ${cookie.name}');
  }
  
  print('✅ Migração concluída');
}
```

---

## Dicas e Boas Práticas

### 1. Sempre Inicialize o Provider

```dart
@override
void initState() {
  super.initState();
  WidgetsBinding.instance.addPostFrameCallback((_) {
    context.read<CookieInspectorProvider>().initialize();
  });
}
```

### 2. Use Consumer para Reatividade

```dart
Consumer<CookieInspectorProvider>(
  builder: (context, provider, child) {
    if (provider.isLoading) return CircularProgressIndicator();
    if (provider.error != null) return Text('Erro: ${provider.error}');
    return MeuWidget(cookies: provider.httpCookies);
  },
)
```

### 3. Trate Erros Adequadamente

```dart
try {
  await provider.loadHttpCookies(url);
} catch (e) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('Erro ao carregar cookies: $e')),
  );
}
```

### 4. Sempre Autentique Ações Sensíveis

```dart
final authenticated = await provider.authenticate('Ação sensível');
if (!authenticated) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('Autenticação necessária')),
  );
  return;
}
// Prosseguir com ação
```

### 5. Use Cache de Análise

```dart
// O provider já faz cache automaticamente
final analysis = provider.getSecurityAnalysis(cookie);
// Chamadas subsequentes usam o cache
```

---

**Desenvolvido por**: Multiverso Digital  
**Versão**: 1.0.0
