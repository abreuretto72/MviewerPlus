# 🍪 Cookie Inspector Module

## Visão Geral

O **Cookie Inspector** é um módulo completo e avançado do MviewerPlus focado em **visualização, edição, exclusão e análise de segurança de cookies**, respeitando os princípios **privacy-first** e **open-source** do aplicativo.

---

## 🎯 Funcionalidades Principais

### 1. Visualização de Cookies
- **Cookies HTTP**: Gerenciados via `dio` + `cookie_jar`
- **Cookies WebView**: Acessados via `webview_flutter` + JavaScript injection
- Interface com abas separadas para cada fonte
- Exibição detalhada de todas as propriedades do cookie

### 2. Edição de Cookies
- Editar valor, path, flags (secure, sameSite)
- Backup automático antes de modificações
- Validação de dados
- Proteção com autenticação para cookies sensíveis

### 3. Exclusão de Cookies
- Excluir cookie individual
- Excluir todos os cookies de um domínio
- Excluir todos os cookies (com confirmação dupla)
- Avisos sobre impacto em sessões ativas

### 4. Exportação Segura
Formatos suportados:
- **JSON**: Estruturado com metadados
- **CSV**: Compatível com Excel
- **PDF**: Relatório profissional com paginação

Opções de segurança:
- ✅ Valores mascarados (padrão)
- ⚠️ Valores reais (requer autenticação)

### 5. 🔎 Detecção de Cookies Sensíveis

O módulo `CookieSecurityGuard` analisa automaticamente cada cookie e detecta:

#### Padrões de Autenticação/Sessão
- `session`, `sessid`, `phpsessid`, `jsessionid`
- `csrftoken`, `xsrf`, `auth`, `login`

#### Tokens
- JWT (formato `xxxxx.yyyyy.zzzzz`)
- `access_token`, `refresh_token`, `id_token`
- `bearer`, `api_key`

#### OAuth/OpenID
- `oauth`, `openid`, `authorize`, `callback`

#### 2FA/MFA
- `otp`, `2fa`, `mfa`, `totp`
- `one_time`, `authenticator`, `verification`

#### Análise Avançada
- Detecção de JWT via regex
- Cálculo de entropia de Shannon
- Identificação de Base64
- Verificação de flags de segurança

### 6. Classificação de Risco

Cada cookie recebe uma pontuação de 0-100 e um nível de risco:

| Nível | Pontuação | Cor | Ícone |
|-------|-----------|-----|-------|
| **None** | 0-19 | 🟢 Verde | Sem risco |
| **Low** | 20-39 | 🟡 Amarelo | Risco baixo |
| **Medium** | 40-69 | 🟠 Laranja | Risco médio |
| **High** | 70-100 | 🔴 Vermelho | Alto risco |

### 7. 🔐 Proteção com Autenticação

Ações sensíveis exigem autenticação:

**Métodos suportados:**
1. **Biometria** (impressão digital, face, íris)
2. **PIN** (fallback configurável)

**Ações protegidas:**
- Revelar valor de cookie sensível
- Copiar valor de cookie sensível
- Editar cookie sensível
- Excluir cookie sensível
- Excluir todos os cookies
- Exportar com valores reais

---

## 📁 Arquitetura

```
lib/features/cookies/
├── data/
│   └── services/
│       ├── webview_cookie_service.dart    # Gerencia cookies do WebView
│       ├── http_cookie_service.dart       # Gerencia cookies HTTP
│       ├── auth_service.dart              # Autenticação biométrica/PIN
│       └── cookie_export_service.dart     # Exportação JSON/CSV/PDF
├── domain/
│   ├── models/
│   │   └── cookie_entry.dart              # Modelo unificado de cookie
│   └── security/
│       └── cookie_security_guard.dart     # Análise de segurança
└── presentation/
    ├── providers/
    │   └── cookie_inspector_provider.dart # Gerenciamento de estado
    └── screens/
        └── cookie_inspector_screen.dart   # Interface principal
```

---

## 🔧 Dependências

```yaml
dependencies:
  webview_flutter: ^4.10.0      # Cookies do WebView
  dio: ^5.7.0                   # Cliente HTTP
  cookie_jar: ^4.0.8            # Armazenamento de cookies
  dio_cookie_manager: ^3.1.1    # Integração Dio + CookieJar
  local_auth: ^2.3.0            # Autenticação biométrica
  crypto: ^3.0.6                # Criptografia e hash
  path_provider: ^2.1.5         # Diretórios do sistema
  pdf: ^3.11.3                  # Geração de PDF
  printing: ^5.14.2             # Impressão/salvamento de PDF
```

---

## 🚀 Como Usar

### 1. Acessar o Cookie Inspector

No menu principal do MviewerPlus:
1. Toque no ícone do menu (☰)
2. Selecione **"🍪 Cookie Inspector"**

