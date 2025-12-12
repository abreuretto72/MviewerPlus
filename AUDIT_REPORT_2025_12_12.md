# 🛡️ Relatório de Auditoria de Conformidade e Localização (MviewerPlus)
**Data:** 12/12/2025
**Status Global:** ⚠️ Requer Atenção Imediata

Este relatório detalha os resultados da auditoria de conformidade com as políticas do Google Play e da qualidade de localização do aplicativo.

---

## 📊 Resumo Executivo

| Área Auditada | Status | Risco | Ação Necessária |
| :--- | :---: | :---: | :--- |
| **Monetização & Ads** | 🔴 Falha | Alto | Remover UI Premium e referências a Ads |
| **Permissões & Manifesto** | 🟡 Atenção | Médio | Adicionar queries para links externos |
| **Privacidade (Dados)** | 🟡 Atenção | Médio | Atualizar textos in-app para refletir Groq AI |
| **Localização (Cobertura)** | ✅ Aprovado | Baixo | Nenhuma (100% traduzido) |
| **Localização (Qualidade)** | 🟡 Atenção | Baixo | Corrigir textos legados nos ARBs |

---

## 1. 🔍 Auditoria de Conformidade Google Play

### 🔴 1.1 Política de Monetização e Transparência
**Problema Crítico:** O aplicativo é declarado como "100% Gratuito", mas o código contém funcionalidades ativas que contradizem isso.
- **Achado 1:** Botão **"Go Premium"** (Hazte Premium / Seja Premium) visível na tela de Configurações (`SettingsScreen`).
- **Achado 2:** Textos de Privacidade dentro do app (`privacyPolicyContent`) afirmam explicitamente: *"podemos usar serviços de publicidade de terceiros (ex: AdMob)"*.
**Violação:** Isso pode ser considerado "Misleading Claims" (Alegações Enganosas) na revisão do Google Play.
**Correção Proposta:** 
- Remover o bloco de código do botão Premium em `settings_screen.dart`.
- Reescrever os textos de privacidade nos arquivos `.arb`.

### 🟡 1.2 Manifesto e Links Externos (Android 11+)
**Problema:** O `url_launcher` requer declaração de queries no `AndroidManifest.xml` para funcionar em Android 11+ (API 30).
**Achado:** Falta a declaração `<queries>` para o esquema `https`.
**Risco:** Links para "Política de Privacidade" ou "GitHub" podem não abrir, gerando falha funcional ("Broken Functionality").
**Correção Proposta:** Adicionar o bloco `<intent>` para `https` no manifesto.

### 🟡 1.3 Dependências (Code Hygiene)
**Problema:** Dependências não utilizadas aumentam o tamanho do app e complexidade.
**Achado:** `google_generative_ai` está no `pubspec.yaml` mas o app migrou para Groq (HTTP).
**Correção Proposta:** Remover a dependência.

---

## 2. 🌍 Auditoria de Localização

### ✅ 2.1 Cobertura de Idiomas
Verificação completa dos arquivos de tradução:
- **Inglês (en)**: ✅ Completo (Padrão).
- **Português Brasil (pt-BR)**: ✅ Completo.
- **Português Portugal (pt-PT)**: ✅ Completo. Contém adaptações adequadas ("Ficheiro", "A carregar", "Registo").
- **Espanhol (es)**: ✅ Completo.

### 🔴 2.2 Precisão de Conteúdo (Content Accuracy)
**Problema:** O texto traduzido não reflete a realidade atual do app (Groq AI, Free Model).
**Achados:**
- Chaves `premium`, `goPremium`, `premiumDesc` ainda existem e são usadas.
- Chave `privacyPolicyContent` em **todos os idiomas** menciona "AdMob" e "Google Generative AI" implicitamente ou explicitamente, contradizendo a documentação externa (`privacy.html`) que já foi limpa.
**Correção Proposta:** Atualizar o valor das chaves `privacyPolicyContent`, `termsContent` e remover chaves premium.

### 🟡 2.3 Formatos e Quebras (Layout)
- **PDF Reports**: Headers e Footers foram localizados com sucesso.
- **Datas/Números**: Uso de `intl` verificado. Espaços adequados previstos para textos em alemão/espanhol (embora alemão não seja suportado, espanhol sim). Risco baixo de quebra.

---

## 🚀 Plano de Ação Recomendado (Correções)

Autorize a execução dos seguintes passos para atingir 100% de conformidade:

1.  **Limpeza de Monetização**: Remover botão Premium de `SettingsScreen`.
2.  **Atualização de Texto**: Reescrever `privacyPolicyContent` nos 4 arquivos `.arb` para remover menções a Ads e alinhar com o uso da Groq AI e modelo Gratuito.
3.  **Fix Técnico**: Adicionar `<queries>` HTTPS no `AndroidManifest.xml` para garantir funcionamento de links.
4.  **Limpeza de Projeto**: Remover `google_generative_ai` do `pubspec.yaml`.

---
**Auditor Responsável:** Antigravity AI
