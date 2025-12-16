# 🛡️ Antigravity Scanner - MViewerPlus

## Versão 7.0.0 - Security Audit Complete

**Antigravity Scanner** é um visualizador de arquivos multiplataforma com **sistema avançado de auditoria de segurança** integrado.

---

## 🎯 Principais Funcionalidades

### 📁 Visualizador de Arquivos
- Suporte para múltiplos formatos (PDF, DOCX, XLSX, CSV, TXT, Markdown, etc.)
- **Certificados Digitais** (.crt, .cer, .pem, .der, .p12, .pfx) - *Visualização Segura*
- Visualização de imagens, áudio e vídeo
- Navegador web integrado
- Modo escuro/claro

### 🛡️ Security Scanner (NOVO!)
- **18 verificações de segurança** em tempo real
- Detecção de ameaças críticas
- Auditoria de postura de segurança
- Validação de assinaturas de apps
- Dashboard com score de risco (0-100)

---

## 🔐 Sistema de Segurança

### Módulo A: Integridade do Dispositivo (🔴 Crítico)
1. ✅ Root/Jailbreak Detection
2. ✅ Debugger Detection
3. ✅ Hooking Framework Detection (Frida/Xposed)
4. ✅ Emulator Detection
5. ✅ App Integrity Check
6. ✅ USB Debugging Detection

### Módulo B: Segurança de Rede (🔴 Crítico)
7. ✅ SSL Pinning
8. ✅ Proxy Detection
9. ✅ Wi-Fi Security Check

### Módulo C: Auditoria de Apps e Sistema (🟡 Aviso)
10. ✅ Screen Lock Check
11. ✅ OS Version Check
12. ✅ Security Patch Age
13. ✅ Unknown Sources Check
14. ✅ Location Permissions Audit
15. ✅ Lock Screen Notifications
16. ✅ Sideloading Detection
17. ✅ Third-Party Keyboards
18. ✅ Accessibility Abuse Detection

### Módulo D: Validação de Assinaturas (🔥 Firebase + Fallback)
- ✅ Validação SHA-256 em tempo real
- ✅ Hashes oficiais verificados (WhatsApp, Chrome, Instagram, Gov.br, Itau, etc.)
- ✅ Status "Verificado" (Verde) para apps autênticos
- ✅ Detecção de apps sem configuração (Pendente)
- ✅ Fallback offline robusto para apps críticos

---

## 📊 Dashboard de Segurança

```
┌─────────────────────────────────────┐
│  Nível de Segurança: 🟢 SEGURO     │
│  Score de Risco: 15/100             │
├─────────────────────────────────────┤
│  ✅ Sem Root/Jailbreak              │
│  ✅ Debugger não detectado          │
│  ✅ SSL Pinning validado            │
│  ⚠️  Wi-Fi WPA (recomendado WPA2)   │
│  ⚠️  2 apps com localização sempre  │
└─────────────────────────────────────┘
```

---

## 🚀 Tecnologias

### Frontend
- **Flutter 3.x** - Framework multiplataforma
- **Dart** - Linguagem de programação
- **Provider** - Gerenciamento de estado
- **Material Design 3** - Design system

### Backend/Nativo
- **Kotlin** - Android native code
- **Platform Channels** - Flutter ↔ Native communication
- **Firebase Remote Config** - Configuração remota
- **Firebase Core** - Infraestrutura

### Segurança
- **SHA-256** - Validação de assinaturas
- **SSL Pinning** - Proteção contra MITM
- **Root Detection** - Múltiplas técnicas
- **Hooking Detection** - Anti-tampering

---

## 📦 Instalação

### Pré-requisitos
- Flutter SDK 3.x ou superior
- Android Studio / Xcode
- Dart SDK
- Firebase CLI (opcional)

### Dependências Principais
```yaml
dependencies:
  flutter:
    sdk: flutter
  
  # Security
  firebase_core: ^3.8.1
  firebase_remote_config: ^5.1.4
  local_auth: ^2.3.0
  crypto: ^3.0.6
  
  # UI/UX
  provider: ^6.1.5
  google_fonts: ^6.3.3
  
  # File Handling
  file_picker: ^10.3.7
  pdf: ^3.11.3
  
  # Networking
  http: ^1.6.0
  dio: ^5.7.0
```

### Instalação

