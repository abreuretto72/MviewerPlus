// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'MviewerPlus';

  @override
  String get openFile => 'Abrir Arquivo';

  @override
  String get copyContent => 'Copiar Conteúdo';

  @override
  String get copiedToClipboard =>
      'Conteúdo copiado para a área de transferência';

  @override
  String get errorLoadingFile => 'Erro ao carregar arquivo';

  @override
  String get emptyCsv => 'CSV Vazio';

  @override
  String get subtitle => 'O Leitor Universal de Arquivos';

  @override
  String get supportsHint =>
      'Suporta .txt, .json, .csv, .xml, .sql, .log e mais';

  @override
  String get privacyPolicy => 'Política de Privacidade';

  @override
  String get settings => 'Configurações';

  @override
  String get termsOfService => 'Termos de Uso';

  @override
  String get language => 'Idioma';

  @override
  String get theme => 'Tema';

  @override
  String get apiKey => 'Chave de API da IA';

  @override
  String get enterApiKey => 'Insira sua Chave de API da Groq';

  @override
  String get apiKeyDesc => 'Obter a chave gratuita';

  @override
  String get save => 'Salvar';

  @override
  String get getApiKeyHelpBtn => 'Como obter uma chave? (Toque aqui)';

  @override
  String get getApiKeyDialogTitle => 'Obtendo uma Chave de API da Groq';

  @override
  String get getApiKeyDialogContent =>
      '1. Acesse console.groq.com\n2. Cadastre-se ou faça login\n3. Vá para a seção \"API Keys\"\n4. Crie uma nova chave e copie-a aqui.';

  @override
  String get close => 'Fechar';

  @override
  String get cancel => 'Cancelar';

  @override
  String get aiAssistant => 'Assistente IA';

  @override
  String get askAboutFile => 'Pergunte sobre o arquivo...';

  @override
  String get systemNote => 'Nota do Sistema';

  @override
  String analyzedFile(Object fileName) {
    return 'Analisei $fileName. Pergunte-me qualquer coisa sobre o conteúdo!';
  }

  @override
  String get fileTooLarge =>
      'Arquivo muito grande. Conteúdo truncado para análise.';

  @override
  String get privacyPolicyContent =>
      'Última atualização: Dezembro de 2025\n\nEsta Política de Privacidade descreve como o MviewerPlus trata suas informações.\n\n1. Coleta e Processamento\nNão coletamos dados pessoais. O processamento de arquivos é local no seu dispositivo.\n\n2. Recursos de IA\nAo usar o assistente de IA, o conteúdo do arquivo é enviado para a API da Groq usando sua Chave de API pessoal. Nenhum dado é armazenado por nós.\n\n3. Modelo Gratuito\nEste aplicativo é 100% gratuito, open-source e não exibe anúncios.\n\n4. Contato\nEm caso de dúvidas, entre em contato: contato@multiversodigital.com.br';

  @override
  String get termsContent =>
      'Termos de Uso\n\nAo usar o MviewerPlus, você concorda com estes termos.\n\n1. Uso\nVocê é responsável pelo conteúdo que acessa usando este visualizador.\n\n2. Responsabilidade\nO desenvolvedor não se responsabiliza por qualquer perda de dados ou problemas decorrentes do uso deste software.\n\n3. Atualizações\nEstes termos podem mudar a qualquer momento.';

  @override
  String get about => 'Sobre';

  @override
  String get companyName => 'Multiverso Digital';

  @override
  String get contactEmail => 'contato@multiversodigital.com.br';

  @override
  String get appVersion => 'Versão 1.0.0';

  @override
  String get copyMessage => 'Copiar Mensagem';

  @override
  String get exportPdf => 'Exportar para PDF';

  @override
  String get pdfGenerated => 'PDF gerado com sucesso';

  @override
  String get errorGeneratingPdf => 'Erro ao gerar PDF';

  @override
  String get exportOptionsTitle => 'Opções de Exportação';

  @override
  String get exportOptionsContent =>
      'Você quer também gerar um PDF do arquivo original?';

  @override
  String get exportChatOnly => 'Apenas Chat';

  @override
  String get exportBoth => 'Chat e Arquivo';

  @override
  String get print => 'Imprimir';

  @override
  String get share => 'Compartilhar';

  @override
  String get saveChangesTitle => 'Salvar Cópia?';

  @override
  String get saveChangesContent =>
      'Isso salvará uma cópia do arquivo editado. O arquivo original será preservado.';

  @override
  String saveCopySuccess(Object path) {
    return 'Cópia salva em: $path';
  }

  @override
  String get savedFiles => 'Arquivos Salvos';

  @override
  String get noSavedFiles => 'Nenhum arquivo salvo encontrado';

  @override
  String get history => 'Histórico';

  @override
  String get deleteTitle => 'Confirmar Exclusão';

  @override
  String get deleteContent => 'Tem certeza que deseja remover este item?';

  @override
  String get delete => 'Excluir';

  @override
  String get find => 'Localizar';

  @override
  String get replace => 'Substituir';

  @override
  String get replaceAll => 'Substituir Tudo';

  @override
  String replacedSuccess(Object count) {
    return '$count ocorrências substituídas';
  }

  @override
  String get includeOriginal => 'Incluir Conteúdo do Arquivo';

  @override
  String get processing => 'Processando...';

  @override
  String processingColumns(Object columns) {
    return 'Analisando $columns colunas...';
  }

  @override
  String get pdfReportTitle => 'Relatório MviewerPlus';

  @override
  String get pdfGeneratedLabel => 'Gerado em:';

  @override
  String get pdfFileLabel => 'Arquivo:';

  @override
  String get pdfSizeLabel => 'Tamanho:';

  @override
  String get pdfRecordsLabel => 'Registros:';

  @override
  String get pdfPage => 'Página';

  @override
  String get pdfOf => 'de';

  @override
  String get rows => 'linhas';

  @override
  String get files => 'arquivos';

  @override
  String get lines => 'linhas';

  @override
  String get archiveBadge => 'ARQUIVO';

  @override
  String get zipEmpty => 'Arquivo ZIP vazio ou inválido';

  @override
  String zipArchiveInfo(Object count) {
    return 'Arquivo ZIP ($count arquivos)';
  }

  @override
  String get fileName => 'Nome do Arquivo';

  @override
  String get fileType => 'Tipo';

  @override
  String get fileSizeCol => 'Tamanho (KB)';

  @override
  String get searchNotAvailableZip =>
      'Busca não disponível para arquivos compactados.';

  @override
  String get readOnlyFormat => 'Este formato é apenas para leitura.';

  @override
  String get processingWait => 'Lendo arquivo, aguarde.';

  @override
  String get loadingTitle => 'Carregando...';

  @override
  String get help => 'Ajuda';

  @override
  String get helpTitle => 'Guia de Ajuda do MviewerPlus';

  @override
  String get featuresSection => 'Funcionalidades Principais';

  @override
  String get featuresContent =>
      '• Visualização Rápida: Abra arquivos grandes instantaneamente com performance nativa.\n• Edição e Busca: Edite textos, código e dados. Use \'Localizar e Substituir\' avançado.\n• Edição Segura: Seus arquivos originais nunca são alterados. O app trabalha em uma cópia, salva no \'Histórico\' do Menu Principal.\n• Tabelas Inteligentes: Visualize CSVs e Excel como planilhas interativas com ordenação e filtros.\n• Editor de Código: Sintaxe colorida para mais de 30 linguagens (Dart, JS, Python, SQL...).\n• Checagem de Segurança: Verifique integridade do app, root, debuggers e assinaturas digitais.\n• Análise com IA: Conecte sua chave Groq para \'conversar\' com seus documentos.\n• Arquivos ZIP: Navegue dentro de arquivos compactados como se fossem pastas.\n• Multimídia: Player nativo para áudio e vídeo.';

  @override
  String get formatsSection => 'Formatos Suportados';

  @override
  String get exit => 'Sair';

  @override
  String get exitConfirm => 'Deseja fechar o aplicativo?';

  @override
  String get formatsContent =>
      '• Texto & Código: .txt, .md, .log, .json, .xml, .yaml, .yml, .html, .css, .js, .ts, .dart, .java, .kt, .swift, .py, .rb, .php, .go, .c, .cpp, .cs, .sql, .sh, .conf, .env, .ini\n• Dados & Planilhas: .csv, .xlsx, .xls\n• Documentos: .pdf, .docx (texto)\n• Imagens: .png, .jpg, .jpeg, .gif, .webp, .bmp\n• Áudio: .mp3, .wav, .ogg, .m4a, .aac, .flac\n• Vídeo: .mp4, .mov, .avi, .mkv, .webm, .wmv, .flv, .3gp\n• Arquivos: .zip, .apk, .jar\n• Certificados: .pem, .crt, .cer, .p12, .pfx, .der';

  @override
  String get cookieInspector => 'Inspetor de Cookies';

  @override
  String get cookieInspectorDesc => 'Gerenciar e analisar cookies';

  @override
  String get httpCookies => 'Cookies HTTP';

  @override
  String get webviewCookies => 'Cookies WebView';

  @override
  String get securityLogs => 'Segurança e Logs';

  @override
  String get cookieWarning =>
      'Cookies podem conter tokens de sessão e login. Use com cuidado.';

  @override
  String get urlOrDomain => 'URL ou Domínio';

  @override
  String get listCookies => 'Listar';

  @override
  String get exportCookies => 'Exportar';

  @override
  String get deleteAllCookies => 'Excluir Todos';

  @override
  String get noCookiesFound => 'Nenhum cookie encontrado';

  @override
  String get enterUrlAndList => 'Digite uma URL e clique em \'Listar\'';

  @override
  String get cookieName => 'Nome';

  @override
  String get cookieValue => 'Valor';

  @override
  String get cookieDomain => 'Domínio';

  @override
  String get cookiePath => 'Caminho';

  @override
  String get cookieExpires => 'Expira';

  @override
  String get cookieSecure => 'Seguro';

  @override
  String get cookieHttpOnly => 'HttpOnly';

  @override
  String get cookieSameSite => 'SameSite';

  @override
  String get cookieSensitive => 'Cookie sensível';

  @override
  String get securitySignals => 'Sinais de Segurança';

  @override
  String get copyValue => 'Copiar Valor';

  @override
  String get editCookie => 'Editar';

  @override
  String get deleteCookie => 'Excluir';

  @override
  String get revealValue => 'Revelar valor completo';

  @override
  String get confirmDeletion => 'Confirmar Exclusão';

  @override
  String deleteConfirmMsg(Object name) {
    return 'Deseja excluir o cookie \"$name\"?';
  }

  @override
  String get sessionWarning => 'Esta ação pode encerrar sessões ativas.';

  @override
  String get deleteAllConfirmTitle => '⚠️ Confirmar Exclusão em Massa';

  @override
  String get deleteAllConfirmMsg => 'Deseja excluir TODOS os cookies?';

  @override
  String get deleteAllWarning =>
      'ATENÇÃO: Esta ação é irreversível!\n• Todas as sessões serão encerradas\n• Você será desconectado de sites\n• Configurações salvas serão perdidas';

  @override
  String get understandWarning => 'Entendo que isso pode encerrar sessões';

  @override
  String get exportFormat => 'Exportar Cookies';

  @override
  String get exportWarning => 'Este relatório contém cookies de autenticação.';

  @override
  String get exportMasked => 'Valores mascarados (recomendado)';

  @override
  String get exportMaskedDesc => 'Cookies sensíveis serão protegidos';

  @override
  String get exportReal => 'Valores reais';

  @override
  String get exportRealDesc => 'Requer autenticação adicional';

  @override
  String get statistics => '📊 Estatísticas';

  @override
  String get totalCookies => 'Total de Cookies';

  @override
  String get totalDomains => 'Total de Domínios';

  @override
  String get secureCookies => 'Cookies Seguros';

  @override
  String get httpOnlyCookies => 'Cookies HttpOnly';

  @override
  String get expiredCookies => 'Cookies Expirados';

  @override
  String get securityReport => '🔐 Relatório de Segurança';

  @override
  String get viewDetails => 'Ver Detalhes';

  @override
  String get securitySettings => '🔒 Configurações de Segurança';

  @override
  String get biometricAuth => 'Autenticação Biométrica';

  @override
  String get protectSensitiveActions => 'Proteger ações sensíveis';

  @override
  String get configurePin => 'Configurar PIN';

  @override
  String get alternativePin => 'PIN de segurança alternativo';

  @override
  String get authRequired => 'Autenticação Necessária';

  @override
  String get configurePinMsg =>
      'Configure um PIN de segurança para proteger ações sensíveis.';

  @override
  String get enterPin => 'Digite seu PIN';

  @override
  String get pinMinLength => 'PIN (mínimo 4 dígitos)';

  @override
  String get confirmPin => 'Confirmar PIN';

  @override
  String get pinsDoNotMatch => 'PINs não coincidem';

  @override
  String get pinTooShort => 'PIN deve ter no mínimo 4 dígitos';

  @override
  String get pinConfigured => 'PIN configurado';

  @override
  String get errorConfiguringPin => 'Erro ao configurar PIN';

  @override
  String get webviewLimitations =>
      'Aviso: Cookies com flags httpOnly e secure podem não ser visíveis através do JavaScript. Para visualizar todos os cookies, use ferramentas de desenvolvedor do navegador ou acesse via HTTP Cookie Manager.';

  @override
  String get webviewRequiresActive =>
      'Esta funcionalidade requer uma WebView ativa.';

  @override
  String get valueCopied => 'Valor copiado para a área de transferência';

  @override
  String get cookieUpdated => 'Cookie atualizado';

  @override
  String get errorUpdatingCookie => 'Erro ao atualizar cookie';

  @override
  String get cookieDeleted => 'Cookie excluído';

  @override
  String get errorDeletingCookie => 'Erro ao excluir cookie';

  @override
  String get allCookiesDeleted => 'Todos os cookies foram excluídos';

  @override
  String get errorDeletingCookies => 'Erro ao excluir cookies';

  @override
  String get noCookiesToExport => 'Nenhum cookie para exportar';

  @override
  String get jsonCopied => 'JSON copiado para área de transferência';

  @override
  String get csvCopied => 'CSV copiado para área de transferência';

  @override
  String errorExporting(Object error) {
    return 'Erro ao exportar: $error';
  }

  @override
  String get fullSecurityReport => 'Relatório de Segurança Completo';

  @override
  String get reportCopied => 'Relatório copiado';

  @override
  String get premium => 'Premium';

  @override
  String get goPremium => 'Seja Premium';

  @override
  String get restorePurchases => 'Restaurar Compras';

  @override
  String get premiumDesc => 'Desbloqueie acesso ilimitado e remova anúncios.';

  @override
  String get securityCheck => 'Verificação de Segurança';

  @override
  String get securityCheckDesc => 'Verificar segurança do dispositivo';

  @override
  String get refresh => 'Atualizar';

  @override
  String securityCheckError(Object error) {
    return 'Erro ao verificar segurança: $error';
  }

  @override
  String get noResultsAvailable => 'Nenhum resultado disponível';

  @override
  String get securityLevel => 'Nível de Segurança';

  @override
  String get riskScore => 'Pontuação de Risco';

  @override
  String get checks => 'Verificações';

  @override
  String get recommendedActions => 'Ações Recomendadas';

  @override
  String get criticalThreats => 'Ameaças Críticas';

  @override
  String get warnings => 'Avisos';

  @override
  String get safe => 'Seguro';

  @override
  String get critical => 'Crítico';

  @override
  String get warning => 'Aviso';

  @override
  String get checksPerformed => 'Verificações Realizadas';

  @override
  String get checkRootJailbreak => 'Root/Jailbreak';

  @override
  String get checkDebugger => 'Debugger';

  @override
  String get checkHooking => 'Hooking';

  @override
  String get checkIntegrity => 'Integridade do App';

  @override
  String get checkOSVersion => 'Sistema Atualizado';

  @override
  String get checkScreenLock => 'Bloqueio de Tela';

  @override
  String get checkRealDevice => 'Dispositivo Real';

  @override
  String get statusOk => 'OK';

  @override
  String get statusFailed => 'FALHOU';

  @override
  String get understood => 'Entendi';

  @override
  String get securityLevelSafe => 'Seguro';

  @override
  String get securityLevelWarning => 'Avisos Detectados';

  @override
  String get securityLevelCritical => 'AMEAÇAS CRÍTICAS';

  @override
  String get securityDescSafe => 'Todas as verificações de segurança passaram';

  @override
  String get securityDescWarning =>
      'Algumas configurações podem ser melhoradas';

  @override
  String get securityDescCritical =>
      'Ameaças críticas detectadas - Ação necessária';

  @override
  String get actionRootTitle => 'Dispositivo com Root Detectado';

  @override
  String get actionRootDesc =>
      'Seu dispositivo está com privilégios de superusuário (root). Isso compromete a segurança do aplicativo.';

  @override
  String get actionRootRec =>
      'Remova o root do dispositivo ou use um dispositivo sem root.';

  @override
  String get actionDebuggerTitle => 'Debugger Detectado';

  @override
  String get actionDebuggerDesc =>
      'Um debugger está anexado ao aplicativo. Isso pode indicar tentativa de análise ou modificação do app.';

  @override
  String get actionDebuggerRec =>
      'Feche todas as ferramentas de desenvolvimento e reinicie o app.';

  @override
  String get actionHookingTitle => 'Framework de Hooking Detectado';

  @override
  String get actionHookingDesc =>
      'Foi detectado um framework de hooking (Frida, Xposed, etc.). Isso pode permitir modificação do comportamento do app.';

  @override
  String get actionHookingRec =>
      'Remova frameworks de hooking e reinicie o dispositivo.';

  @override
  String get actionIntegrityTitle => 'Integridade do App Comprometida';

  @override
  String get actionIntegrityDesc =>
      'A assinatura do aplicativo não corresponde à esperada. O app pode ter sido modificado.';

  @override
  String get actionIntegrityRec =>
      'Reinstale o app da loja oficial (Google Play/App Store).';

  @override
  String get actionOSTitle => 'Sistema Operacional Desatualizado';

  @override
  String get actionOSDesc =>
      'Seu sistema operacional está desatualizado e pode conter vulnerabilidades de segurança.';

  @override
  String get actionOSRec =>
      'Atualize seu sistema operacional para a versão mais recente.';

  @override
  String get actionLockTitle => 'Bloqueio de Tela Não Configurado';

  @override
  String get actionLockDesc =>
      'Seu dispositivo não possui bloqueio de tela configurado. Isso facilita acesso não autorizado.';

  @override
  String get actionLockRec =>
      'Configure um PIN, senha, padrão ou biometria nas configurações.';

  @override
  String get actionEmulatorTitle => 'Executando em Emulador';

  @override
  String get actionEmulatorDesc =>
      'O app está rodando em um emulador. Algumas funcionalidades podem estar limitadas.';

  @override
  String get actionEmulatorRec =>
      'Use um dispositivo físico para melhor experiência.';

  @override
  String get actionUnknownSourcesTitle =>
      'Instalação de Fontes Desconhecidas Habilitada';

  @override
  String get actionUnknownSourcesDesc =>
      'Seu dispositivo permite instalação de apps de fontes desconhecidas. Isso facilita a instalação de malware e spyware.';

  @override
  String get actionUnknownSourcesRec =>
      'Desabilite \'Instalar apps de fontes desconhecidas\' nas configurações de segurança.';

  @override
  String get actionLocationTitle =>
      'Apps com Localização \'Sempre\' Detectados';

  @override
  String actionLocationDesc(Object count) {
    return '$count app(s) têm permissão de rastreamento de localização em segundo plano. Isso representa risco de privacidade.';
  }

  @override
  String get actionLocationRec =>
      'Revise as permissões de localização e mude para \'Apenas durante o uso\' quando possível.';

  @override
  String get actionNotifTitle =>
      'Notificações Sensíveis Visíveis na Tela de Bloqueio';

  @override
  String get actionNotifDesc =>
      'Prévias de notificações (mensagens, códigos 2FA) são exibidas na tela de bloqueio. Isso pode permitir interceptação de dados sensíveis.';

  @override
  String get actionNotifRec =>
      'Configure para ocultar conteúdo sensível nas notificações da tela de bloqueio.';

  @override
  String get actionPatchTitle => 'Patch de Segurança Desatualizado';

  @override
  String get actionPatchDesc =>
      'O patch de segurança do seu dispositivo tem mais de 60 dias. Vulnerabilidades conhecidas podem não estar corrigidas.';

  @override
  String get actionPatchRec =>
      'Verifique por atualizações do sistema nas configurações.';

  @override
  String get action2FATitle => 'Ative a Autenticação de Dois Fatores (2FA)';

  @override
  String get action2FADesc =>
      'A autenticação de dois fatores adiciona uma camada extra de segurança às suas contas críticas (Google/Apple ID).';

  @override
  String get action2FARec =>
      'Ative o 2FA nas configurações de segurança da sua conta.';

  @override
  String get expAppSignaturesTitle => 'Monitoramento de Apps';

  @override
  String get expAppSignaturesDesc =>
      'Verifica se aplicativos sensíveis (como apps de banco e redes sociais) são originais e não foram modificados por hackers.\n\n⚠️ Por que é crítico?\n• Apps falsos podem roubar suas credenciais bancárias\n• Podem clonar seu WhatsApp\n• Podem interceptar códigos 2FA\n\n✅ O que significa?\nSe falhou: Algum app instalado no seu celular não é o original da loja oficial (Play Store) e pode ser perigoso.';

  @override
  String get expRootTitle => 'Root/Jailbreak';

  @override
  String get expRootDesc =>
      'Root (Android) ou Jailbreak (iOS) é quando alguém modifica o sistema do celular para ter acesso total.\n\n⚠️ Por que é perigoso?\n• Apps maliciosos podem roubar suas senhas\n• Seus dados bancários ficam vulneráveis\n• Apps de banco podem não funcionar\n\n✅ O que fazer?\nSe você não fez isso de propósito, seu celular pode estar comprometido. Considere restaurá-lo às configurações de fábrica.';

  @override
  String get expDebuggerTitle => 'Debugger (Depurador)';

  @override
  String get expDebuggerDesc =>
      'Um debugger é uma ferramenta usada por programadores para analisar apps.\n\n⚠️ Por que é perigoso?\n• Hackers podem usar para espionar o app\n• Podem descobrir senhas e dados sensíveis\n• Podem modificar o comportamento do app\n\n✅ O que fazer?\nSe você não é desenvolvedor, não deveria ter um debugger ativo. Feche apps de desenvolvimento ou reinicie o celular.';

  @override
  String get expHookingTitle => 'Hooking (Interceptação)';

  @override
  String get expHookingDesc =>
      'Hooking é quando um programa malicioso intercepta e modifica o funcionamento de apps.\n\n⚠️ Por que é perigoso?\n• Pode roubar suas senhas enquanto você digita\n• Pode modificar transações bancárias\n• Pode ler mensagens privadas\n\n✅ O que fazer?\nDesinstale apps suspeitos, especialmente \"otimizadores\" ou \"aceleradores\" que você não conhece.';

  @override
  String get expIntegrityTitle => 'Integridade do App';

  @override
  String get expIntegrityDesc =>
      'Verifica se este app foi modificado após ser instalado.\n\n⚠️ Por que é importante?\n• Apps modificados podem conter vírus\n• Podem roubar seus dados\n• Podem não funcionar corretamente\n\n✅ O que significa?\nSe passou: O app está original e seguro\nSe falhou: O app pode ter sido adulterado';

  @override
  String get expOSTitle => 'Sistema Atualizado';

  @override
  String get expOSDesc =>
      'Verifica se seu Android/iOS está atualizado.\n\n⚠️ Por que é importante?\n• Sistemas antigos têm falhas de segurança conhecidas\n• Hackers exploram essas falhas\n• Você fica vulnerável a vírus\n\n✅ O que fazer?\nVá em Configurações → Atualização do Sistema e instale as atualizações disponíveis.';

  @override
  String get expLockTitle => 'Bloqueio de Tela';

  @override
  String get expLockDesc =>
      'Verifica se você tem senha, PIN, padrão ou biometria configurados.\n\n⚠️ Por que é importante?\n• Qualquer pessoa pode pegar seu celular desbloqueado\n• Podem acessar seus apps, fotos e mensagens\n• Podem fazer compras ou transferências\n\n✅ O que fazer?\nConfigure uma senha forte ou use sua digital/face em Configurações → Segurança.';

  @override
  String get expEmulatorTitle => 'Dispositivo Real';

  @override
  String get expEmulatorDesc =>
      'Verifica se você está usando um celular real ou um emulador (celular virtual no computador).\n\n⚠️ Por que é importante?\n• Emuladores são usados por hackers para testar ataques\n• Apps bancários não funcionam em emuladores\n• Pode indicar tentativa de fraude\n\n✅ O que significa?\nSe você está em um celular real, deve passar nesta verificação.';

  @override
  String securitySignatureStatus(Object count) {
    return 'Status de Assinaturas ($count)';
  }

  @override
  String get securityAppNotInstalled => 'Não Instalado';

  @override
  String get securityAppVerified => 'Verificado';

  @override
  String get securityAppPendingConfig => 'Pendente Configuração';

  @override
  String get securityAppInvalidSignature => 'Assinatura Inválida!';

  @override
  String get securityAppUnknown => 'Desconhecido';

  @override
  String get securityAppActualHash => 'Atual:';

  @override
  String get securityAppExpectedHash => 'Esperado:';

  @override
  String get securityConfigNeeded => 'Configure...';

  @override
  String get viewerDocUnsupported =>
      'Visualização de arquivos .doc (Word 97-2003) ainda não é suportada por limitações técnicas.\n\nPor favor, salve o arquivo como .docx para visualizar.';

  @override
  String get viewerDocEmpty =>
      'O arquivo parece vazio ou o texto não pôde ser extraído.\n\nNota: Imagens e formatações complexas não são exibidas.';

  @override
  String get viewerDocInvalid =>
      'Erro de Formato:\nEste arquivo não é um DOCX válido.\n1. Pode ser um arquivo .doc antigo (Word 97-2003) renomeado manualmente.\n2. Pode estar corrompido.\n\nSolução: Abra no Word e use \'Salvar Como\' -> \'.docx\'.';

  @override
  String viewerDocError(Object error) {
    return 'Erro ao ler o documento DOCX:\n$error';
  }

  @override
  String viewerExcelError(Object error) {
    return 'Erro ao ler arquivo Excel:\n$error';
  }

  @override
  String viewerZipError(Object error) {
    return 'Erro ao ler arquivo ZIP:\n$error';
  }

  @override
  String viewerCertificateBinary(Object extension) {
    return 'Este arquivo de certificado ($extension) é binário.\nVisualização de conteúdo bruto não suportada para este formato.';
  }

  @override
  String viewerFileError(Object error) {
    return 'Erro ao ler o arquivo:\n$error';
  }

  @override
  String viewerSaveError(Object error) {
    return 'Erro ao salvar: $error';
  }

  @override
  String get viewerTooltipShowFormatted => 'Mostrar Formatado';

  @override
  String get viewerTooltipShowRaw => 'Mostrar Bruto';

  @override
  String get aiErrorKeyMissing =>
      'Erro: Chave de API ausente. Por favor configure nas Configurações.';

  @override
  String aiErrorCommunication(Object error) {
    return 'Erro de comunicação com IA: $error';
  }

  @override
  String aiSystemPrompt(Object language) {
    return 'Você é um Assistente de Arquivos inteligente integrado ao MviewerPlus. Sua tarefa é analisar o conteúdo do arquivo fornecido e ajudar o usuário. Responda no idioma: $language.';
  }

  @override
  String get aiDisclaimer =>
      'A IA pode cometer erros. Verifique informações importantes.';

  @override
  String get reportContent => 'Reportar';

  @override
  String get reportContentDialogTitle => 'Reportar Conteúdo';

  @override
  String get reportContentDialogDesc =>
      'Deseja reportar e limpar esta conversa por conteúdo inapropriado?';

  @override
  String get reportActionClear => 'Reportar e Limpar';

  @override
  String get reportThanks =>
      'Obrigado pelo seu reporte. O conteúdo foi removido.';

  @override
  String get unknown => 'Desconhecido';

  @override
  String videoError(Object error) {
    return 'Erro ao reproduzir vídeo: $error';
  }

  @override
  String get videoLoadingError => 'Falha ao carregar vídeo';

  @override
  String get globalErrorTitle => 'Ops, algo não saiu como esperado.';

  @override
  String get globalErrorDesc => 'Não se preocupe, seus dados estão seguros.';

  @override
  String get backToHome => 'Voltar para o Início';
}

