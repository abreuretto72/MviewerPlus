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
      'Última atualização: Dezembro de 2025\n\nEsta Política de Privacidade descreve como o MviewerPlus coleta, usa e divulga suas informações quando você utiliza nosso Serviço.\n\n1. Coleta de Dados\nNão coletamos dados pessoais. Os arquivos abertos neste aplicativo são processados localmente no seu dispositivo e não são enviados para nenhum servidor.\n\n2. Permissões\nO aplicativo requer permissões de armazenamento apenas para ler os arquivos que você selecionar explicitamente.\n\n3. Serviços de Terceiros\nSe você optar pela versão Gratuita, podemos usar serviços de publicidade de terceiros (ex: AdMob) que podem coletar identificadores de dispositivo para exibir anúncios relevantes. Na versão Premium, nenhum anúncio é exibido.\n\n4. Contate-nos\nSe tiver dúvidas sobre esta Política de Privacidade, entre em contato conosco.';

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
      '• Visualização Rápida: Abra arquivos grandes instantaneamente com performance nativa.\n• Edição e Busca: Edite textos, código e dados. Use \'Localizar e Substituir\' avançado.\n• Tabelas Inteligentes: Visualize CSVs e Excel como planilhas interativas com ordenação e filtros.\n• Editor de Código: Sintaxe colorida para mais de 30 linguagens (Dart, JS, Python, SQL...).\n• Checagem de Segurança: Verifique integridade do app, root, debuggers e assinaturas digitais.\n• Análise com IA: Conecte sua chave Groq para \'conversar\' com seus documentos.\n• Arquivos ZIP: Navegue dentro de arquivos compactados como se fossem pastas.\n• Multimídia: Player nativo para áudio e vídeo.';

  @override
  String get formatsSection => 'Formatos Suportados';

  @override
  String get exit => 'Sair';

  @override
  String get exitConfirm => 'Deseja fechar o aplicativo?';

  @override
  String get formatsContent =>
      '• Texto: .txt, .md, .log, .rtf, .json, .xml, .yaml\n• Dados: .csv, .tsv, .xlsx, .xls, .sql, .db (sqlite)\n• Código: .bat, .c, .cpp, .cs, .css, .dart, .go, .html, .java, .js, .kt, .lua, .php, .py, .rb, .sh, .swift, .ts\n• Documentos: .pdf, .docx (texto)\n• Multimídia: .mp3, .wav, .aac, .mp4, .avi, .mov, .mkv\n• Imagens: .png, .jpg, .jpeg, .gif, .bmp, .webp, .svg\n• Certificados: .cer, .pem, .crt, .der, .p12, .pfx\n• Outros: .zip, .apk';

  @override
  String get cookieInspector => 'Cookie Inspector';

  @override
  String get cookieInspectorDesc => 'Manage and analyze cookies';

  @override
  String get httpCookies => 'HTTP Cookies';

  @override
  String get webviewCookies => 'WebView Cookies';

  @override
  String get securityLogs => 'Security & Logs';

  @override
  String get cookieWarning =>
      'Cookies may contain session and login tokens. Use with caution.';

  @override
  String get urlOrDomain => 'URL or Domain';

  @override
  String get listCookies => 'List';

  @override
  String get exportCookies => 'Export';

  @override
  String get deleteAllCookies => 'Delete All';

  @override
  String get noCookiesFound => 'No cookies found';

  @override
  String get enterUrlAndList => 'Enter a URL and click \'List\'';

  @override
  String get cookieName => 'Name';

  @override
  String get cookieValue => 'Value';

  @override
  String get cookieDomain => 'Domain';

  @override
  String get cookiePath => 'Path';

  @override
  String get cookieExpires => 'Expires';

  @override
  String get cookieSecure => 'Secure';

  @override
  String get cookieHttpOnly => 'HttpOnly';

  @override
  String get cookieSameSite => 'SameSite';

  @override
  String get cookieSensitive => 'Sensitive cookie';

  @override
  String get securitySignals => 'Security Signals';

  @override
  String get copyValue => 'Copy Value';

  @override
  String get editCookie => 'Edit';

  @override
  String get deleteCookie => 'Delete';

  @override
  String get revealValue => 'Reveal full value';

  @override
  String get confirmDeletion => 'Confirm Deletion';

  @override
  String deleteConfirmMsg(Object name) {
    return 'Do you want to delete the cookie \"$name\"?';
  }

  @override
  String get sessionWarning => 'This action may end active sessions.';

  @override
  String get deleteAllConfirmTitle => '⚠️ Confirm Mass Deletion';

  @override
  String get deleteAllConfirmMsg => 'Do you want to delete ALL cookies?';

  @override
  String get deleteAllWarning =>
      'ATTENTION: This action is irreversible!\n• All sessions will be ended\n• You will be logged out of sites\n• Saved settings will be lost';

  @override
  String get understandWarning => 'I understand this may end sessions';

  @override
  String get exportFormat => 'Export Cookies';

  @override
  String get exportWarning => 'This report contains authentication cookies.';

  @override
  String get exportMasked => 'Masked values (recommended)';

  @override
  String get exportMaskedDesc => 'Sensitive cookies will be protected';

  @override
  String get exportReal => 'Real values';

  @override
  String get exportRealDesc => 'Requires additional authentication';

  @override
  String get statistics => '📊 Statistics';

  @override
  String get totalCookies => 'Total Cookies';

  @override
  String get totalDomains => 'Total Domains';

  @override
  String get secureCookies => 'Secure Cookies';

  @override
  String get httpOnlyCookies => 'HttpOnly Cookies';

  @override
  String get expiredCookies => 'Expired Cookies';

  @override
  String get securityReport => '🔐 Security Report';

  @override
  String get viewDetails => 'View Details';

  @override
  String get securitySettings => '🔒 Security Settings';

  @override
  String get biometricAuth => 'Biometric Authentication';

  @override
  String get protectSensitiveActions => 'Protect sensitive actions';

  @override
  String get configurePin => 'Configure PIN';

  @override
  String get alternativePin => 'Alternative security PIN';

  @override
  String get authRequired => 'Authentication Required';

  @override
  String get configurePinMsg =>
      'Configure a security PIN to protect sensitive actions.';

  @override
  String get enterPin => 'Enter your PIN';

  @override
  String get pinMinLength => 'PIN (minimum 4 digits)';

  @override
  String get confirmPin => 'Confirm PIN';

  @override
  String get pinsDoNotMatch => 'PINs do not match';

  @override
  String get pinTooShort => 'PIN must be at least 4 digits';

  @override
  String get pinConfigured => 'PIN configured';

  @override
  String get errorConfiguringPin => 'Error configuring PIN';

  @override
  String get webviewLimitations =>
      'Note: Cookies with httpOnly and secure flags may not be visible through JavaScript. To view all cookies, use browser developer tools or access via HTTP Cookie Manager.';

  @override
  String get webviewRequiresActive =>
      'This functionality requires an active WebView.';

  @override
  String get valueCopied => 'Value copied to clipboard';

  @override
  String get cookieUpdated => 'Cookie updated';

  @override
  String get errorUpdatingCookie => 'Error updating cookie';

  @override
  String get cookieDeleted => 'Cookie deleted';

  @override
  String get errorDeletingCookie => 'Error deleting cookie';

  @override
  String get allCookiesDeleted => 'All cookies have been deleted';

  @override
  String get errorDeletingCookies => 'Error deleting cookies';

  @override
  String get noCookiesToExport => 'No cookies to export';

  @override
  String get jsonCopied => 'JSON copied to clipboard';

  @override
  String get csvCopied => 'CSV copied to clipboard';

  @override
  String errorExporting(Object error) {
    return 'Error exporting: $error';
  }

  @override
  String get fullSecurityReport => 'Full Security Report';

  @override
  String get reportCopied => 'Report copied';

  @override
  String get premium => 'Premium';

  @override
  String get goPremium => 'Seja Premium';

  @override
  String get restorePurchases => 'Restaurar Compras';

  @override
  String get premiumDesc => 'Desbloqueie acesso ilimitado e remova anúncios.';

  @override
  String get securityCheck => 'Security Check';

  @override
  String get securityCheckDesc => 'Verify device security';

  @override
  String get refresh => 'Refresh';

  @override
  String securityCheckError(Object error) {
    return 'Error checking security: $error';
  }

  @override
  String get noResultsAvailable => 'No results available';

  @override
  String get securityLevel => 'Security Level';

  @override
  String get riskScore => 'Risk Score';

  @override
  String get checks => 'Checks';

  @override
  String get recommendedActions => 'Recommended Actions';

  @override
  String get criticalThreats => 'Critical Threats';

  @override
  String get warnings => 'Warnings';

  @override
  String get safe => 'Safe';

  @override
  String get critical => 'Critical';

  @override
  String get warning => 'Warning';

  @override
  String get checksPerformed => 'Checks Performed';

  @override
  String get checkRootJailbreak => 'Root/Jailbreak';

  @override
  String get checkDebugger => 'Debugger';

  @override
  String get checkHooking => 'Hooking';

  @override
  String get checkIntegrity => 'App Integrity';

  @override
  String get checkOSVersion => 'Updated System';

  @override
  String get checkScreenLock => 'Screen Lock';

  @override
  String get checkRealDevice => 'Real Device';

  @override
  String get statusOk => 'OK';

  @override
  String get statusFailed => 'FAILED';

  @override
  String get understood => 'Understood';

  @override
  String get securityLevelSafe => 'Safe';

  @override
  String get securityLevelWarning => 'Warnings Detected';

  @override
  String get securityLevelCritical => 'CRITICAL THREATS';

  @override
  String get securityDescSafe => 'All security checks passed';

  @override
  String get securityDescWarning => 'Some settings can be improved';

  @override
  String get securityDescCritical =>
      'Critical threats detected - Action required';

  @override
  String get actionRootTitle => 'Root Device Detected';

  @override
  String get actionRootDesc =>
      'Your device has superuser privileges (root). This compromises app security.';

  @override
  String get actionRootRec => 'Remove root or use a non-rooted device.';

  @override
  String get actionDebuggerTitle => 'Debugger Detected';

  @override
  String get actionDebuggerDesc =>
      'A debugger is attached to the application. This may indicate an attempt to analyze or modify the app.';

  @override
  String get actionDebuggerRec => 'Close all developer tools and restart.';

  @override
  String get actionHookingTitle => 'Hooking Framework Detected';

  @override
  String get actionHookingDesc =>
      'A hooking framework (Frida, Xposed) was detected. This allows modifying app behavior.';

  @override
  String get actionHookingRec => 'Remove hooking frameworks and restart.';

  @override
  String get actionIntegrityTitle => 'Compromised App Integrity';

  @override
  String get actionIntegrityDesc =>
      'The app signature does not match expected. The app may have been modified.';

  @override
  String get actionIntegrityRec =>
      'Reinstall from the official store (Play Store).';

  @override
  String get actionOSTitle => 'Outdated Operating System';

  @override
  String get actionOSDesc =>
      'Your OS is outdated and may contain vulnerabilities.';

  @override
  String get actionOSRec => 'Update your OS to the latest version.';

  @override
  String get actionLockTitle => 'No Screen Lock Configured';

  @override
  String get actionLockDesc =>
      'Your device has no screen lock. This facilitates unauthorized access.';

  @override
  String get actionLockRec => 'Set up a PIN, password, or pattern in settings.';

  @override
  String get actionEmulatorTitle => 'Running on Emulator';

  @override
  String get actionEmulatorDesc =>
      'The app is running on an emulator. Some features may be limited.';

  @override
  String get actionEmulatorRec =>
      'Use a physical device for better experience.';

  @override
  String get actionUnknownSourcesTitle => 'Unknown Sources Enabled';

  @override
  String get actionUnknownSourcesDesc =>
      'Your device allows installing apps from unknown sources. This facilitates malware installation.';

  @override
  String get actionUnknownSourcesRec =>
      'Disable \'Install unknown apps\' in security settings.';

  @override
  String get actionLocationTitle => 'Apps with \'Always\' Location';

  @override
  String actionLocationDesc(Object count) {
    return '$count app(s) have background location permission. This poses a privacy risk.';
  }

  @override
  String get actionLocationRec => 'Review location permissions.';

  @override
  String get actionNotifTitle => 'Sensitive Notifications on Lock Screen';

  @override
  String get actionNotifDesc =>
      'Sensitive notification previews (codes, messages) are visible on lock screen.';

  @override
  String get actionNotifRec =>
      'Hide sensitive content on lock screen notifications.';

  @override
  String get actionPatchTitle => 'Outdated Security Patch';

  @override
  String get actionPatchDesc =>
      'Security patch is older than 60 days. Known vulnerabilities may not be patched.';

  @override
  String get actionPatchRec => 'Check for system updates.';

  @override
  String get action2FATitle => 'Enable Two-Factor Authentication (2FA)';

  @override
  String get action2FADesc =>
      '2FA adds an extra layer of security to your critical accounts (Google/Apple ID).';

  @override
  String get action2FARec => 'Enable 2FA in your account security settings.';

  @override
  String get expAppSignaturesTitle => 'App Monitoring';

  @override
  String get expAppSignaturesDesc =>
      'Checks if sensitive apps (like banking and social media apps) are original and have not been modified by hackers.\n\n⚠️ Why is it critical?\n• Fake apps can steal your banking credentials\n• Can clone your WhatsApp\n• Can intercept 2FA codes\n\n✅ What does it mean?\nIf failed: An installed app is not the original from the official store (Play Store) and may be dangerous.';

  @override
  String get expRootTitle => 'Root/Jailbreak';

  @override
  String get expRootDesc =>
      'Root (Android) or Jailbreak (iOS) is when someone modifies the system to gain full access.\n\n⚠️ Why is it dangerous?\n• Malicious apps can steal your passwords\n• Your banking data becomes vulnerable\n• Banking apps might not work\n\n✅ What to do?\nIf you didn\'t do this on purpose, your device may be compromised. Consider factory resetting it.';

  @override
  String get expDebuggerTitle => 'Debugger Detected';

  @override
  String get expDebuggerDesc =>
      'A debugger is a tool used by programmers to analyze apps.\n\n⚠️ Why is it dangerous?\n• Hackers can use it to spy on the app\n• Can discover passwords and sensitive data\n• Can modify app behavior\n\n✅ What to do?\nIf you are not a developer, you shouldn\'t have an active debugger. Close developer instruments or restart the phone.';

  @override
  String get expHookingTitle => 'Hooking Framework';

  @override
  String get expHookingDesc =>
      'Hooking is when a malicious program intercepts and modifies how apps work.\n\n⚠️ Why is it dangerous?\n• Can steal your passwords as you type\n• Can modify banking transactions\n• Can read private messages\n\n✅ What to do?\nUninstall suspicious apps, especially \'optimizers\' or \'boosters\' you don\'t recognize.';

  @override
  String get expIntegrityTitle => 'App Integrity';

  @override
  String get expIntegrityDesc =>
      'Checks if this app has been modified after installation.\n\n⚠️ Why is it important?\n• Modified apps may contain viruses\n• Can steal your data\n• Might not work correctly\n\n✅ What does it mean?\nIf passed: The app is original and safe\nIf failed: The app may have been tampered with';

  @override
  String get expOSTitle => 'System Updated';

  @override
  String get expOSDesc =>
      'Checks if your Android/iOS is up to date.\n\n⚠️ Why is it important?\n• Old systems have known security flaws\n• Hackers exploit these flaws\n• You are vulnerable to viruses\n\n✅ What to do?\nGo to Settings → System Update and install available updates.';

  @override
  String get expLockTitle => 'Screen Lock';

  @override
  String get expLockDesc =>
      'Checks if you have a password, PIN, pattern, or biometrics set up.\n\n⚠️ Why is it important?\n• Anyone can take your unlocked phone\n• Can access your apps, photos, and messages\n• Can make purchases or transfers\n\n✅ What to do?\nSet up a strong password or use your fingerprint/face ID in Settings → Security.';

  @override
  String get expEmulatorTitle => 'Real Device';

  @override
  String get expEmulatorDesc =>
      'Checks if you are using a real phone or an emulator (virtual phone on computer).\n\n⚠️ Why is it important?\n• Emulators are used by hackers to test attacks\n• Banking apps don\'t work on emulators\n• May indicate fraud attempt\n\n✅ What does it mean?\nIf you are on a real phone, you should pass this check.';

  @override
  String securitySignatureStatus(Object count) {
    return 'Signature Status ($count)';
  }

  @override
  String get securityAppNotInstalled => 'Not Installed';

  @override
  String get securityAppVerified => 'Verified';

  @override
  String get securityAppPendingConfig => 'Config Pending';

  @override
  String get securityAppInvalidSignature => 'Invalid Signature!';

  @override
  String get securityAppUnknown => 'Unknown';

  @override
  String get securityAppActualHash => 'Actual:';

  @override
  String get securityAppExpectedHash => 'Expected:';

  @override
  String get securityConfigNeeded => 'Configure...';
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
      '• Visualização Rápida: Abra arquivos grandes instantaneamente com performance nativa.\n• Edição e Busca: Edite textos, código e dados. Use \'Localizar e Substituir\' avançado.\n• Tabelas Inteligentes: Visualize CSVs e Excel como planilhas interativas com ordenação e filtros.\n• Editor de Código: Sintaxe colorida para mais de 30 linguagens (Dart, JS, Python, SQL...).\n• Checagem de Segurança: Verifique integridade do app, root, debuggers e assinaturas digitais.\n• Análise com IA: Conecte sua chave Groq para \'conversar\' com seus documentos.\n• Arquivos ZIP: Navegue dentro de arquivos compactados como se fossem pastas.\n• Multimídia: Player nativo para áudio e vídeo.';

  @override
  String get formatsSection => 'Formatos Suportados';

  @override
  String get formatsContent =>
      '• Texto: .txt, .md, .log, .rtf, .json, .xml, .yaml\n• Dados: .csv, .tsv, .xlsx, .xls, .sql, .db (sqlite)\n• Código: .bat, .c, .cpp, .cs, .css, .dart, .go, .html, .java, .js, .kt, .lua, .php, .py, .rb, .sh, .swift, .ts\n• Documentos: .pdf, .docx (texto)\n• Multimídia: .mp3, .wav, .aac, .mp4, .avi, .mov, .mkv\n• Imagens: .png, .jpg, .jpeg, .gif, .bmp, .webp, .svg\n• Certificados: .cer, .pem, .crt, .der, .p12, .pfx\n• Outros: .zip, .apk';

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
  String get securityConfigNeeded => 'Configurar...';
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
      '• Visualização Rápida: Abra grandes ficheiros instantaneamente.\n• Edição e Pesquisa: Edite texto, localize e substitua termos.\n• Exportação e Partilha: Gere PDFs, imprima e partilhe ficheiros.\n• Tabelas Inteligentes: Visualize CSV e Excel com filtros e ordenação.\n• Editor de Código: Realce de sintaxe para mais de 30 linguagens.\n• Análise IA: Insira a sua Chave API Groq para que a IA analise o conteúdo dos ficheiros e responda a perguntas sobre eles.\n• Ficheiros ZIP: Explore o conteúdo de ficheiros comprimidos.';

  @override
  String get formatsSection => 'Formatos Suportados';

  @override
  String get exit => 'Sair';

  @override
  String get exitConfirm => 'Deseja fechar a aplicação?';

  @override
  String get formatsContent =>
      '• Texto: .txt, .md, .log, .rtf\n• Dados: .csv, .json, .xml, .xlsx, .xls\n• Código: Dart, JS, Python, Java, C++, HTML, CSS, SQL...\n• Imagens: .png, .jpg, .gif\n• Multimídia: .mp3, .wav, .mp4, .avi\n• Docs: .pdf, .docx\n• Outros: .zip, .apk';

  @override
  String get securityCheck => 'Verificação de Segurança';

  @override
  String get refresh => 'Atualizar';

  @override
  String get noResultsAvailable => 'Nenhum resultado disponível.';

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
}