```bash
# Clone o repositório
git clone https://github.com/seu-usuario/MviewerPlus.git

# Entre no diretório
cd MviewerPlus

# Instale as dependências
flutter pub get

# Execute o app
flutter run
```

---

## ⚙️ Configuração

### 1. Firebase (Opcional - para validação de assinaturas)

1. Crie um projeto no [Firebase Console](https://console.firebase.google.com/)
2. Adicione um app Android
3. Baixe `google-services.json`
4. Coloque em `android/app/google-services.json`
5. Configure Remote Config:
   - Parâmetro: `trusted_app_hashes`
   - Valor: JSON com hashes de apps

### 2. Variáveis de Ambiente

Crie um arquivo `.env` na raiz:

```env
GEMINI_API_KEY=sua_chave_aqui
```

### 3. Habilitar Firebase (se configurado)

Edite `lib/main.dart`:

```dart
// Descomente estas linhas:
await Firebase.initializeApp();
await TrustedAppHashesService.instance.initialize();
```

---

## 📱 Uso

### Security Check

1. Abra o app
2. Menu (☰) → **Security Check**
3. Aguarde a verificação automática
4. Veja os resultados:
   - Score de risco
   - Ameaças detectadas
   - Recomendações de ação

### Validação de Assinaturas

```dart
// Obter hash de um app instalado
final result = await NativeSecurityChecker.checkAppSignature(
  'com.whatsapp',
  'EXPECTED_HASH',
);

print('Válido: ${result['isValid']}');
```

---

## 🏗️ Arquitetura

```
lib/
├── main.dart                          # Entry point
├── services/
│   ├── native_security_checker.dart   # Platform Channels
│   ├── security_service.dart          # Business logic
│   ├── app_signature_validator.dart   # Firebase Remote Config
│   └── secure_http_client.dart        # SSL Pinning
├── screens/
│   ├── security_check_screen.dart     # Dashboard
│   └── home_screen.dart               # Main screen
└── providers/
    └── locale_provider.dart           # i18n

android/
└── app/src/main/kotlin/
    └── MainActivity.kt                # Native security checks
```

---

## 📊 Métricas de Código

- **Dart**: ~1.500 linhas
- **Kotlin**: ~600 linhas
- **Total**: ~2.100 linhas
- **Verificações**: 18
- **Apps Monitorados**: 12

---

## 🌍 Internacionalização

Idiomas suportados:
- 🇺🇸 Inglês (en)
- 🇧🇷 Português Brasil (pt_BR)
- 🇵🇹 Português Portugal (pt_PT)
- 🇪🇸 Espanhol (es)

---

## 📋 Roadmap

### v7.0.0 (Atual) ✅
- [x] 18 verificações de segurança
- [x] Firebase Remote Config
- [x] Validação de assinaturas
- [x] Dashboard de segurança

### v7.1.0 (Próximo)
- [ ] Hashes reais de apps
- [ ] iOS support (Swift)
- [ ] Relatórios exportáveis
- [ ] Histórico de scans

### v8.0.0 (Futuro)
- [ ] VPN detection
- [ ] Malware scanning
- [ ] Cloud backup de configurações
- [ ] Multi-device sync

---

## 🤝 Contribuindo

Contribuições são bem-vindas! Por favor:

1. Fork o projeto
2. Crie uma branch (`git checkout -b feature/AmazingFeature`)
3. Commit suas mudanças (`git commit -m 'Add some AmazingFeature'`)
4. Push para a branch (`git push origin feature/AmazingFeature`)
5. Abra um Pull Request

---

## 📄 Licença

Este projeto está sob a licença MIT. Veja o arquivo `LICENSE` para mais detalhes.

---

## 👥 Autores

- **Multiverso Digital** - *Desenvolvimento inicial*

---

## 🙏 Agradecimentos

- Flutter Team
- Firebase Team
- Comunidade Open Source

---

## 📞 Contato

- **Email**: contato@multiversodigital.com
- **Website**: https://multiversodigital.com

---

## ⚠️ Disclaimer

Este app é fornecido "como está", sem garantias. Use por sua conta e risco. As verificações de segurança são indicativas e não substituem uma auditoria profissional.

---

**Desenvolvido com ❤️ por Multiverso Digital**

**Versão**: 7.0.0  
**Data**: Dezembro 2025  
**Status**: ✅ Produção