/// The translations for Portuguese, as used in Brazil (`pt_BR`).
class AppLocalizationsPtBr extends AppLocalizationsPt {
  AppLocalizationsPtBr() : super('pt_BR');

  @override
  String get appTitle => 'MviewerPlus';

  @override
  String get openFile => 'Abrir Arquivo';

  @override
  String get copyContent => 'Copiar Conteúdo';

  @override
  String get copiedToClipboard =>
      'Conteúdo copiado para a área de transferência';

  @override
  String get errorLoadingFile => 'Erro ao carregar arquivo';

  @override
  String get emptyCsv => 'CSV Vazio';

  @override
  String get subtitle => 'O Leitor Universal de Arquivos';

  @override
  String get supportsHint =>
      'Suporta .txt, .json, .csv, .xml, .sql, .log e mais';

  @override
  String get privacyPolicy => 'Política de Privacidade';

  @override
  String get settings => 'Configurações';

  @override
  String get termsOfService => 'Termos de Uso';

  @override
  String get language => 'Idioma';

  @override
  String get theme => 'Tema';

  @override
  String get apiKey => 'Chave de API da IA';

  @override
  String get enterApiKey => 'Insira sua Chave de API da Groq';

  @override
  String get apiKeyDesc => 'Obter a chave gratuita';

