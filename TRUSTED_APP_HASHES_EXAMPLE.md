# 📋 EXEMPLO: trusted_app_hashes (Firebase Remote Config)

## 🔥 Configuração no Firebase Console

### Passo 1: Acessar Remote Config

1. Acesse [Firebase Console](https://console.firebase.google.com/)
2. Selecione seu projeto **MviewerPlus**
3. No menu lateral, clique em **Remote Config**
4. Clique em **Adicionar parâmetro**

---

### Passo 2: Criar Parâmetro

**Nome do parâmetro:**
```
trusted_app_hashes
```

**Tipo de dados:**
```
String (JSON)
```

**Valor padrão:**

Copie e cole o JSON abaixo:

```json
{
  "com.whatsapp": [
    "38A0F7D505FE18FEC64FBF343ECAAAF310DBD7991FBD043FBC7A46317799A447",
    "39B6F0DC043984A7F4A10AE6933E4E7C52379E5B9B8D6F4E3C2A1B0C9D8E7F6A"
  ],
  "com.instagram.android": [
    "1A2B3C4D5E6F7A8B9C0D1E2F3A4B5C6D7E8F9A0B1C2D3E4F5A6B7C8D9E0F1A2B"
  ],
  "com.facebook.katana": [
    "2B3C4D5E6F7A8B9C0D1E2F3A4B5C6D7E8F9A0B1C2D3E4F5A6B7C8D9E0F1A2B3C"
  ],
  "org.telegram.messenger": [
    "3C4D5E6F7A8B9C0D1E2F3A4B5C6D7E8F9A0B1C2D3E4F5A6B7C8D9E0F1A2B3C4D"
  ],
  "com.nu.production": [
    "4D5E6F7A8B9C0D1E2F3A4B5C6D7E8F9A0B1C2D3E4F5A6B7C8D9E0F1A2B3C4D5E"
  ],
  "br.com.intermedium": [
    "5E6F7A8B9C0D1E2F3A4B5C6D7E8F9A0B1C2D3E4F5A6B7C8D9E0F1A2B3C4D5E6F"
  ],
  "com.itau": [
    "6F7A8B9C0D1E2F3A4B5C6D7E8F9A0B1C2D3E4F5A6B7C8D9E0F1A2B3C4D5E6F7A"
  ],
  "br.gov.meugovbr": [
    "7A8B9C0D1E2F3A4B5C6D7E8F9A0B1C2D3E4F5A6B7C8D9E0F1A2B3C4D5E6F7A8B"
  ],
  "com.bradesco": [
    "8B9C0D1E2F3A4B5C6D7E8F9A0B1C2D3E4F5A6B7C8D9E0F1A2B3C4D5E6F7A8B9C"
  ],
  "com.santander.app": [
    "9C0D1E2F3A4B5C6D7E8F9A0B1C2D3E4F5A6B7C8D9E0F1A2B3C4D5E6F7A8B9C0D"
  ],
  "com.bb.android": [
    "0D1E2F3A4B5C6D7E8F9A0B1C2D3E4F5A6B7C8D9E0F1A2B3C4D5E6F7A8B9C0D1E"
  ],
  "com.mercadolibre": [
    "1E2F3A4B5C6D7E8F9A0B1C2D3E4F5A6B7C8D9E0F1A2B3C4D5E6F7A8B9C0D1E2F"
  ]
}
```

**⚠️ IMPORTANTE**: Os hashes acima são **exemplos fictícios**. Você deve substituí-los pelos hashes reais!

---

### Passo 3: Publicar

Clique em **Publicar alterações**

---

## 📖 Explicação do Formato

### Estrutura Básica

```json
{
  "package_name": ["hash1", "hash2", ...],
  "outro_package": ["hash"]
}
```

### Por que Array de Hashes?

#### ✅ Múltiplas Versões

```json
"com.whatsapp": [
  "HASH_VERSAO_ATUAL",    // WhatsApp 2.24.x
  "HASH_VERSAO_ANTERIOR"  // WhatsApp 2.23.x
]
```

**Benefício**: Usuários com versões diferentes não são marcados como comprometidos.

#### ✅ Debug vs Release

```json
"com.meuapp": [
  "HASH_RELEASE",  // Assinatura de produção
  "HASH_DEBUG"     // Assinatura de desenvolvimento
]
```

**Benefício**: Facilita testes durante desenvolvimento.

#### ✅ Transição de Assinatura

```json
"com.app": [
  "HASH_NOVA_ASSINATURA",  // Nova chave
  "HASH_ANTIGA_ASSINATURA" // Chave antiga (ainda válida)
]
```

**Benefício**: Migração suave entre assinaturas.

---

## 🔍 Como Obter os Hashes Reais

### Método 1: Usando o Próprio App (RECOMENDADO)

```dart
// Execute este código uma vez para cada app:
final packages = [
  'com.whatsapp',
  'com.instagram.android',
  'com.facebook.katana',
  // ... outros
];

for (final package in packages) {
  final result = await NativeSecurityChecker.checkAppSignature(
    package,
    'DUMMY_HASH', // Qualquer valor
  );
  
  if (result['isInstalled'] == true) {
    print('$package: ${result['actualHash']}');
    // Copie este hash para o Firebase
  }
}
```

**Saída esperada:**
```
com.whatsapp: 38A0F7D505FE18FEC64FBF343ECAAAF310DBD7991FBD043FBC7A46317799A447
com.instagram.android: 1A2B3C4D5E6F7A8B9C0D1E2F3A4B5C6D7E8F9A0B1C2D3E4F5A6B7C8D9E0F1A2B
...
```

### Método 2: keytool (Terminal)

```bash
# 1. Extrair APK do dispositivo
adb shell pm path com.whatsapp
# Saída: package:/data/app/com.whatsapp-XXXXX/base.apk

adb pull /data/app/com.whatsapp-XXXXX/base.apk whatsapp.apk

# 2. Obter hash SHA-256
keytool -printcert -jarfile whatsapp.apk | grep SHA256

# 3. Converter para formato sem ":"
# De: SHA256: 38:A0:F7:D5:05:FE:18:FE:C6:4F:BF:34:3E:CA:AA:F3:10:DB:D7:99:1F:BD:04:3F:BC:7A:46:31:77:99:A4:47
# Para: 38A0F7D505FE18FEC64FBF343ECAAAF310DBD7991FBD043FBC7A46317799A447
```

### Método 3: Play Store Console

```
1. Acesse Play Console
2. Selecione o app
3. Vá em "Configurações do app" → "Integridade do app"
4. Copie SHA-256 da "Assinatura de upload"
5. Remova os ":" do hash
```

---

## 📊 Exemplo Completo com Hashes Reais

### Template para Preencher

```json
{
  "com.whatsapp": [
    "COLE_AQUI_O_HASH_DO_WHATSAPP"
  ],
  "com.instagram.android": [
    "COLE_AQUI_O_HASH_DO_INSTAGRAM"
  ],
  "com.facebook.katana": [
    "COLE_AQUI_O_HASH_DO_FACEBOOK"
  ],
  "org.telegram.messenger": [
    "COLE_AQUI_O_HASH_DO_TELEGRAM"
  ],
  "com.nu.production": [
    "COLE_AQUI_O_HASH_DO_NUBANK"
  ],
  "br.com.intermedium": [
    "COLE_AQUI_O_HASH_DO_INTER"
  ],
  "com.itau": [
    "COLE_AQUI_O_HASH_DO_ITAU"
  ],
  "br.gov.meugovbr": [
    "COLE_AQUI_O_HASH_DO_GOVBR"
  ]
}
```

---

## 🔄 Como Atualizar os Hashes

### Cenário 1: WhatsApp Lançou Nova Versão

```json
// ANTES
"com.whatsapp": [
  "38A0F7D505FE18FEC64FBF343ECAAAF310DBD7991FBD043FBC7A46317799A447"
]

// DEPOIS (adicione o novo hash)
"com.whatsapp": [
  "NOVO_HASH_DA_VERSAO_2_25",
  "38A0F7D505FE18FEC64FBF343ECAAAF310DBD7991FBD043FBC7A46317799A447"
]
```

### Cenário 2: Remover Hash Antigo

```json
// Após alguns meses, quando todos atualizaram:
"com.whatsapp": [
  "NOVO_HASH_DA_VERSAO_2_25"  // Remove o antigo
]
```

### Cenário 3: Adicionar Novo App

```json
{
  // ... apps existentes ...
  
  "com.picpay": [
    "HASH_DO_PICPAY"
  ]
}
```

---

## ⚙️ Configurações Avançadas (Opcional)

### Segmentação por País

No Firebase Console, você pode criar condições:

**Condição**: `País = Brasil`
**Valor**:
```json
{
  "com.whatsapp": ["HASH"],
  "com.nu.production": ["HASH"],
  "br.com.intermedium": ["HASH"],
  // ... apps BR
}
```

**Condição**: `País != Brasil`
**Valor**:
```json
{
  "com.whatsapp": ["HASH"],
  "com.instagram.android": ["HASH"],
  // ... apenas apps globais
}
```

### Segmentação por Versão do App

**Condição**: `Versão do app >= 5.0.0`
**Valor**: JSON com novos hashes

**Condição**: `Versão do app < 5.0.0`
**Valor**: JSON com hashes antigos

---

## 🧪 Como Testar

### 1. Teste Local (Antes de Publicar)

```dart
// Adicione temporariamente no código:
await TrustedAppHashesService.instance.resetToDefaults();

// Verifique se os defaults funcionam
final apps = TrustedAppHashesService.instance.getAllTrustedApps();
print('Apps monitorados: ${apps.length}');
```

### 2. Teste com Firebase (Após Publicar)

```dart
// Force atualização
await TrustedAppHashesService.instance.forceUpdate();

// Verifique status
final status = TrustedAppHashesService.instance.lastFetchStatus;
print('Status: $status');

// Verifique hashes carregados
final whatsappHashes = TrustedAppHashesService.instance.getHashesForPackage('com.whatsapp');
print('WhatsApp hashes: $whatsappHashes');
```

### 3. Teste de Validação

```dart
// Validar um app específico
final result = await NativeSecurityChecker.checkAppSignature(
  'com.whatsapp',
  whatsappHashes.first,
);

print('WhatsApp instalado: ${result['isInstalled']}');
print('WhatsApp válido: ${result['isValid']}');
print('Hash atual: ${result['actualHash']}');
```

---

## ✅ Checklist de Configuração

### Firebase Console
- [ ] Acessar Remote Config
- [ ] Criar parâmetro `trusted_app_hashes`
- [ ] Colar JSON (com hashes reais)
- [ ] Publicar alterações

### Obter Hashes
- [ ] Instalar apps no dispositivo
- [ ] Executar código de extração
- [ ] Copiar hashes para JSON
- [ ] Atualizar Firebase

### Testar
- [ ] Forçar atualização no app
- [ ] Verificar hashes carregados
- [ ] Validar apps instalados
- [ ] Confirmar detecção funciona

---

## 🎯 Resultado Final

Após configurar corretamente, o app irá:

1. ✅ Buscar hashes do Firebase ao iniciar
2. ✅ Usar defaults se offline
3. ✅ Validar apps instalados
4. ✅ Detectar apps comprometidos
5. ✅ Alertar o usuário

**Tudo sem precisar lançar nova versão do app!** 🔥

---

**Arquivo**: `firebase_remote_config_example.json`  
**Uso**: Copiar e colar no Firebase Console  
**Status**: ⚠️ Hashes são exemplos - substituir por reais
