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
      '• Texto: .txt, .md, .log, .rtf\n• Datos: .csv, .json, .xml, .xlsx, .xls\n• Código: Dart, JS, Python, Java, C++, HTML, CSS, SQL...\n• Imágenes: .png, .jpg, .gif\n• Multimedia: .mp3, .wav, .mp4, .avi\n• Docs: .pdf, .docx\n• Otros: .zip, .apk';

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
  String get goPremium => 'Go Premium';

  @override
  String get restorePurchases => 'Restore Purchases';

  @override
  String get premiumDesc => 'Unlock unlimited access and remove ads.';

  @override
  String get securityCheck => 'Verificación de Seguridad';

  @override
  String get securityCheckDesc => 'Verify device security';

  @override
  String get refresh => 'Actualizar';

  @override
  String securityCheckError(Object error) {
    return 'Error checking security: $error';
  }

  @override
  String get noResultsAvailable => 'No hay resultados disponibles.';

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
  String get checksPerformed => 'Verificaciones Realizadas';

  @override
  String get checkRootJailbreak => 'Root/Jailbreak';

  @override
  String get checkDebugger => 'Debugger';

  @override
  String get checkHooking => 'Hooking';

  @override
  String get checkIntegrity => 'Integridad de la App';

  @override
  String get checkOSVersion => 'Sistema Actualizado';

  @override
  String get checkScreenLock => 'Bloqueo de Pantalla';

  @override
  String get checkRealDevice => 'Dispositivo Real';

  @override
  String get statusOk => 'OK';

  @override
  String get statusFailed => 'FALLÓ';

  @override
  String get understood => 'Entendido';

  @override
  String get securityLevelSafe => 'Seguro';

  @override
  String get securityLevelWarning => 'Advertencias Detectadas';

  @override
  String get securityLevelCritical => 'AMENAZAS CRÍTICAS';

  @override
  String get securityDescSafe =>
      'Todas las verificaciones de seguridad pasaron';

  @override
  String get securityDescWarning => 'Algunas configuraciones pueden mejorar';

  @override
  String get securityDescCritical =>
      'Amenazas críticas detectadas - Acción necesaria';

  @override
  String get actionRootTitle => 'Dispositivo con Root Detectado';

  @override
  String get actionRootDesc =>
      'Su dispositivo tiene privilegios de superusuario (root). Esto compromete la seguridad de la aplicación.';

  @override
  String get actionRootRec =>
      'Elimine el root del dispositivo o use un dispositivo sin root.';

  @override
  String get actionDebuggerTitle => 'Debugger Detectado';

  @override
  String get actionDebuggerDesc =>
      'Un debugger está adjunto a la aplicación. Esto puede indicar un intento de analizar o modificar la app.';

  @override
  String get actionDebuggerRec =>
      'Cierre todas las herramientas de desarrollo y reinicie la app.';

  @override
  String get actionHookingTitle => 'Framework de Hooking Detectado';

  @override
  String get actionHookingDesc =>
      'Se detectó un framework de hooking (Frida, Xposed, etc.). Esto puede permitir modificar el comportamiento de la app.';

  @override
  String get actionHookingRec =>
      'Elimine frameworks de hooking y reinicie el dispositivo.';

  @override
  String get actionIntegrityTitle => 'Integridad de la App Comprometida';

  @override
  String get actionIntegrityDesc =>
      'La firma de la aplicación no coincide con la esperada. La app puede haber sido modificada.';

  @override
  String get actionIntegrityRec =>
      'Reinstale la app desde la tienda oficial (Google Play/App Store).';

  @override
  String get actionOSTitle => 'Sistema Operativo Desactualizado';

  @override
  String get actionOSDesc =>
      'Su sistema operativo está desactualizado y puede contener vulnerabilidades de seguridad.';

  @override
  String get actionOSRec =>
      'Actualice su sistema operativo a la versión más reciente.';

  @override
  String get actionLockTitle => 'Bloqueo de Pantalla No Configurado';

  @override
  String get actionLockDesc =>
      'Su dispositivo no tiene bloqueo de pantalla configurado. Esto facilita el acceso no autorizado.';

  @override
  String get actionLockRec =>
      'Configure un PIN, contraseña, patrón o biometría en la configuración.';

  @override
  String get actionEmulatorTitle => 'Ejecutando en Emulador';

  @override
  String get actionEmulatorDesc =>
      'La app se está ejecutando en un emulador. Algunas funcionalidades pueden estar limitadas.';

  @override
  String get actionEmulatorRec =>
      'Use un dispositivo físico para una mejor experiencia.';

  @override
  String get actionUnknownSourcesTitle =>
      'Instalación de Fuentes Desconocidas Activada';

  @override
  String get actionUnknownSourcesDesc =>
      'Su dispositivo permite instalar apps de fuentes desconocidas. Esto facilita la instalación de malware.';

  @override
  String get actionUnknownSourcesRec =>
      'Desactive \'Instalar apps de fuentes desconocidas\' en la configuración de seguridad.';

  @override
  String get actionLocationTitle => 'Apps con Ubicación \'Siempre\' Detectadas';

  @override
  String actionLocationDesc(Object count) {
    return '$count app(s) tienen permiso de rastreo de ubicación en segundo plano. Esto representa un riesgo de privacidad.';
  }

  @override
  String get actionLocationRec =>
      'Revise los permisos de ubicación y cambie a \'Solo durante el uso\' cuando sea posible.';

  @override
  String get actionNotifTitle =>
      'Notificaciones Sensibles en Pantalla de Bloqueo';

  @override
  String get actionNotifDesc =>
      'Previsualizaciones de notificaciones (mensajes, códigos 2FA) son visibles en la pantalla de bloqueo. Esto puede permitir la interceptación de datos sensibles.';

  @override
  String get actionNotifRec =>
      'Configure para ocultar contenido sensible en las notificaciones de la pantalla de bloqueo.';

  @override
  String get actionPatchTitle => 'Parche de Seguridad Desactualizado';

  @override
  String get actionPatchDesc =>
      'El parche de seguridad de su dispositivo tiene más de 60 días.';

  @override
  String get actionPatchRec =>
      'Verifique actualizaciones del sistema en la configuración.';

  @override
  String get action2FATitle => 'Active la Autenticación de Dos Factores (2FA)';

  @override
  String get action2FADesc =>
      'La autenticación de dos factores añade una capa extra de seguridad a sus cuentas críticas.';

  @override
  String get action2FARec =>
      'Active el 2FA en la configuración de seguridad de su cuenta.';

  @override
  String get expAppSignaturesTitle => 'Monitoreo de Apps';

  @override
  String get expAppSignaturesDesc =>
      'Verifica si las apps sensibles son originales.\n\n⚠️ ¿Por qué es crítico?\n• Las apps falsas pueden robar credenciales\n\n✅ ¿Qué significa?\nSi falla: Alguna app puede ser peligrosa.';

  @override
  String get expRootTitle => 'Root/Jailbreak';

  @override
  String get expRootDesc =>
      'Root o Jailbreak es cuando modifican el sistema del móvil para tener acceso total.\n\n⚠️ ¿Por qué es peligroso?\n• Datos bancarios vulnerables\n\n✅ ¿Qué hacer?\nConsidere restaurar la configuración de fábrica.';

  @override
  String get expDebuggerTitle => 'Debugger (Depurador)';

  @override
  String get expDebuggerDesc =>
      'Herramienta para analizar apps.\n\n⚠️ ¿Peligro?\n• Espionaje de datos\n\n✅ ¿Acción?\nReinicie el móvil si no es desarrollador.';

  @override
  String get expHookingTitle => 'Hooking';

  @override
  String get expHookingDesc =>
      'Modificación de apps en tiempo real.\n\n⚠️ ¿Peligro?\n• Robo de datos\n\n✅ ¿Acción?\nDesinstale apps sospechosas.';

  @override
  String get expIntegrityTitle => 'Integridad de la App';

  @override
  String get expIntegrityDesc =>
      'Verifica si esta app ha sido modificada.\n\n⚠️ Importante:\n• Apps alteradas pueden tener virus\n\n✅ Significado:\nPasó = App original.';

  @override
  String get expOSTitle => 'Sistema Actualizado';

  @override
  String get expOSDesc =>
      'Verifica actualizaciones del sistema.\n\n⚠️ Importante:\n• Sistemas antiguos tienen fallos\n\n✅ Acción:\nActualice el sistema.';

  @override
  String get expLockTitle => 'Bloqueo de Pantalla';

  @override
  String get expLockDesc =>
      'Verifica si tiene contraseña o biometría.\n\n⚠️ Importante:\n• Impede acceso físico no autorizado\n\n✅ Acción:\nConfigure una contraseña fuerte.';

  @override
  String get expEmulatorTitle => 'Dispositivo Real';

  @override
  String get expEmulatorDesc =>
      'Verifica si es un móvil real o virtual.\n\n✅ Significado:\nDebe usar un móvil real.';
}