  @override
  String get save => 'Salvar';

  @override
  String get getApiKeyHelpBtn => 'Como obter uma chave? (Toque aqui)';

  @override
  String get getApiKeyDialogTitle => 'Obtendo uma Chave de API da Groq';

  @override
  String get getApiKeyDialogContent =>
      '1. Acesse console.groq.com\n2. Cadastre-se ou faça login\n3. Vá para a seção \"API Keys\"\n4. Crie uma nova chave e copie-a aqui.';

  @override
  String get close => 'Fechar';

  @override
  String get cancel => 'Cancelar';

  @override
  String get aiAssistant => 'Assistente IA';

  @override
  String get askAboutFile => 'Pergunte sobre o arquivo...';

  @override
  String get systemNote => 'Nota do Sistema';

  @override
  String analyzedFile(Object fileName) {
    return 'Analisei $fileName. Pergunte-me qualquer coisa sobre o conteúdo!';
  }

  @override
  String get fileTooLarge =>
      'Arquivo muito grande. Conteúdo truncado para análise.';

  @override
  String get privacyPolicyContent =>
      'Última atualização: Dezembro de 2025\n\nEsta Política de Privacidade descreve como o MviewerPlus trata suas informações.\n\n1. Coleta e Processamento\nNão coletamos dados pessoais. O processamento de arquivos é local no seu dispositivo.\n\n2. Recursos de IA\nAo usar o assistente de IA, o conteúdo do arquivo é enviado para a API da Groq usando sua Chave de API pessoal. Nenhum dado é armazenado por nós.\n\n3. Modelo Gratuito\nEste aplicativo é 100% gratuito, open-source e não exibe anúncios.\n\n4. Contato\nEm caso de dúvidas, entre em contato: contato@multiversodigital.com.br';

