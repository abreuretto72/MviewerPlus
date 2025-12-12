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
  String get help => 'Help';

  @override
  String get helpTitle => 'Help Guide';

  @override
  String get featuresSection => 'Key Features';

  @override
  String get featuresContent =>
      '• Quick View: Open large files instantly.\n• Edit & Search: Edit text, find and replace terms.\n• Export & Share: Generate PDFs, print, and share your files.\n• Smart Tables: View CSV and Excel with filters and sorting.\n• Code Editor: Syntax highlighting for 30+ languages.\n• AI Analysis: Enter your Groq API Key to let AI analyze file content.\n• ZIP Archives: Explore compressed file contents.';

  @override
  String get formatsSection => 'Supported Formats';

  @override
  String get exit => 'Exit';

  @override
  String get exitConfirm => 'Do you want to close the app?';

  @override
  String get formatsContent =>
      '• Text: .txt, .md, .log, .rtf\n• Data: .csv, .json, .xml, .xlsx, .xls\n• Code: Dart, JS, Python, Java, C++, HTML, CSS, SQL...\n• Images: .png, .jpg, .gif\n• Multimedia: .mp3, .wav, .mp4, .avi\n• Docs: .pdf, .docx\n• Other: .zip, .apk';
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
  String get helpTitle => 'Guia de Ajuda';

  @override
  String get featuresSection => 'Funcionalidades Principais';

  @override
  String get featuresContent =>
      '• Visualização Rápida: Abra arquivos grandes instantaneamente.\n• Edição e Busca: Edite o texto, localize e substitua termos.\n• Exportação: Gere PDFs, imprima e compartilhe seus arquivos.\n• Tabelas Inteligentes: Visualize CSV e Excel com filtros e ordenação.\n• Editor de Código: Sintaxe colorida para mais de 30 linguagens.\n• Análise com IA: Insira sua Chave API Groq para permitir que a IA analise o conteúdo dos arquivos.\n• Arquivos ZIP: Explore o conteúdo de arquivos compactados.';

  @override
  String get formatsSection => 'Formatos Suportados';

  @override
  String get exit => 'Sair';

  @override
  String get exitConfirm => 'Deseja fechar o aplicativo?';

  @override
  String get formatsContent =>
      '• Texto: .txt, .md, .log, .rtf\n• Dados: .csv, .json, .xml, .xlsx, .xls\n• Código: Dart, JS, Python, Java, C++, HTML, CSS, SQL...\n• Imagens: .png, .jpg, .gif\n• Multimídia: .mp3, .wav, .mp4, .avi\n• Docs: .pdf, .docx\n• Outros: .zip, .apk';
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
      '• Texto: .txt, .md, .log, .rtf\n• Dados: .csv, .json, .xml, .xlsx, .xls\n• Código: .dart, .js, .ts, .py, .java, .c, .cpp, .h, .kt, .swift, .html, .css, .sql e muitos outros.\n• Imagens: .png, .jpg, .jpeg, .gif\n• Outros: .zip, .apk, .jar';
}
