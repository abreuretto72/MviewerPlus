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
  String get premium => 'Premium';

  @override
  String get goPremium => 'Hazte Premium';

  @override
  String get premiumDesc => 'Desbloquea acceso ilimitado y elimina anuncios.';

  @override
  String get restorePurchases => 'Restaurar Compras';

  @override
  String get termsOfService => 'Términos de Servicio';

  @override
  String get language => 'Idioma';

  @override
  String get theme => 'Tema';
}