  @override
  String get termsContent =>
      'Termos de Uso\n\nAo usar o MviewerPlus, você concorda com estes termos.\n\n1. Uso\nVocê é responsável pelo conteúdo que acessa usando este visualizador.\n\n2. Responsabilidade\nO desenvolvedor não se responsabiliza por qualquer perda de dados ou problemas decorrentes do uso deste software.\n\n3. Atualizações\nEstes termos podem mudar a qualquer momento.';

  @override
  String get about => 'Sobre';

  @override
  String get companyName => 'Multiverso Digital';

  @override
  String get contactEmail => 'contato@multiversodigital.com.br';

  @override
  String get appVersion => 'Versão 1.0.0';

  @override
  String get copyMessage => 'Copiar Mensagem';

  @override
  String get exportPdf => 'Exportar para PDF';

  @override
  String get pdfGenerated => 'PDF gerado com sucesso';

  @override
  String get errorGeneratingPdf => 'Erro ao gerar PDF';

  @override
  String get exportOptionsTitle => 'Opções de Exportação';

  @override
  String get exportOptionsContent =>
      'Você quer também gerar um PDF do arquivo original?';

  @override
  String get exportChatOnly => 'Apenas Chat';

  @override
  String get exportBoth => 'Chat e Arquivo';

  @override
  String get print => 'Imprimir';

  @override
  String get share => 'Compartilhar';

  @override
  String get saveChangesTitle => 'Salvar Cópia?';

  @override
  String get saveChangesContent =>
      'Isso salvará uma cópia do arquivo editado. O arquivo original será preservado.';

  @override
  String saveCopySuccess(Object path) {
    return 'Cópia salva em: $path';
  }

  @override
  String get savedFiles => 'Arquivos Salvos';

  @override
  String get noSavedFiles => 'Nenhum arquivo salvo encontrado';

  @override
  String get history => 'Histórico';

  @override
  String get deleteTitle => 'Confirmar Exclusão';

  @override
  String get deleteContent => 'Tem certeza que deseja remover este item?';

  @override
  String get delete => 'Excluir';

  @override
  String get find => 'Localizar';

  @override
  String get replace => 'Substituir';

  @override
  String get replaceAll => 'Substituir Tudo';

  @override
  String replacedSuccess(Object count) {
    return '$count ocorrências substituídas';
  }

  @override
  String get includeOriginal => 'Incluir Conteúdo do Arquivo';

  @override
  String get processing => 'Processando...';

  @override
  String processingColumns(Object columns) {
    return 'Analisando $columns colunas...';
  }

  @override
  String get pdfReportTitle => 'Relatório MviewerPlus';

  @override
  String get pdfGeneratedLabel => 'Gerado em:';

  @override
  String get pdfFileLabel => 'Arquivo:';

  @override
  String get pdfSizeLabel => 'Tamanho:';

  @override
  String get pdfRecordsLabel => 'Registros:';

  @override
  String get pdfPage => 'Página';

  @override
  String get pdfOf => 'de';

  @override
  String get rows => 'linhas';

  @override
  String get files => 'arquivos';

  @override
  String get lines => 'linhas';

  @override
  String get archiveBadge => 'ARQUIVO';

  @override
  String get zipEmpty => 'Arquivo ZIP vazio ou inválido';

  @override
  String zipArchiveInfo(Object count) {
    return 'Arquivo ZIP ($count arquivos)';
  }

  @override
  String get fileName => 'Nome do Arquivo';

  @override
  String get fileType => 'Tipo';

  @override
  String get fileSizeCol => 'Tamanho (KB)';

  @override
  String get searchNotAvailableZip =>
      'Busca não disponível para arquivos compactados.';

  @override
  String get readOnlyFormat => 'Este formato é apenas para leitura.';

  @override
  String get processingWait => 'Lendo arquivo, aguarde.';

  @override
  String get loadingTitle => 'Carregando...';

  @override
  String get help => 'Ajuda';

  @override
  String get helpTitle => 'Guia de Ajuda do MviewerPlus';

  @override
  String get featuresSection => 'Funcionalidades Principais';

  @override
  String get featuresContent =>
      '• Visualização Rápida: Abra arquivos grandes instantaneamente com performance nativa.\n• Edição e Busca: Edite textos, código e dados. Use \'Localizar e Substituir\' avançado.\n• Edição Segura: Seus arquivos originais nunca são alterados. O app trabalha em uma cópia, salva no \'Histórico\' do Menu Principal.\n• Tabelas Inteligentes: Visualize CSVs e Excel como planilhas interativas com ordenação e filtros.\n• Editor de Código: Sintaxe colorida para mais de 30 linguagens (Dart, JS, Python, SQL...).\n• Checagem de Segurança: Verifique integridade do app, root, debuggers e assinaturas digitais.\n• Análise com IA: Conecte sua chave Groq para \'conversar\' com seus documentos.\n• Arquivos ZIP: Navegue dentro de arquivos compactados como se fossem pastas.\n• Multimídia: Player nativo para áudio e vídeo.';

  @override
  String get formatsSection => 'Formatos Suportados';

  @override
  String get exit => 'Sair';

  @override
  String get exitConfirm => 'Deseja fechar o aplicativo?';

  @override
  String get formatsContent =>
      '• Texto & Código: .txt, .md, .log, .json, .xml, .yaml, .yml, .html, .css, .js, .ts, .dart, .java, .kt, .swift, .py, .rb, .php, .go, .c, .cpp, .cs, .sql, .sh, .conf, .env, .ini\n• Dados & Planilhas: .csv, .xlsx, .xls\n• Documentos: .pdf, .docx (texto)\n• Imagens: .png, .jpg, .jpeg, .gif, .webp, .bmp\n• Áudio: .mp3, .wav, .ogg, .m4a, .aac, .flac\n• Vídeo: .mp4, .mov, .avi, .mkv, .webm, .wmv, .flv, .3gp\n• Arquivos: .zip, .apk, .jar\n• Certificados: .pem, .crt, .cer, .p12, .pfx, .der';

  @override
  String get cookieInspector => 'Inspetor de Cookies';

  @override
  String get cookieInspectorDesc => 'Gerenciar e analisar cookies';

  @override
  String get httpCookies => 'Cookies HTTP';

  @override
  String get webviewCookies => 'Cookies WebView';

  @override
  String get securityLogs => 'Segurança e Logs';

  @override
  String get cookieWarning =>
      'Cookies podem conter tokens de sessão e login. Use com cuidado.';

  @override
  String get urlOrDomain => 'URL ou Domínio';

  @override
  String get listCookies => 'Listar';

  @override
  String get exportCookies => 'Exportar';

  @override
  String get deleteAllCookies => 'Excluir Todos';

  @override
  String get noCookiesFound => 'Nenhum cookie encontrado';

  @override
  String get enterUrlAndList => 'Digite uma URL e clique em \'Listar\'';

  @override
  String get cookieName => 'Nome';

  @override
  String get cookieValue => 'Valor';

  @override
  String get cookieDomain => 'Domínio';

  @override
  String get cookiePath => 'Caminho';

  @override
  String get cookieExpires => 'Expira';

  @override
  String get cookieSecure => 'Seguro';

  @override
  String get cookieHttpOnly => 'HttpOnly';

  @override
  String get cookieSameSite => 'SameSite';

  @override
  String get cookieSensitive => 'Cookie sensível';

  @override
  String get securitySignals => 'Sinais de Segurança';

  @override
  String get copyValue => 'Copiar Valor';

  @override
  String get editCookie => 'Editar';

  @override
  String get deleteCookie => 'Excluir';

  @override
  String get revealValue => 'Revelar valor completo';

  @override
  String get confirmDeletion => 'Confirmar Exclusão';

  @override
  String deleteConfirmMsg(Object name) {
    return 'Deseja excluir o cookie \"$name\"?';
  }

  @override
  String get sessionWarning => 'Esta ação pode encerrar sessões ativas.';

  @override
  String get deleteAllConfirmTitle => '⚠️ Confirmar Exclusão em Massa';

  @override
  String get deleteAllConfirmMsg => 'Deseja excluir TODOS os cookies?';

  @override
  String get deleteAllWarning =>
      'ATENÇÃO: Esta ação é irreversível!\n• Todas as sessões serão encerradas\n• Você será desconectado de sites\n• Configurações salvas serão perdidas';

  @override
  String get understandWarning => 'Entendo que isso pode encerrar sessões';

  @override
  String get exportFormat => 'Exportar Cookies';

  @override
  String get exportWarning => 'Este relatório contém cookies de autenticação.';

  @override
  String get exportMasked => 'Valores mascarados (recomendado)';

  @override
  String get exportMaskedDesc => 'Cookies sensíveis serão protegidos';

  @override
  String get exportReal => 'Valores reais';

  @override
  String get exportRealDesc => 'Requer autenticação adicional';

  @override
  String get statistics => '📊 Estatísticas';

  @override
  String get totalCookies => 'Total de Cookies';

  @override
  String get totalDomains => 'Total de Domínios';

  @override
  String get secureCookies => 'Cookies Seguros';

  @override
  String get httpOnlyCookies => 'Cookies HttpOnly';

  @override
  String get expiredCookies => 'Cookies Expirados';

  @override
  String get securityReport => '🔐 Relatório de Segurança';

  @override
  String get viewDetails => 'Ver Detalhes';

  @override
  String get securitySettings => '🔒 Configurações de Segurança';

  @override
  String get biometricAuth => 'Autenticação Biométrica';

  @override
  String get protectSensitiveActions => 'Proteger ações sensíveis';

  @override
  String get configurePin => 'Configurar PIN';

  @override
  String get alternativePin => 'PIN de segurança alternativo';

  @override
  String get authRequired => 'Autenticação Necessária';

  @override
  String get configurePinMsg =>
      'Configure um PIN de segurança para proteger ações sensíveis.';

  @override
  String get enterPin => 'Digite seu PIN';

  @override
  String get pinMinLength => 'PIN (mínimo 4 dígitos)';

  @override
  String get confirmPin => 'Confirmar PIN';

  @override
  String get pinsDoNotMatch => 'PINs não coincidem';

  @override
  String get pinTooShort => 'PIN deve ter no mínimo 4 dígitos';

  @override
  String get pinConfigured => 'PIN configurado';

  @override
  String get errorConfiguringPin => 'Erro ao configurar PIN';

  @override
  String get webviewLimitations =>
      'Aviso: Cookies com flags httpOnly e secure podem não ser visíveis através do JavaScript. Para visualizar todos os cookies, use ferramentas de desenvolvedor do navegador ou acesse via HTTP Cookie Manager.';

  @override
  String get webviewRequiresActive =>
      'Esta funcionalidade requer uma WebView ativa.';

  @override
  String get valueCopied => 'Valor copiado para a área de transferência';

