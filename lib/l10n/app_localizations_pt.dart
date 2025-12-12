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
  String get premium => 'Premium';

  @override
  String get goPremium => 'Seja Premium';

  @override
  String get premiumDesc => 'Desbloqueie acesso ilimitado e remova anúncios.';

  @override
  String get restorePurchases => 'Restaurar Compras';

  @override
  String get termsOfService => 'Termos de Uso';

  @override
  String get language => 'Idioma';

  @override
  String get theme => 'Tema';

  @override
  String get apiKey => 'AI API Key';

  @override
  String get enterApiKey => 'Enter your Groq API Key';

  @override
  String get apiKeyDesc => 'Get free API Key';

  @override
  String get save => 'Save';

  @override
  String get getApiKeyHelpBtn => 'How to get a key? (Tap here)';

  @override
  String get getApiKeyDialogTitle => 'Getting a Groq API Key';

  @override
  String get getApiKeyDialogContent =>
      '1. Go to console.groq.com\n2. Sign up or log in\n3. Go to \"API Keys\" section\n4. Create a new key and copy it here.';

  @override
  String get close => 'Close';

  @override
  String get cancel => 'Cancel';

  @override
  String get aiAssistant => 'AI Assistant';

  @override
  String get askAboutFile => 'Ask about the file...';

  @override
  String get systemNote => 'System Note';

  @override
  String analyzedFile(Object fileName) {
    return 'I have analyzed $fileName. Ask me anything about its content!';
  }

  @override
  String get fileTooLarge =>
      'File is too large. Content has truncated for analysis.';

  @override
  String get privacyPolicyContent =>
      'Last updated: December 2025\n\nThis Privacy Policy describes how MviewerPlus collects, uses, and discloses your information when you use our Service.\n\n1. Data Collection\nWe do not collect any personal data. Files opened in this application are processed locally on your device and are not uploaded to any server.\n\n2. Permissions\nThe app requires storage permissions only to read the files you explicitly select.\n\n3. Third-Party Services\nIf you opt for the Free version, we may use third-party advertising services (e.g., AdMob) which may collect device identifiers to show relevant ads. In the Premium version, no ads are displayed.\n\n4. Contact Us\nIf you have any questions about this Privacy Policy, please contact us.';

  @override
  String get termsContent =>
      'Terms of Service\n\nBy using MviewerPlus, you agree to these terms.\n\n1. Usage\nYou are responsible for the content you access using this viewer.\n\n2. Liability\nThe developer is not liable for any data loss or issues arising from using this software.\n\n3. Updates\nThese terms may change at any time.';

  @override
  String get about => 'About';

  @override
  String get companyName => 'Multiverso Digital';

  @override
  String get contactEmail => 'contato@multiversodigital.com.br';

  @override
  String get appVersion => 'Version 1.0.0';

  @override
  String get copyMessage => 'Copy Message';

  @override
  String get exportPdf => 'Export to PDF';

  @override
  String get pdfGenerated => 'PDF generated successfully';

  @override
  String get errorGeneratingPdf => 'Error generating PDF';

  @override
  String get exportOptionsTitle => 'Export Options';

  @override
  String get exportOptionsContent =>
      'Do you also want to generate a PDF for the original file?';

  @override
  String get exportChatOnly => 'Chat Only';

  @override
  String get exportBoth => 'Chat & File';

  @override
  String get print => 'Print';

  @override
  String get share => 'Share';

  @override
  String get saveChangesTitle => 'Save Copy?';

  @override
  String get saveChangesContent =>
      'This will save a copy of the edit file. The original file will be preserved.';

  @override
  String saveCopySuccess(Object path) {
    return 'File copy saved at: $path';
  }

  @override
  String get savedFiles => 'Saved Files';

  @override
  String get noSavedFiles => 'No saved files found';

  @override
  String get history => 'History';

  @override
  String get deleteTitle => 'Confirm Deletion';

  @override
  String get deleteContent => 'Are you sure you want to remove this item?';

  @override
  String get delete => 'Delete';

  @override
  String get find => 'Find';

  @override
  String get replace => 'Replace';

  @override
  String get replaceAll => 'Replace All';

  @override
  String replacedSuccess(Object count) {
    return 'Replaced $count occurrences';
  }

  @override
  String get includeOriginal => 'Include File Content';

  @override
  String get processing => 'Processing...';

  @override
  String processingColumns(Object columns) {
    return 'Analyzing $columns columns...';
  }
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
  String get premium => 'Premium';

  @override
  String get goPremium => 'Seja Premium';

  @override
  String get premiumDesc => 'Desbloqueie acesso ilimitado e remova anúncios.';

  @override
  String get restorePurchases => 'Restaurar Compras';

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
  String get premium => 'Premium';

  @override
  String get goPremium => 'Obter Premium';

  @override
  String get premiumDesc => 'Desbloqueie acesso ilimitado e remova anúncios.';

  @override
  String get restorePurchases => 'Restaurar Compras';

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
      'Última atualização: Dezembro de 2025\n\nEsta Política de Privacidade descreve como o MviewerPlus recolhe, usa e divulga as suas informações quando utiliza o nosso Serviço.\n\n1. Recolha de Dados\nNão recolhemos dados pessoais. Os ficheiros abertos nesta aplicação são processados localmente no seu dispositivo e não são enviados para nenhum servidor.\n\n2. Permissões\nA aplicação requer permissões de armazenamento apenas para ler os ficheiros que selecionar explicitamente.\n\n3. Serviços de Terceiros\nSe optar pela versão Gratuita, podemos usar serviços de publicidade de terceiros (ex: AdMob) que podem recolher identificadores de dispositivo para exibir anúncios relevantes. Na versão Premium, nenhum anúncio é exibido.\n\n4. Contacte-nos\nSe tiver dúvidas sobre esta Política de Privacidade, contacte-nos.';

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
}
