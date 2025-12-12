// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'MviewerPlus';

  @override
  String get openFile => 'Abrir Archivo';

  @override
  String get copyContent => 'Copiar Contenido';

  @override
  String get copiedToClipboard => 'Contenido copiado al portapapeles';

  @override
  String get errorLoadingFile => 'Error al cargar el archivo';

  @override
  String get emptyCsv => 'CSV vacío';

  @override
  String get subtitle => 'El Lector Universal de Archivos';

  @override
  String get supportsHint =>
      'Soporta .txt, .json, .csv, .xml, .sql, .log y más';

  @override
  String get privacyPolicy => 'Política de Privacidad';

  @override
  String get settings => 'Configuración';

  @override
  String get termsOfService => 'Términos de Servicio';

  @override
  String get language => 'Idioma';

  @override
  String get theme => 'Tema';

  @override
  String get apiKey => 'Clave API de IA';

  @override
  String get enterApiKey => 'Ingrese su Clave API de Groq';

  @override
  String get apiKeyDesc => 'Obtener clave gratuita';

  @override
  String get save => 'Guardar';

  @override
  String get getApiKeyHelpBtn => '¿Cómo obtener una clave? (Toca aquí)';

  @override
  String get getApiKeyDialogTitle => 'Obteniendo una Clave API de Groq';

  @override
  String get getApiKeyDialogContent =>
      '1. Ve a console.groq.com\n2. Regístrate o inicia sesión\n3. Ve a la sección \"API Keys\"\n4. Crea una nueva clave y cópiala aquí.';

  @override
  String get close => 'Cerrar';

  @override
  String get cancel => 'Cancelar';

  @override
  String get aiAssistant => 'Asistente IA';

  @override
  String get askAboutFile => 'Pregunte sobre el archivo...';

  @override
  String get systemNote => 'Nota del Sistema';

  @override
  String analyzedFile(Object fileName) {
    return 'He analizado $fileName. ¡Pregúntame lo que quieras sobre su contenido!';
  }

  @override
  String get fileTooLarge =>
      'Archivo demasiado grande. Contenido truncado para el análisis.';

  @override
  String get privacyPolicyContent =>
      'Última actualización: Diciembre de 2025\n\nEsta Política de Privacidad describe cómo MviewerPlus maneja su información.\n\n1. Recopilación de Datos\nNo recopilamos datos personales. El procesamiento es local.\n\n2. Funciones de IA\nAl usar el asistente de IA, el contenido se envía a la API de Groq usando su Clave API personal. No almacenamos datos.\n\n3. Modelo Gratuito\nEsta aplicación es 100% gratuita, de código abierto y sin anuncios.\n\n4. Contacto\nSi tiene dudas, contáctenos: contato@multiversodigital.com.br';

  @override
  String get termsContent =>
      'Términos de Servicio\n\nAl usar MviewerPlus, aceptas estos términos.\n\n1. Uso\nEres responsable del contenido al que accedes utilizando este visor.\n\n2. Responsabilidad\nEl desarrollador no se hace responsable de ninguna pérdida de datos o problemas derivados del uso de este software.\n\n3. Actualizaciones\nEstos términos pueden cambiar en cualquier momento.';

  @override
  String get about => 'Acerca de';

  @override
  String get companyName => 'Multiverso Digital';

  @override
  String get contactEmail => 'contato@multiversodigital.com.br';

  @override
  String get appVersion => 'Versión 1.0.0';

  @override
  String get copyMessage => 'Copiar Mensaje';

  @override
  String get exportPdf => 'Exportar a PDF';

  @override
  String get pdfGenerated => 'PDF generado con éxito';

  @override
  String get errorGeneratingPdf => 'Error al generar PDF';

  @override
  String get exportOptionsTitle => 'Opciones de Exportación';

  @override
  String get exportOptionsContent =>
      '¿Desea también generar un PDF del archivo original?';

  @override
  String get exportChatOnly => 'Solo Chat';

  @override
  String get exportBoth => 'Chat y Archivo';

  @override
  String get print => 'Imprimir';

  @override
  String get share => 'Compartir';

  @override
  String get saveChangesTitle => '¿Guardar Copia?';

  @override
  String get saveChangesContent =>
      'Esto guardará una copia del archivo editado. El archivo original será preservado.';

  @override
  String saveCopySuccess(Object path) {
    return 'Copia guardada en: $path';
  }

  @override
  String get savedFiles => 'Archivos Guardados';

  @override
  String get noSavedFiles => 'No se encontraron archivos guardados';

  @override
  String get history => 'Historial';

  @override
  String get deleteTitle => 'Confirmar Eliminación';

  @override
  String get deleteContent =>
      '¿Está seguro de que desea eliminar este elemento?';

  @override
  String get delete => 'Eliminar';

  @override
  String get find => 'Buscar';

  @override
  String get replace => 'Reemplazar';

  @override
  String get replaceAll => 'Reemplazar Todo';

  @override
  String replacedSuccess(Object count) {
    return 'Se reemplazaron $count ocurrencias';
  }

  @override
  String get includeOriginal => 'Incluir Contenido del Archivo';

  @override
  String get processing => 'Procesando...';

  @override
  String processingColumns(Object columns) {
    return 'Analizando $columns columnas...';
  }

  @override
  String get pdfReportTitle => 'Reporte MviewerPlus';

  @override
  String get pdfGeneratedLabel => 'Generado:';

  @override
  String get pdfFileLabel => 'Archivo:';

  @override
  String get pdfSizeLabel => 'Tamaño:';

  @override
  String get pdfRecordsLabel => 'Registros:';

  @override
  String get pdfPage => 'Página';

  @override
  String get pdfOf => 'de';

  @override
  String get rows => 'filas';

  @override
  String get files => 'archivos';

  @override
  String get lines => 'líneas';

  @override
  String get archiveBadge => 'ARCHIVO';

  @override
  String get zipEmpty => 'Archivo ZIP vacío o inválido';

  @override
  String zipArchiveInfo(Object count) {
    return 'Archivo ZIP ($count archivos)';
  }

  @override
  String get fileName => 'Nombre del Archivo';

  @override
  String get fileType => 'Tipo';

  @override
  String get fileSizeCol => 'Tamaño (KB)';

  @override
  String get searchNotAvailableZip =>
      'Búsqueda no disponible para archivos comprimidos.';

  @override
  String get readOnlyFormat => 'Este formato es de solo lectura.';

  @override
  String get processingWait => 'Leyendo archivo, espera.';

  @override
  String get loadingTitle => 'Cargando...';

  @override
  String get help => 'Ayuda';

  @override
  String get helpTitle => 'Guía de Ayuda';

  @override
  String get featuresSection => 'Funcionalidades Principales';

  @override
  String get featuresContent =>
      '• Vista Rápida: Abre archivos grandes al instante.\n• Edición y Búsqueda: Edite texto, busque y reemplace términos.\n• Exportar y Compartir: Genere PDF, imprima y comparta archivos.\n• Tablas Inteligentes: Visualice CSV y Excel con filtros y ordenación.\n• Editor de Código: Resaltado de sintaxis para más de 30 lenguajes.\n• Análisis de IA: Ingrese su Clave API Groq para que la IA analice el contenido y responda preguntas.\n• Archivos ZIP: Explore archivos comprimidos.';

  @override
  String get formatsSection => 'Formatos Soportados';

  @override
  String get exit => 'Salir';

  @override
  String get exitConfirm => '¿Desea cerrar la aplicación?';

  @override
  String get formatsContent =>
      '• Texto: .txt, .md, .log, .rtf\n• Datos: .csv, .json, .xml, .xlsx, .xls\n• Código: .dart, .js, .ts, .py, .java, .c, .cpp, .h, .kt, .swift, .html, .css, .sql y muchos más.\n• Imágenes: .png, .jpg, .jpeg, .gif\n• Otros: .zip, .apk, .jar';
}