  @override
  String get cookieUpdated => 'Cookie atualizado';

  @override
  String get errorUpdatingCookie => 'Erro ao atualizar cookie';

  @override
  String get cookieDeleted => 'Cookie excluído';

  @override
  String get errorDeletingCookie => 'Erro ao excluir cookie';

  @override
  String get allCookiesDeleted => 'Todos os cookies foram excluídos';

  @override
  String get errorDeletingCookies => 'Erro ao excluir cookies';

  @override
  String get noCookiesToExport => 'Nenhum cookie para exportar';

  @override
  String get jsonCopied => 'JSON copiado para área de transferência';

  @override
  String get csvCopied => 'CSV copiado para área de transferência';

  @override
  String errorExporting(Object error) {
    return 'Erro ao exportar: $error';
  }

  @override
  String get fullSecurityReport => 'Relatório de Segurança Completo';

  @override
  String get reportCopied => 'Relatório copiado';

  @override
  String get premium => 'Premium';

  @override
  String get goPremium => 'Seja Premium';

  @override
  String get restorePurchases => 'Restaurar Compras';

  @override
  String get premiumDesc => 'Desbloqueie acesso ilimitado e remova anúncios.';

  @override
  String get securityCheck => 'Verificação de Segurança';

  @override
  String get securityCheckDesc => 'Verificar segurança do dispositivo';

  @override
  String get refresh => 'Atualizar';

  @override
  String securityCheckError(Object error) {
    return 'Erro ao verificar segurança: $error';
  }

  @override
  String get noResultsAvailable => 'Nenhum resultado disponível';

  @override
  String get securityLevel => 'Nível de Segurança';

  @override
  String get riskScore => 'Pontuação de Risco';

  @override
  String get checks => 'Verificações';

  @override
  String get recommendedActions => 'Ações Recomendadas';

  @override
  String get criticalThreats => 'Ameaças Críticas';

  @override
  String get warnings => 'Avisos';

  @override
  String get safe => 'Seguro';

  @override
  String get critical => 'Crítico';

  @override
  String get warning => 'Aviso';

  @override
  String get checksPerformed => 'Verificações Realizadas';

  @override
  String get checkRootJailbreak => 'Root/Jailbreak';

  @override
  String get checkDebugger => 'Debugger';

  @override
  String get checkHooking => 'Hooking';

  @override
  String get checkIntegrity => 'Integridade do App';

  @override
  String get checkOSVersion => 'Sistema Atualizado';

  @override
  String get checkScreenLock => 'Bloqueio de Tela';

  @override
  String get checkRealDevice => 'Dispositivo Real';

  @override
  String get statusOk => 'OK';

  @override
  String get statusFailed => 'FALHOU';

  @override
  String get understood => 'Entendi';

  @override
  String get securityLevelSafe => 'Seguro';

  @override
  String get securityLevelWarning => 'Avisos Detectados';

  @override
  String get securityLevelCritical => 'AMEAÇAS CRÍTICAS';

  @override
  String get securityDescSafe => 'Todas as verificações de segurança passaram';

  @override
  String get securityDescWarning =>
      'Algumas configurações podem ser melhoradas';

  @override
  String get securityDescCritical =>
      'Ameaças críticas detectadas - Ação necessária';

  @override
  String get actionRootTitle => 'Dispositivo com Root Detectado';

  @override
  String get actionRootDesc =>
      'Seu dispositivo está com privilégios de superusuário (root). Isso compromete a segurança do aplicativo.';

  @override
  String get actionRootRec =>
      'Remova o root do dispositivo ou use um dispositivo sem root.';

  @override
  String get actionDebuggerTitle => 'Debugger Detectado';

  @override
  String get actionDebuggerDesc =>
      'Um debugger está anexado ao aplicativo. Isso pode indicar tentativa de análise ou modificação do app.';

  @override
  String get actionDebuggerRec =>
      'Feche todas as ferramentas de desenvolvimento e reinicie o app.';

  @override
  String get actionHookingTitle => 'Framework de Hooking Detectado';

  @override
  String get actionHookingDesc =>
      'Foi detectado um framework de hooking (Frida, Xposed, etc.). Isso pode permitir modificação do comportamento do app.';

  @override
  String get actionHookingRec =>
      'Remova frameworks de hooking e reinicie o dispositivo.';

  @override
  String get actionIntegrityTitle => 'Integridade do App Comprometida';

  @override
  String get actionIntegrityDesc =>
      'A assinatura do aplicativo não corresponde à esperada. O app pode ter sido modificado.';

  @override
  String get actionIntegrityRec =>
      'Reinstale o app da loja oficial (Google Play/App Store).';

  @override
  String get actionOSTitle => 'Sistema Operacional Desatualizado';

  @override
  String get actionOSDesc =>
      'Seu sistema operacional está desatualizado e pode conter vulnerabilidades de segurança.';

  @override
  String get actionOSRec =>
      'Atualize seu sistema operacional para a versão mais recente.';

  @override
  String get actionLockTitle => 'Bloqueio de Tela Não Configurado';

  @override
  String get actionLockDesc =>
      'Seu dispositivo não possui bloqueio de tela configurado. Isso facilita acesso não autorizado.';

  @override
  String get actionLockRec =>
      'Configure um PIN, senha, padrão ou biometria nas configurações.';

  @override
  String get actionEmulatorTitle => 'Executando em Emulador';

  @override
  String get actionEmulatorDesc =>
      'O app está rodando em um emulador. Algumas funcionalidades podem estar limitadas.';

  @override
  String get actionEmulatorRec =>
      'Use um dispositivo físico para melhor experiência.';

  @override
  String get actionUnknownSourcesTitle =>
      'Instalação de Fontes Desconhecidas Habilitada';

  @override
  String get actionUnknownSourcesDesc =>
      'Seu dispositivo permite instalação de apps de fontes desconhecidas. Isso facilita a instalação de malware e spyware.';

  @override
  String get actionUnknownSourcesRec =>
      'Desabilite \'Instalar apps de fontes desconhecidas\' nas configurações de segurança.';

  @override
  String get actionLocationTitle =>
      'Apps com Localização \'Sempre\' Detectados';

  @override
  String actionLocationDesc(Object count) {
    return '$count app(s) têm permissão de rastreamento de localização em segundo plano. Isso representa risco de privacidade.';
  }

  @override
  String get actionLocationRec =>
      'Revise as permissões de localização e mude para \'Apenas durante o uso\' quando possível.';

  @override
  String get actionNotifTitle =>
      'Notificações Sensíveis Visíveis na Tela de Bloqueio';

  @override
  String get actionNotifDesc =>
      'Prévias de notificações (mensagens, códigos 2FA) são exibidas na tela de bloqueio. Isso pode permitir interceptação de dados sensíveis.';

  @override
  String get actionNotifRec =>
      'Configure para ocultar conteúdo sensível nas notificações da tela de bloqueio.';

  @override
  String get actionPatchTitle => 'Patch de Segurança Desatualizado';

  @override
  String get actionPatchDesc =>
      'O patch de segurança do seu dispositivo tem mais de 60 dias. Vulnerabilidades conhecidas podem não estar corrigidas.';

  @override
  String get actionPatchRec =>
      'Verifique por atualizações do sistema nas configurações.';

  @override
  String get action2FATitle => 'Ative a Autenticação de Dois Fatores (2FA)';

  @override
  String get action2FADesc =>
      'A autenticação de dois fatores adiciona uma camada extra de segurança às suas contas críticas (Google/Apple ID).';

  @override
  String get action2FARec =>
      'Ative o 2FA nas configurações de segurança da sua conta.';

  @override
  String get expAppSignaturesTitle => 'Monitoramento de Apps';

  @override
  String get expAppSignaturesDesc =>
      'Verifica se aplicativos sensíveis (como apps de banco e redes sociais) são originais e não foram modificados por hackers.\n\n⚠️ Por que é crítico?\n• Apps falsos podem roubar suas credenciais bancárias\n• Podem clonar seu WhatsApp\n• Podem interceptar códigos 2FA\n\n✅ O que significa?\nSe falhou: Algum app instalado no seu celular não é o original da loja oficial (Play Store) e pode ser perigoso.';

  @override
  String get expRootTitle => 'Root/Jailbreak';

  @override
  String get expRootDesc =>
      'Root (Android) ou Jailbreak (iOS) é quando alguém modifica o sistema do celular para ter acesso total.\n\n⚠️ Por que é perigoso?\n• Apps maliciosos podem roubar suas senhas\n• Seus dados bancários ficam vulneráveis\n• Apps de banco podem não funcionar\n\n✅ O que fazer?\nSe você não fez isso de propósito, seu celular pode estar comprometido. Considere restaurá-lo às configurações de fábrica.';

  @override
  String get expDebuggerTitle => 'Debugger (Depurador)';

  @override
  String get expDebuggerDesc =>
      'Um debugger é uma ferramenta usada por programadores para analisar apps.\n\n⚠️ Por que é perigoso?\n• Hackers podem usar para espionar o app\n• Podem descobrir senhas e dados sensíveis\n• Podem modificar o comportamento do app\n\n✅ O que fazer?\nSe você não é desenvolvedor, não deveria ter um debugger ativo. Feche apps de desenvolvimento ou reinicie o celular.';

  @override
  String get expHookingTitle => 'Hooking (Interceptação)';

  @override
  String get expHookingDesc =>
      'Hooking é quando um programa malicioso intercepta e modifica o funcionamento de apps.\n\n⚠️ Por que é perigoso?\n• Pode roubar suas senhas enquanto você digita\n• Pode modificar transações bancárias\n• Pode ler mensagens privadas\n\n✅ O que fazer?\nDesinstale apps suspeitos, especialmente \"otimizadores\" ou \"aceleradores\" que você não conhece.';

  @override
  String get expIntegrityTitle => 'Integridade do App';

  @override
  String get expIntegrityDesc =>
      'Verifica se este app foi modificado após ser instalado.\n\n⚠️ Por que é importante?\n• Apps modificados podem conter vírus\n• Podem roubar seus dados\n• Podem não funcionar corretamente\n\n✅ O que significa?\nSe passou: O app está original e seguro\nSe falhou: O app pode ter sido adulterado';

  @override
  String get expOSTitle => 'Sistema Atualizado';

  @override
  String get expOSDesc =>
      'Verifica se seu Android/iOS está atualizado.\n\n⚠️ Por que é importante?\n• Sistemas antigos têm falhas de segurança conhecidas\n• Hackers exploram essas falhas\n• Você fica vulnerável a vírus\n\n✅ O que fazer?\nVá em Configurações → Atualização do Sistema e instale as atualizações disponíveis.';

  @override
  String get expLockTitle => 'Bloqueio de Tela';