### 2. Listar Cookies HTTP

1. Vá para a aba **"HTTP Cookies"**
2. Digite uma URL (ex: `https://example.com`)
3. Clique em **"Listar"**

### 3. Visualizar Detalhes

- Toque em um cookie para expandir
- Veja todas as propriedades
- Sinais de segurança são exibidos automaticamente

### 4. Editar Cookie

1. Expanda o cookie
2. Toque em **"Editar"**
3. (Se sensível) Autentique-se
4. Modifique os valores
5. Salve

### 5. Exportar Cookies

1. Toque em **"Exportar"**
2. Escolha o formato (JSON/CSV/PDF)
3. Escolha mascaramento (recomendado) ou valores reais
4. (Se valores reais) Autentique-se
5. O arquivo é gerado

### 6. Configurar PIN

1. Vá para a aba **"Security & Logs"**
2. Toque em **"Configurar PIN"**
3. Digite um PIN de 4-6 dígitos
4. Confirme o PIN

---

## 🛡️ Segurança e Privacidade

### Princípios

✅ **100% Local**: Nenhum dado enviado para servidores  
✅ **Privacy-First**: Valores sensíveis mascarados por padrão  
✅ **Open-Source**: Código auditável  
✅ **Zero Tracking**: Sem analytics ou telemetria  
✅ **Autenticação Forte**: Biometria + PIN  

### Avisos ao Usuário

O módulo exibe avisos claros:

> ⚠️ **Cookies podem conter tokens de sessão e login. Use com cuidado.**

> ⚠️ **Esta ação pode encerrar sessões ativas.**

> ⚠️ **Este relatório contém cookies de autenticação.**

### Limitações Conhecidas

**WebView Cookies:**
- Cookies com `httpOnly` não são visíveis via JavaScript
- Cookies com `secure` podem ter restrições
- Recomenda-se usar ferramentas de desenvolvedor do navegador para inspeção completa

---

## 📊 Relatórios

### Estatísticas Disponíveis

- Total de cookies
- Total de domínios
- Cookies com flag `secure`
- Cookies com flag `httpOnly`
- Cookies expirados

### Relatório de Segurança

Gerado automaticamente, contém:
- Resumo de riscos (High/Medium/Low/None)
- Lista de cookies sensíveis detectados
- Sinais de segurança identificados

---

## 🌍 Localização

Suporte completo para:
- 🇺🇸 **Inglês** (EN)
- 🇧🇷 **Português (Brasil)** (PT-BR)
- 🇵🇹 **Português (Portugal)** (PT-PT) *(parcial)*
- 🇪🇸 **Espanhol** (ES) *(parcial)*

---

## 🧪 Testes

### Cenários de Teste

1. **Cookies HTTP**
   - Listar cookies de um domínio
   - Editar valor de cookie
   - Excluir cookie individual
   - Excluir todos os cookies

2. **Detecção de Segurança**
   - Testar com JWT
   - Testar com `access_token`
   - Testar com `session_id`
   - Verificar cálculo de entropia

3. **Autenticação**
   - Configurar PIN
   - Validar PIN correto/incorreto
   - Testar biometria (se disponível)

4. **Exportação**
   - Exportar para JSON
   - Exportar para CSV
   - Exportar para PDF
   - Testar mascaramento

---

## 📝 Notas Técnicas

### Cache de Análise de Segurança

O provider mantém um cache em memória das análises de segurança para evitar reprocessamento:

```dart
Map<String, SecurityAnalysis> _securityCache = {};
```

### Backup Automático

Antes de qualquer modificação, um backup é criado automaticamente:

```dart
final backup = await _webViewService.createBackup(controller, url);
```

### Isolate para Scans

Processamento pesado é feito em isolate para não bloquear a UI (planejado para versões futuras).

---

## 🔮 Roadmap

### Versão 1.1
- [ ] Importação de cookies de arquivo
- [ ] Filtros avançados (por domínio, risco, flags)
- [ ] Histórico de modificações
- [ ] Comparação de cookies (diff)

### Versão 1.2
- [ ] Suporte a cookies de outros navegadores
- [ ] Sincronização segura entre dispositivos
- [ ] Análise de cookies de terceiros (tracking)
- [ ] Recomendações de privacidade

---

## 📄 Licença

Este módulo faz parte do **MviewerPlus**, um projeto **100% gratuito e open-source**.

---

## 👨‍💻 Desenvolvedor

**Multiverso Digital**  
📧 contato@multiversodigital.com.br

---

## 🙏 Agradecimentos

- Comunidade Flutter
- Equipe do pacote `webview_flutter`
- Equipe do pacote `dio`
- Contribuidores do projeto

---

**MviewerPlus** - *The Universal File Viewer*  
🔐 **Privacy-First** | 🆓 **Free Forever** | 📖 **Open-Source**
