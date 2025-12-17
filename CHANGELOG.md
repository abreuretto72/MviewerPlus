# Changelog

Todas as mudanças notáveis neste projeto serão documentadas neste arquivo.

O formato é baseado em [Keep a Changelog](https://keepachangelog.com/pt-BR/1.0.0/),
e este projeto adere ao [Semantic Versioning](https://semver.org/lang/pt-BR/).

---

## [7.0.2] - 2025-12-17
### Added
- **Integration Tests**: Added `integration_test` dependency and infrastructure.
- **Dependency Injection**: Introduced `FilePickerService` and Provider injection in `HomeScreen` for better testability.

### Fixed
- **Localization**: Completed missing translation keys for Spanish (`es`), Portuguese Portugal (`pt_PT`) and Portuguese Brazil (`pt_BR`).
  - Resolved Google Play Console validation errors.
- **Testing**: Fixed `GoogleFonts` runtime fetching issues in test environments.

## [7.0.1] - 2025-12-16
### Added
- **Certificate Support**: Suporte leitura de arquivos de certificado (`.crt`, `.cer`, `.pem`, `.der`, `.p12`, `.pfx`).
  - Visualização de texto para formatos PEM/CRT.
  - Identificação de formatos binários (DER/P12).
  - Proteção "Somente Leitura" para preservar integridade.

### Changed
- **UI Tweaks**: Ícone de "Configurações" removido do cabeçalho da tela principal (já disponível no menu lateral) para uma interface mais limpa.
- **Build System**: Ajustes na configuração de build Android para geração de APK Release.

---

## [7.0.0] - 2025-12-15

### 🎉 Major Release - Antigravity Scanner

Esta versão marca a transformação completa do MViewerPlus em um **Antigravity Scanner** com sistema avançado de auditoria de segurança.

### Added

#### 🛡️ Security Scanner Module
- **18 verificações de segurança** implementadas via Platform Channels
- Dashboard de segurança com score de risco (0-100)
- Semáforo visual (🔴🟡🟢) para nível de segurança
- Ações recomendadas com botões para configurações

#### 🔴 Módulo A: Integridade do Dispositivo
- Root/Jailbreak Detection (10 binários + 7 apps)
- Debugger Detection (Debug.isDebuggerConnected)
- Hooking Framework Detection (Frida, Xposed, portas)
- Emulator Detection (fingerprints, hardware)
- App Integrity Check (assinatura APK)
- USB Debugging Detection (Settings.Global.ADB_ENABLED)

#### 🔴 Módulo B: Segurança de Rede
- SSL Pinning (certificate validation)
- Proxy Detection (System.getProperty + Wi-Fi)
- Wi-Fi Security Check (WEP/WPA/WPA2/WPA3)

#### 🟡 Módulo C: Auditoria de Apps e Sistema
- Screen Lock Check (KeyguardManager)
- OS Version Check (Android < 10)
- Security Patch Age Check (>60 dias)
- Unknown Sources Check (canRequestPackageInstalls)
- Location Permissions Audit (ACCESS_BACKGROUND_LOCATION)
- Lock Screen Notifications Check (lock_screen_show_notifications)
- Sideloading Detection (8 apps sensíveis)
- Third-Party Keyboards Detection (InputMethodManager)
- Accessibility Abuse Detection (AccessibilityManager)

#### 🔥 Módulo D: Validação de Assinaturas
- Firebase Remote Config integration
- TrustedAppHashesService para gerenciar hashes
- Validação SHA-256 de assinaturas de apps
- 12 apps monitorados (WhatsApp, Instagram, Facebook, Telegram, Nubank, Inter, Itaú, Gov.br, Bradesco, Santander, BB, Mercado Livre)
- Defaults embutidos para funcionamento offline
- Atualização remota de hashes sem nova versão

#### 📱 Native Code (Kotlin)
- MainActivity.kt expandido com 19 métodos nativos
- Platform Channel `com.multiversodigital.mviewerplus/security`
- Implementações nativas para todas as verificações
- Método `checkAppSignature()` para validação SHA-256

#### 📚 Documentação
- `SECURITY_MODULE_IMPLEMENTATION.md` - Implementação do módulo
- `SECURITY_POSTURE_ANALYSIS.md` - Análise de postura (P-1 a P-6)
- `MASTER_PROMPT_STATUS.md` - Status do Master Prompt
- `TECHNICAL_SPECIFICATION_STATUS.md` - Status da especificação técnica
- `GLOBAL_SPEC_COMPLIANCE.md` - Conformidade com spec global
- `IMPLEMENTATION_COMPLETE.md` - Implementação 100%
- `FINAL_IMPLEMENTATION.md` - Implementação final
- `FIREBASE_REMOTE_CONFIG_GUIDE.md` - Guia do Firebase
- `TRUSTED_APP_HASHES_EXAMPLE.md` - Exemplo de hashes
- `SIGNATURE_VALIDATION_CONFIGURED.md` - Validação configurada
- `FIREBASE_SETUP_PENDING.md` - Setup do Firebase

### Changed

#### 🗑️ Removed Cookie Scanner
- Removido módulo completo de Cookie Scanner (17 arquivos)
- Removido `lib/features/cookie_scanner/`
- Removido provider `CookieInspectorProvider`
- Removido item de menu "Cookie Scanner"
- **Motivo**: Sandboxing do Android 10+ torna ineficaz

#### 🔄 Refatorações
- `SecurityService` expandido com novas ações
- `SecurityCheckResult` com novos campos
- `SecurityCheckScreen` com dashboard completo
- `home_screen.dart` com menu atualizado

### Dependencies

#### Added
- `firebase_core: ^3.8.1` - Firebase infrastructure
- `firebase_remote_config: ^5.1.4` - Remote configuration
- `crypto: ^3.0.6` - Cryptographic functions
- `local_auth: ^2.3.0` - Biometric authentication

#### Updated
- Todas as dependências atualizadas para versões compatíveis

### Permissions

#### Android Manifest
- `android.permission.QUERY_ALL_PACKAGES` - Listar apps instalados
- `android.permission.ACCESS_WIFI_STATE` - Verificar Wi-Fi
- `android.permission.ACCESS_NETWORK_STATE` - Verificar rede

### Technical Details

#### Metrics
- **Dart Code**: ~1.500 linhas
- **Kotlin Code**: ~600 linhas
- **Total**: ~2.100 linhas
- **Security Checks**: 18
- **Monitored Apps**: 12
- **Files Created**: 14
- **Files Modified**: 9
- **Files Deleted**: 17

#### Performance
- Cache de 5 minutos para resultados
- Verificações assíncronas (Future.wait)
- Timeout de 10s para Remote Config

### Known Issues

#### ⚠️ Pending
- [ ] Firebase `google-services.json` não configurado
- [ ] Hashes de apps são exemplos (precisam ser reais)
- [ ] iOS support não implementado (apenas Android)
- [ ] Traduções incompletas (es, pt, pt_PT)

#### 🐛 Bugs
- Erro de compilação Kotlin (em investigação)
- SSL Pinning precisa de hashes reais de certificados

### Security

#### Critical Alerts (🔴)
- Root/Jailbreak → Bloqueia funcionalidades críticas
- Debugger → Alerta e registra
- Hooking → Alerta e registra
- USB Debugging → Alerta crítico
- Proxy → Alerta de interceptação

#### Warnings (🟡)
- OS desatualizado → Recomenda atualização
- Wi-Fi inseguro → Sugere WPA2/WPA3
- Apps sideloaded → Lista apps suspeitos
- Teclados terceiros → Alerta de keylogger
- Acessibilidade → Alerta de abuso

### Migration Guide

#### From v6.x to v7.0

1. **Cookie Scanner Removed**
   ```dart
   // ANTES
   Navigator.push(context, CookieInspectorScreen());
   
   // DEPOIS
   Navigator.push(context, SecurityCheckScreen());
   ```

2. **New Security Check**
   ```dart
   // Executar verificação
   final result = await NativeSecurityChecker.performFullSecurityCheck();
   
   // Ver score
   print('Risk Score: ${result.riskScore}/100');
   ```

3. **Firebase Setup** (Opcional)
   ```dart
   // Adicionar ao main.dart
   await Firebase.initializeApp();
   await TrustedAppHashesService.instance.initialize();
   ```

---

## [6.x.x] - Versões Anteriores

### [6.5.0] - 2025-12-10
- Adicionado suporte a vídeo (video_player, chewie)
- Adicionado suporte a áudio (audioplayers)
- Melhorias no visualizador de PDF

### [6.0.0] - 2025-12-01
- Adicionado AI Chat (Google Gemini)
- Suporte a múltiplos idiomas (i18n)
- Material Design 3

### [5.0.0] - 2025-11-15
- Cookie Scanner (DESCONTINUADO em v7.0)
- Visualizador de arquivos base

---

## Tipos de Mudanças

- `Added` - Novas funcionalidades
- `Changed` - Mudanças em funcionalidades existentes
- `Deprecated` - Funcionalidades que serão removidas
- `Removed` - Funcionalidades removidas
- `Fixed` - Correções de bugs
- `Security` - Correções de vulnerabilidades

---

**Desenvolvido por**: Multiverso Digital  
**Versão Atual**: 7.0.0  
**Data**: Dezembro 2025