  @override
  String get expLockDesc =>
      'Verifica se você tem senha, PIN, padrão ou biometria configurados.\n\n⚠️ Por que é importante?\n• Qualquer pessoa pode pegar seu celular desbloqueado\n• Podem acessar seus apps, fotos e mensagens\n• Podem fazer compras ou transferências\n\n✅ O que fazer?\nConfigure uma senha forte ou use sua digital/face em Configurações → Segurança.';

  @override
  String get expEmulatorTitle => 'Dispositivo Real';

  @override
  String get expEmulatorDesc =>
      'Verifica se você está usando um celular real ou um emulador (celular virtual no computador).\n\n⚠️ Por que é importante?\n• Emuladores são usados por hackers para testar ataques\n• Apps bancários não funcionam em emuladores\n• Pode indicar tentativa de fraude\n\n✅ O que significa?\nSe você está em um celular real, deve passar nesta verificação.';

  @override
  String securitySignatureStatus(Object count) {
    return 'Status de Assinaturas ($count)';
  }

  @override
  String get securityAppNotInstalled => 'Não Instalado';

  @override
  String get securityAppVerified => 'Verificado';

  @override
  String get securityAppPendingConfig => 'Pendente Configuração';

  @override
  String get securityAppInvalidSignature => 'Assinatura Inválida!';

  @override
  String get securityAppUnknown => 'Desconhecido';

  @override
  String get securityAppActualHash => 'Atual:';

  @override
  String get securityAppExpectedHash => 'Esperado:';

  @override
  String get securityConfigNeeded => 'Configure...';

  @override
  String get viewerDocUnsupported =>
      'Visualização de arquivos .doc (Word 97-2003) ainda não é suportada por limitações técnicas.\n\nPor favor, salve o arquivo como .docx para visualizar.';

  @override
  String get viewerDocEmpty =>
      'O arquivo parece vazio ou o texto não pôde ser extraído.\n\nNota: Imagens e formatações complexas não são exibidas.';

  @override
  String get viewerDocInvalid =>
      'Erro de Formato:\nEste arquivo não é um DOCX válido.\n1. Pode ser um arquivo .doc antigo (Word 97-2003) renomeado manualmente.\n2. Pode estar corrompido.\n\nSolução: Abra no Word e use \'Salvar Como\' -> \'.docx\'.';

  @override
  String viewerDocError(Object error) {
    return 'Erro ao ler o documento DOCX:\n$error';
  }

  @override
  String viewerExcelError(Object error) {
    return 'Erro ao ler arquivo Excel:\n$error';
  }

  @override
  String viewerZipError(Object error) {
    return 'Erro ao ler arquivo ZIP:\n$error';
  }

  @override
  String viewerCertificateBinary(Object extension) {
    return 'Este arquivo de certificado ($extension) é binário.\nVisualização de conteúdo bruto não suportada para este formato.';
  }

  @override
  String viewerFileError(Object error) {
    return 'Erro ao ler o arquivo:\n$error';
  }

  @override
  String viewerSaveError(Object error) {
    return 'Erro ao salvar: $error';
  }

  @override
  String get viewerTooltipShowFormatted => 'Mostrar Formatado';

  @override
  String get viewerTooltipShowRaw => 'Mostrar Bruto';

  @override
  String get aiErrorKeyMissing =>
      'Erro: Chave de API ausente. Por favor configure nas Configurações.';

  @override
  String aiErrorCommunication(Object error) {
    return 'Erro de comunicação com IA: $error';
  }

  @override
  String aiSystemPrompt(Object language) {
    return 'Você é um Assistente de Arquivos inteligente integrado ao MviewerPlus. Sua tarefa é analisar o conteúdo do arquivo fornecido e ajudar o usuário. Responda no idioma: $language.';
  }

  @override
  String get aiDisclaimer =>
      'A IA pode cometer erros. Verifique informações importantes.';

  @override
  String get reportContent => 'Reportar';

  @override
  String get reportContentDialogTitle => 'Reportar Conteúdo';

  @override
  String get reportContentDialogDesc =>
      'Deseja reportar e limpar esta conversa por conteúdo inapropriado?';

  @override
  String get reportActionClear => 'Reportar e Limpar';

  @override
  String get reportThanks =>
      'Obrigado pelo seu reporte. O conteúdo foi removido.';

  @override
  String get unknown => 'Desconhecido';

  @override
  String videoError(Object error) {
    return 'Erro ao reproduzir vídeo: $error';
  }

  @override
  String get videoLoadingError => 'Falha ao carregar vídeo';

  @override
  String get globalErrorTitle => 'Ops, algo não saiu como esperado.';

  @override
  String get globalErrorDesc => 'Não se preocupe, seus dados estão seguros.';

  @override
  String get backToHome => 'Voltar para o Início';
}

/// The translations for Portuguese, as used in Portugal (`pt_PT`).
class AppLocalizationsPtPt extends AppLocalizationsPt {
  AppLocalizationsPtPt() : super('pt_PT');

  @override
  String get appTitle => 'MviewerPlus';

  @override
  String get openFile => 'Abrir Ficheiro';

  @override
  String get copyContent => 'Copiar Conteúdo';

  @override
  String get copiedToClipboard =>
      'Conteúdo copiado para a área de transferência';

  @override
  String get errorLoadingFile => 'Erro ao carregar ficheiro';

  @override
  String get emptyCsv => 'CSV Vazio';

  @override
  String get subtitle => 'O Leitor Universal de Ficheiros';

  @override
  String get supportsHint =>
      'Suporta .txt, .json, .csv, .xml, .sql, .log e outros';

  @override
  String get privacyPolicy => 'Política de Privacidade';

  @override
  String get settings => 'Definições';

  @override
  String get termsOfService => 'Termos de Serviço';

  @override
  String get language => 'Idioma';

  @override
  String get theme => 'Tema';

  @override
  String get apiKey => 'Chave de API da IA';

  @override
  String get enterApiKey => 'Insira a sua Chave de API da Groq';

  @override
  String get apiKeyDesc => 'Obter a chave gratuita';

  @override
  String get save => 'Guardar';

  @override
  String get getApiKeyHelpBtn => 'Como obter uma chave? (Toque aqui)';

  @override
  String get getApiKeyDialogTitle => 'Obter uma Chave de API da Groq';

  @override
  String get getApiKeyDialogContent =>
      '1. Aceda a console.groq.com\n2. Registe-se ou inicie sessão\n3. Vá à secção \"API Keys\"\n4. Crie uma nova chave e copie-a aqui.';

  @override
  String get close => 'Fechar';

  @override
  String get cancel => 'Cancelar';

  @override
  String get aiAssistant => 'Assistente IA';

  @override
  String get askAboutFile => 'Pergunte sobre o ficheiro...';

  @override
  String get systemNote => 'Nota do Sistema';

  @override
  String analyzedFile(Object fileName) {
    return 'Analisei $fileName. Pergunte-me qualquer coisa sobre o conteúdo!';
  }

  @override
  String get fileTooLarge =>
      'Ficheiro muito grande. Conteúdo truncado para análise.';

  @override
  String get privacyPolicyContent =>
      'Última atualização: Dezembro de 2025\n\nEsta Política de Privacidade descreve como o MviewerPlus trata as suas informações.\n\n1. Recolha e Processamento\nNão recolhemos dados pessoais. O processamento de ficheiros é local.\n\n2. Recursos de IA\nAo usar o assistente de IA, o conteúdo do ficheiro é enviado para a API da Groq usando a sua Chave de API pessoal.\n\n3. Modelo Gratuito\nEsta aplicação é 100% gratuita, open-source e não apresenta anúncios.\n\n4. Contacto\nEm caso de dúvidas, contacte: contato@multiversodigital.com.br';

  @override
  String get termsContent =>
      'Termos de Serviço\n\nAo usar o MviewerPlus, concorda com estes termos.\n\n1. Utilização\nÉ responsável pelo conteúdo que acede usando este visualizador.\n\n2. Responsabilidade\nO programador não se responsabiliza por qualquer perda de dados ou problemas decorrentes do uso deste software.\n\n3. Atualizações\nEstes termos podem mudar a qualquer momento.';

  @override
  String get about => 'Sobre';

  @override
  String get companyName => 'Multiverso Digital';

  @override
  String get contactEmail => 'contato@multiversodigital.com.br';

  @override
  String get appVersion => 'Versão 1.0.0';

  @override
  String get copyMessage => 'Copiar Mensagem';

  @override
  String get exportPdf => 'Exportar para PDF';

  @override
  String get pdfGenerated => 'PDF gerado com sucesso';

  @override
  String get errorGeneratingPdf => 'Erro ao gerar PDF';

  @override
  String get exportOptionsTitle => 'Opções de Exportação';

  @override
  String get exportOptionsContent =>
      'Deseja também gerar um PDF do ficheiro original?';

  @override
  String get exportChatOnly => 'Apenas Chat';

  @override
  String get exportBoth => 'Chat e Ficheiro';

  @override
  String get print => 'Imprimir';

  @override
  String get share => 'Partilhar';

  @override
  String get saveChangesTitle => 'Guardar Cópia?';

  @override
  String get saveChangesContent =>
      'Isto guardará uma cópia do ficheiro editado. O ficheiro original será preservado.';

  @override
  String saveCopySuccess(Object path) {
    return 'Cópia guardada em: $path';
  }

  @override
  String get savedFiles => 'Ficheiros Guardados';

  @override
  String get noSavedFiles => 'Nenhum ficheiro guardado encontrado';

  @override
  String get history => 'Histórico';

  @override
  String get deleteTitle => 'Confirmar Eliminação';

  @override
  String get deleteContent => 'Tem a certeza que deseja remover este item?';

  @override
  String get delete => 'Eliminar';

  @override
  String get find => 'Localizar';

  @override
  String get replace => 'Substituir';

  @override
  String get replaceAll => 'Substituir Tudo';

  @override
  String replacedSuccess(Object count) {
    return '$count ocorrências substituídas';
  }

  @override
  String get includeOriginal => 'Incluir Conteúdo do Ficheiro';

  @override
  String get processing => 'A processar...';

  @override
  String processingColumns(Object columns) {
    return 'A analisar $columns colunas...';
  }

  @override
  String get pdfReportTitle => 'Relatório MviewerPlus';

  @override
  String get pdfGeneratedLabel => 'Gerado em:';

  @override
  String get pdfFileLabel => 'Ficheiro:';

  @override
  String get pdfSizeLabel => 'Tamanho:';

  @override
  String get pdfRecordsLabel => 'Registos:';

  @override
  String get pdfPage => 'Página';

  @override
  String get pdfOf => 'de';

  @override
  String get rows => 'linhas';

  @override
  String get files => 'ficheiros';

