// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'MviewerPlus';

  @override
  String get openFile => 'Open File';

  @override
  String get copyContent => 'Copy Content';

  @override
  String get copiedToClipboard => 'Content copied to clipboard';

  @override
  String get errorLoadingFile => 'Error loading file';

  @override
  String get emptyCsv => 'Empty CSV';

  @override
  String get subtitle => 'The Universal File Reader';

  @override
  String get supportsHint =>
      'Supports .txt, .json, .csv, .xml, .sql, .log & more';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String get settings => 'Settings';

  @override
  String get premium => 'Premium';

  @override
  String get goPremium => 'Go Premium';

  @override
  String get premiumDesc => 'Unlock unlimited access and remove ads.';

  @override
  String get restorePurchases => 'Restore Purchases';

  @override
  String get termsOfService => 'Terms of Service';

  @override
  String get language => 'Language';

  @override
  String get theme => 'Theme';
}