  @override
  String get lines => 'linhas';

  @override
  String get archiveBadge => 'ARQUIVO';

  @override
  String get zipEmpty => 'Ficheiro ZIP vazio ou inválido';

  @override
  String zipArchiveInfo(Object count) {
    return 'Ficheiro ZIP ($count ficheiros)';
  }

  @override
  String get fileName => 'Nome do Ficheiro';

  @override
  String get fileType => 'Tipo';

  @override
  String get fileSizeCol => 'Tamanho (KB)';

  @override
  String get searchNotAvailableZip =>
      'Pesquisa não disponível para ficheiros compactados.';

  @override
  String get readOnlyFormat => 'Este formato é apenas de leitura.';

  @override
  String get processingWait => 'A ler ficheiro, aguarde.';

  @override
  String get loadingTitle => 'A carregar...';

  @override
  String get help => 'Ajuda';

  @override
  String get helpTitle => 'Guia de Ajuda';

  @override
  String get featuresSection => 'Funcionalidades Principais';

  @override
  String get featuresContent =>
      '• Visualização Rápida: Abra grandes ficheiros instantaneamente com performance nativa.\n• Edição e Pesquisa: Edite texto, código e dados. Use \'Localizar e Substituir\' avançado.\n• Edição Segura: Os seus ficheiros originais nunca são alterados. As cópias são guardadas no \'Histórico\' do Menu Principal.\n• Tabelas Inteligentes: Visualize CSVs e Excel como folhas de cálculo interativas com ordenação e filtros.\n• Editor de Código: Realce de sintaxe para mais de 30 linguagens (Dart, JS, Python, SQL...).\n• Verificação de Segurança: Verifique integridade da app, root, debuggers e assinaturas digitais.\n• Análise IA: Insira a sua Chave API Groq para \'conversar\' com os seus documentos.\n• Ficheiros ZIP: Navegue dentro de ficheiros comprimidos como pastas.\n• Multimídia: Player nativo para áudio e vídeo.';

  @override
  String get formatsSection => 'Formatos Suportados';

  @override
  String get exit => 'Sair';

  @override
  String get exitConfirm => 'Deseja fechar a aplicação?';

  @override
  String get formatsContent =>
      '• Texto & Código: .txt, .md, .log, .json, .xml, .yaml, .yml, .html, .css, .js, .ts, .dart, .java, .kt, .swift, .py, .rb, .php, .go, .c, .cpp, .cs, .sql, .sh, .conf, .env, .ini\n• Dados & Folhas de Cálculo: .csv, .xlsx, .xls\n• Documentos: .pdf, .docx (texto)\n• Imagens: .png, .jpg, .jpeg, .gif, .webp, .bmp\n• Áudio: .mp3, .wav, .ogg, .m4a, .aac, .flac\n• Vídeo: .mp4, .mov, .avi, .mkv, .webm, .wmv, .flv, .3gp\n• Arquivos: .zip, .apk, .jar\n• Certificados: .pem, .crt, .cer, .p12, .pfx, .der';

  @override
  String get cookieInspector => 'Inspetor de Cookies';

  @override
  String get cookieInspectorDesc => 'Gerir e analisar cookies';

  @override
  String get httpCookies => 'Cookies HTTP';

  @override
  String get webviewCookies => 'Cookies WebView';

  @override
  String get securityLogs => 'Segurança e Registos';

  @override
  String get cookieWarning =>
      'Cookies podem conter tokens de sessão. Use com cuidado.';

  @override
  String get urlOrDomain => 'URL ou Domínio';

  @override
  String get listCookies => 'Listar';

  @override
  String get exportCookies => 'Exportar';

  @override
  String get deleteAllCookies => 'Apagar Tudo';

  @override
  String get noCookiesFound => 'Nenhum cookie encontrado';

  @override
  String get enterUrlAndList => 'Insira um URL e clique em \'Listar\'';

  @override
  String get cookieName => 'Nome';

  @override
  String get cookieValue => 'Valor';

  @override
  String get cookieDomain => 'Domínio';

  @override
  String get cookiePath => 'Caminho';

  @override
  String get cookieExpires => 'Expira';

  @override
  String get cookieSecure => 'Seguro';

  @override
  String get cookieHttpOnly => 'HttpOnly';

  @override
  String get cookieSameSite => 'SameSite';

  @override
  String get cookieSensitive => 'Cookie sensível';

  @override
  String get securitySignals => 'Sinais de Segurança';

  @override
  String get copyValue => 'Copiar Valor';

  @override
  String get editCookie => 'Editar';

  @override
  String get deleteCookie => 'Apagar';

  @override
  String get revealValue => 'Revelar valor completo';

  @override
  String get confirmDeletion => 'Confirmar Eliminação';

  @override
  String deleteConfirmMsg(Object name) {
    return 'Deseja apagar o cookie \"$name\"?';
  }

  @override
  String get sessionWarning => 'Esta ação pode encerrar sessões ativas.';

  @override
  String get deleteAllConfirmTitle => '⚠️ Confirmar Eliminação em Massa';

  @override
  String get deleteAllConfirmMsg => 'Deseja apagar TODOS os cookies?';

  @override
  String get deleteAllWarning =>
      'ATENÇÃO: Esta ação é irreversível!\n• Todas as sessões serão encerradas\n• Será desligado de sites\n• Definições guardadas serão perdidas';

  @override
  String get understandWarning => 'Entendo que isto pode encerrar sessões';

  @override
  String get exportFormat => 'Exportar Cookies';

  @override
  String get exportWarning => 'Este relatório contém cookies de autenticação.';

  @override
  String get exportMasked => 'Valores mascarados (recomendado)';

  @override
  String get exportMaskedDesc => 'Cookies sensíveis serão protegidos';

  @override
  String get exportReal => 'Valores reais';

  @override
  String get exportRealDesc => 'Requer autenticação adicional';

  @override
  String get statistics => '📊 Estatísticas';

  @override
  String get totalCookies => 'Total de Cookies';

  @override
  String get totalDomains => 'Total de Domínios';

  @override
  String get secureCookies => 'Cookies Seguros';

  @override
  String get httpOnlyCookies => 'Cookies HttpOnly';

  @override
  String get expiredCookies => 'Cookies Expirados';

  @override
  String get securityReport => '🔐 Relatório de Segurança';

  @override
  String get viewDetails => 'Ver Detalhes';

  @override
  String get securitySettings => '🔒 Definições de Segurança';

  @override
  String get biometricAuth => 'Autenticação Biométrica';

  @override
  String get protectSensitiveActions => 'Proteger ações sensíveis';

  @override
  String get configurePin => 'Configurar PIN';

  @override
  String get alternativePin => 'PIN de segurança alternativo';

  @override
  String get authRequired => 'Autenticação Necessária';

  @override
  String get configurePinMsg =>
      'Configure um PIN de segurança para proteger ações sensíveis.';

  @override
  String get enterPin => 'Insira o seu PIN';

  @override
  String get pinMinLength => 'PIN (mínimo 4 dígitos)';

  @override
  String get confirmPin => 'Confirmar PIN';

  @override
  String get pinsDoNotMatch => 'Os PINs não coincidem';

  @override
  String get pinTooShort => 'O PIN deve ter pelo menos 4 dígitos';

  @override
  String get pinConfigured => 'PIN configurado';

  @override
  String get errorConfiguringPin => 'Erro ao configurar PIN';

  @override
  String get webviewLimitations =>
      'Nota: Cookies com flags httpOnly e secure podem não ser visíveis via JavaScript. Para ver todos, use ferramentas de programador ou HTTP Cookie Manager.';

  @override
  String get webviewRequiresActive =>
      'Esta funcionalidade requer uma WebView ativa.';

  @override
  String get valueCopied => 'Valor copiado para a área de transferência';

  @override
  String get cookieUpdated => 'Cookie atualizado';

  @override
  String get errorUpdatingCookie => 'Erro ao atualizar cookie';

  @override
  String get cookieDeleted => 'Cookie apagado';

  @override
  String get errorDeletingCookie => 'Erro ao apagar cookie';

  @override
  String get allCookiesDeleted => 'Todos os cookies foram apagados';

  @override
  String get errorDeletingCookies => 'Erro ao apagar cookies';

  @override
  String get noCookiesToExport => 'Nenhum cookie para exportar';

  @override
  String get jsonCopied => 'JSON copiado para área de transferência';

  @override
  String get csvCopied => 'CSV copiado para área de transferência';

  @override
  String errorExporting(Object error) {
    return 'Erro ao exportar: $error';
  }

  @override
  String get fullSecurityReport => 'Relatório de Segurança Completo';

  @override
  String get reportCopied => 'Relatório copiado';

  @override
  String get premium => 'Premium';

  @override
  String get goPremium => 'Tornar-se Premium';

  @override
  String get restorePurchases => 'Restaurar Compras';

  @override
  String get premiumDesc => 'Desbloqueie acesso ilimitado e remova anúncios.';

  @override
  String get securityCheck => 'Verificação de Segurança';

  @override
  String get securityCheckDesc => 'Verificar segurança do dispositivo';

  @override
  String get refresh => 'Atualizar';

  @override
  String securityCheckError(Object error) {
    return 'Erro ao verificar a segurança: $error';
  }

  @override
  String get noResultsAvailable => 'Nenhum resultado disponível.';

  @override
  String get securityLevel => 'Nível de Segurança';

  @override
  String get riskScore => 'Pontuação de Risco';

  @override
  String get checks => 'Verificações';

  @override
  String get recommendedActions => 'Ações Recomendadas';

  @override
  String get criticalThreats => 'Ameaças Críticas';

  @override
  String get warnings => 'Avisos';

  @override
  String get safe => 'Seguro';

  @override
  String get critical => 'Crítico';

  @override
  String get warning => 'Aviso';

  @override
  String get checksPerformed => 'Verificações Realizadas';

  @override
  String get checkRootJailbreak => 'Root/Jailbreak';

  @override
  String get checkDebugger => 'Debugger';

  @override
  String get checkHooking => 'Hooking';

  @override
  String get checkIntegrity => 'Integridade da App';

  @override
  String get checkOSVersion => 'Sistema Atualizado';

  @override
  String get checkScreenLock => 'Bloqueio de Ecrã';

  @override
  String get checkRealDevice => 'Dispositivo Real';

  @override
  String get statusOk => 'OK';

  @override
  String get statusFailed => 'FALHOU';

  @override
  String get understood => 'Entendi';

  @override
  String get securityLevelSafe => 'Seguro';

  @override
  String get securityLevelWarning => 'Avisos Detectados';

  @override
  String get securityLevelCritical => 'AMEAÇAS CRÍTICAS';

  @override
  String get securityDescSafe => 'Todas as verificações de segurança passaram';

  @override
  String get securityDescWarning =>
      'Algumas configurações podem ser melhoradas';

  @override
  String get securityDescCritical =>
      'Ameaças críticas detectadas - Ação necessária';

  @override
  String get actionRootTitle => 'Dispositivo com Root Detectado';

  @override
  String get actionRootDesc =>
      'O seu dispositivo tem privilégios de superutilizador (root). Isto compromete a segurança da aplicação.';

  @override
  String get actionRootRec =>
      'Remova o root do dispositivo ou use um dispositivo sem root.';

  @override
  String get actionDebuggerTitle => 'Debugger Detectado';

  @override
  String get actionDebuggerDesc =>
      'Um debugger está anexado à aplicação. Isto pode indicar tentativa de análise ou modificação da app.';

  @override
  String get actionDebuggerRec =>
      'Feche todas as ferramentas de desenvolvimento e reinicie a app.';

  @override
  String get actionHookingTitle => 'Framework de Hooking Detectado';

  @override
  String get actionHookingDesc =>
      'Foi detectado um framework de hooking (Frida, Xposed, etc.). Isto pode permitir modificação do comportamento da app.';

  @override
  String get actionHookingRec =>
      'Remova frameworks de hooking e reinicie o dispositivo.';

  @override
  String get actionIntegrityTitle => 'Integridade da App Comprometida';

  @override
  String get actionIntegrityDesc =>
      'A assinatura da aplicação não corresponde à esperada. A app pode ter sido modificada.';

  @override
  String get actionIntegrityRec =>
      'Reinstale a app da loja oficial (Google Play/App Store).';

  @override
  String get actionOSTitle => 'Sistema Operativo Desatualizado';

  @override
  String get actionOSDesc =>
      'O seu sistema operativo está desatualizado e pode conter vulnerabilidades de segurança.';

  @override
  String get actionOSRec =>
      'Atualize o seu sistema operativo para a versão mais recente.';

  @override
  String get actionLockTitle => 'Bloqueio de Ecrã Não Configurado';

  @override
  String get actionLockDesc =>
      'O seu dispositivo não possui bloqueio de ecrã configurado. Isto facilita o acesso não autorizado.';

  @override
  String get actionLockRec =>
      'Configure um PIN, palavra-passe, padrão ou biometria nas definições.';

  @override
  String get actionEmulatorTitle => 'A Executar em Emulador';

  @override
  String get actionEmulatorDesc =>
      'A app está a correr num emulador. Algumas funcionalidades podem estar limitadas.';

  @override
  String get actionEmulatorRec =>
      'Use um dispositivo físico para melhor experiência.';

  @override
  String get actionUnknownSourcesTitle =>
      'Instalação de Fontes Desconhecidas Ativada';

  @override
  String get actionUnknownSourcesDesc =>
      'O seu dispositivo permite instalação de apps de fontes desconhecidas. Isto facilita a instalação de malware.';

  @override
  String get actionUnknownSourcesRec =>
      'Desative \'Instalar apps de fontes desconhecidas\' nas definições de segurança.';

  @override
  String get actionLocationTitle =>
      'Apps com Localização \'Sempre\' Detectados';

  @override
  String actionLocationDesc(Object count) {
    return '$count app(s) têm permissão de rastreio de localização em segundo plano. Isto representa risco de privacidade.';
  }

  @override
  String get actionLocationRec =>
      'Reveja as permissões de localização e mude para \'Apenas durante o uso\' quando possível.';

  @override
  String get actionNotifTitle =>
      'Notificações Sensíveis Visíveis no Ecrã de Bloqueio';

  @override
  String get actionNotifDesc =>
      'Pré-visualizações de notificações (mensagens, códigos 2FA) são exibidas no ecrã de bloqueio. Isto pode permitir interceção de dados sensíveis.';

  @override
  String get actionNotifRec =>
      'Configure para ocultar conteúdo sensível nas notificações do ecrã de bloqueio.';

  @override
  String get actionPatchTitle => 'Patch de Segurança Desatualizado';

  @override
  String get actionPatchDesc =>
      'O patch de segurança do seu dispositivo tem mais de 60 dias.';

  @override
  String get actionPatchRec =>
      'Verifique por atualizações do sistema nas definições.';

  @override
  String get action2FATitle => 'Ative a Autenticação de Dois Fatores (2FA)';

  @override
  String get action2FADesc =>
      'A autenticação de dois fatores adiciona uma camada extra de segurança às suas contas críticas.';

  @override
  String get action2FARec =>
      'Ative o 2FA nas definições de segurança da sua conta.';

  @override
  String get expAppSignaturesTitle => 'Monitorização de Apps';

  @override
  String get expAppSignaturesDesc =>
      'Verifica se aplicativos sensíveis são originais.\n\n⚠️ Por que é crítico?\n• Apps falsas podem roubar credenciais\n\n✅ O que significa?\nSe falhou: Alguma app pode ser perigosa.';

  @override
  String get expRootTitle => 'Root/Jailbreak';

  @override
  String get expRootDesc =>
      'Root ou Jailbreak é quando modificam o sistema do telemóvel para ter acesso total.\n\n⚠️ Por que é perigoso?\n• Dados bancários vulneráveis\n\n✅ O que fazer?\nConsidere restaurar as configurações de fábrica.';

  @override
  String get expDebuggerTitle => 'Debugger (Depurador)';

  @override
  String get expDebuggerDesc =>
      'Ferramenta para analisar apps.\n\n⚠️ Perigo?\n• Espionagem de dados\n\n✅ Ação?\nReinicie o telemóvel se não for programador.';

  @override
  String get expHookingTitle => 'Hooking';

  @override
  String get expHookingDesc =>
      'Modificação de apps em tempo real.\n\n⚠️ Perigo?\n• Roubo de dados\n\n✅ Ação?\nDesinstale apps suspeitas.';

  @override
  String get expIntegrityTitle => 'Integridade da App';

  @override
  String get expIntegrityDesc =>
      'Verifica se esta app foi modificada.\n\n⚠️ Importante:\n• Apps alteradas podem ter vírus\n\n✅ Significado:\nPassou = App original.';

  @override
  String get expOSTitle => 'Sistema Atualizado';

  @override
  String get expOSDesc =>
      'Verifica atualizações do sistema.\n\n⚠️ Importante:\n• Sistemas antigos têm falhas\n\n✅ Ação:\nAtualize o sistema.';

  @override
  String get expLockTitle => 'Bloqueio de Ecrã';

  @override
  String get expLockDesc =>
      'Verifica se tem senha ou biometria.\n\n⚠️ Importante:\n• Impede acesso físico não autorizado\n\n✅ Ação:\nConfigure uma senha forte.';

  @override
  String get expEmulatorTitle => 'Dispositivo Real';

  @override
  String get expEmulatorDesc =>
      'Verifica se é um telemóvel real ou virtual.\n\n✅ Significado:\nDeve usar um telemóvel real.';

  @override
  String securitySignatureStatus(Object count) {
    return 'Estado das Assinaturas ($count)';
  }

  @override
  String get securityAppNotInstalled => 'Não Instalado';

  @override
  String get securityAppVerified => 'Verificado';

  @override
  String get securityAppPendingConfig => 'Configuração Pendiente';

  @override
  String get securityAppInvalidSignature => 'Assinatura Inválida!';

  @override
  String get securityAppUnknown => 'Desconhecido';

  @override
  String get securityAppActualHash => 'Atual:';

  @override
  String get securityAppExpectedHash => 'Esperado:';

  @override
  String get securityConfigNeeded => 'Configurar...';

  @override
  String get viewerDocUnsupported =>
      'Visualização de ficheiros .doc (Word 97-2003) ainda não é suportada por limitações técnicas.\n\nPor favor, guarde o ficheiro como .docx para visualizar.';

  @override
  String get viewerDocEmpty =>
      'O ficheiro parece vazio ou o texto não pôde ser extraído.\n\nNota: Imagens e formatações complexas não são exibidas.';

  @override
  String get viewerDocInvalid =>
      'Erro de Formato:\nEste ficheiro não é um DOCX válido.\n1. Pode ser um ficheiro .doc antigo renomeado manualmente.\n2. Pode estar corrompido.\n\nSolução: Abra no Word e use \'Guardar Como\' -> \'.docx\'.';

  @override
  String viewerDocError(Object error) {
    return 'Erro ao ler o documento DOCX:\n$error';
  }

  @override
  String viewerExcelError(Object error) {
    return 'Erro ao ler ficheiro Excel:\n$error';
  }

  @override
  String viewerZipError(Object error) {
    return 'Erro ao ler ficheiro ZIP:\n$error';
  }

  @override
  String viewerCertificateBinary(Object extension) {
    return 'Este ficheiro de certificado ($extension) é binario.\nVisualização de conteúdo bruto não suportada para este formato.';
  }

  @override
  String viewerFileError(Object error) {
    return 'Erro ao ler o ficheiro:\n$error';
  }

  @override
  String viewerSaveError(Object error) {
    return 'Erro ao guardar: $error';
  }

  @override
  String get viewerTooltipShowFormatted => 'Mostrar Formatado';

  @override
  String get viewerTooltipShowRaw => 'Mostrar Bruto';

  @override
  String get aiErrorKeyMissing =>
      'Erro: Chave de API em falta. Por favor configure nas Definições.';

  @override
  String aiErrorCommunication(Object error) {
    return 'Erro de comunicação com IA: $error';
  }

  @override
  String aiSystemPrompt(Object language) {
    return 'És um Assistente de Ficheiros inteligente integrado no MviewerPlus. A tua tarefa é analisar o conteúdo do ficheiro fornecido e ajudar o utilizador. Responde no idioma: $language.';
  }

  @override
  String get aiDisclaimer =>
      'A IA pode cometer erros. Verifique informações importantes.';

  @override
  String get reportContent => 'Denunciar';

  @override
  String get reportContentDialogTitle => 'Denunciar Conteúdo';

  @override
  String get reportContentDialogDesc =>
      'Deseja denunciar e limpar esta conversa por conteúdo inapropriado?';

  @override
  String get reportActionClear => 'Denunciar e Limpar';

  @override
  String get reportThanks =>
      'Obrigado pela sua denúncia. O conteúdo foi removido.';

  @override
  String get unknown => 'Desconhecido';

  @override
  String videoError(Object error) {
    return 'Erro ao reproduzir vídeo: $error';
  }

  @override
  String get videoLoadingError => 'Falha ao carregar vídeo';

  @override
  String get globalErrorTitle => 'Ops, algo correu mal.';

  @override
  String get globalErrorDesc => 'Não se preocupe, os seus dados estão seguros.';

  @override
  String get backToHome => 'Voltar ao Início';
}
