import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_pt.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
    Locale('pt'),
    Locale('pt', 'BR'),
    Locale('pt', 'PT'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'MviewerPlus'**
  String get appTitle;

  /// No description provided for @openFile.
  ///
  /// In en, this message translates to:
  /// **'Open File'**
  String get openFile;

  /// No description provided for @copyContent.
  ///
  /// In en, this message translates to:
  /// **'Copy Content'**
  String get copyContent;

  /// No description provided for @copiedToClipboard.
  ///
  /// In en, this message translates to:
  /// **'Content copied to clipboard'**
  String get copiedToClipboard;

  /// No description provided for @errorLoadingFile.
  ///
  /// In en, this message translates to:
  /// **'Error loading file'**
  String get errorLoadingFile;

  /// No description provided for @emptyCsv.
  ///
  /// In en, this message translates to:
  /// **'Empty CSV'**
  String get emptyCsv;

  /// No description provided for @subtitle.
  ///
  /// In en, this message translates to:
  /// **'The Universal File Reader'**
  String get subtitle;

  /// No description provided for @supportsHint.
  ///
  /// In en, this message translates to:
  /// **'Supports .txt, .json, .csv, .xml, .sql, .log & more'**
  String get supportsHint;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @termsOfService.
  ///
  /// In en, this message translates to:
  /// **'Terms of Service'**
  String get termsOfService;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @apiKey.
  ///
  /// In en, this message translates to:
  /// **'AI API Key'**
  String get apiKey;

  /// No description provided for @enterApiKey.
  ///
  /// In en, this message translates to:
  /// **'Enter your Groq API Key'**
  String get enterApiKey;

  /// No description provided for @apiKeyDesc.
  ///
  /// In en, this message translates to:
  /// **'Get free API Key'**
  String get apiKeyDesc;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @getApiKeyHelpBtn.
  ///
  /// In en, this message translates to:
  /// **'How to get a key? (Tap here)'**
  String get getApiKeyHelpBtn;

  /// No description provided for @getApiKeyDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Getting a Groq API Key'**
  String get getApiKeyDialogTitle;

  /// No description provided for @getApiKeyDialogContent.
  ///
  /// In en, this message translates to:
  /// **'1. Go to console.groq.com\n2. Sign up or log in\n3. Go to \"API Keys\" section\n4. Create a new key and copy it here.'**
  String get getApiKeyDialogContent;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @aiAssistant.
  ///
  /// In en, this message translates to:
  /// **'AI Assistant'**
  String get aiAssistant;

  /// No description provided for @askAboutFile.
  ///
  /// In en, this message translates to:
  /// **'Ask about the file...'**
  String get askAboutFile;

  /// No description provided for @systemNote.
  ///
  /// In en, this message translates to:
  /// **'System Note'**
  String get systemNote;

  /// No description provided for @analyzedFile.
  ///
  /// In en, this message translates to:
  /// **'I have analyzed {fileName}. Ask me anything about its content!'**
  String analyzedFile(Object fileName);

  /// No description provided for @fileTooLarge.
  ///
  /// In en, this message translates to:
  /// **'File is too large. Content has truncated for analysis.'**
  String get fileTooLarge;

  /// No description provided for @privacyPolicyContent.
  ///
  /// In en, this message translates to:
  /// **'Last updated: December 2025\n\nThis Privacy Policy describes how MviewerPlus handles your information.\n\n1. Data Collection\nWe do not collect personal data. File processing is local.\n\n2. AI Features (Groq)\nWhen using the AI assistant, file content is sent to Groq API using your personal API Key. No data is stored by us.\n\n3. Free Model\nThis app is 100% free, open-source, and does not display ads.\n\n4. Contact\nFor questions, please contact: contato@multiversodigital.com.br'**
  String get privacyPolicyContent;

  /// No description provided for @termsContent.
  ///
  /// In en, this message translates to:
  /// **'Terms of Service\n\nBy using MviewerPlus, you agree to these terms.\n\n1. Usage\nYou are responsible for the content you access using this viewer.\n\n2. Liability\nThe developer is not liable for any data loss or issues arising from using this software.\n\n3. Updates\nThese terms may change at any time.'**
  String get termsContent;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// No description provided for @companyName.
  ///
  /// In en, this message translates to:
  /// **'Multiverso Digital'**
  String get companyName;

  /// No description provided for @contactEmail.
  ///
  /// In en, this message translates to:
  /// **'contato@multiversodigital.com.br'**
  String get contactEmail;

  /// No description provided for @appVersion.
  ///
  /// In en, this message translates to:
  /// **'Version 1.0.0'**
  String get appVersion;

  /// No description provided for @copyMessage.
  ///
  /// In en, this message translates to:
  /// **'Copy Message'**
  String get copyMessage;

  /// No description provided for @exportPdf.
  ///
  /// In en, this message translates to:
  /// **'Export to PDF'**
  String get exportPdf;

  /// No description provided for @pdfGenerated.
  ///
  /// In en, this message translates to:
  /// **'PDF generated successfully'**
  String get pdfGenerated;

  /// No description provided for @errorGeneratingPdf.
  ///
  /// In en, this message translates to:
  /// **'Error generating PDF'**
  String get errorGeneratingPdf;

  /// No description provided for @exportOptionsTitle.
  ///
  /// In en, this message translates to:
  /// **'Export Options'**
  String get exportOptionsTitle;

  /// No description provided for @exportOptionsContent.
  ///
  /// In en, this message translates to:
  /// **'Do you also want to generate a PDF for the original file?'**
  String get exportOptionsContent;

  /// No description provided for @exportChatOnly.
  ///
  /// In en, this message translates to:
  /// **'Chat Only'**
  String get exportChatOnly;

  /// No description provided for @exportBoth.
  ///
  /// In en, this message translates to:
  /// **'Chat & File'**
  String get exportBoth;

  /// No description provided for @print.
  ///
  /// In en, this message translates to:
  /// **'Print'**
  String get print;

  /// No description provided for @share.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get share;

  /// No description provided for @saveChangesTitle.
  ///
  /// In en, this message translates to:
  /// **'Save Copy?'**
  String get saveChangesTitle;

  /// No description provided for @saveChangesContent.
  ///
  /// In en, this message translates to:
  /// **'This will save a copy of the edit file. The original file will be preserved.'**
  String get saveChangesContent;

  /// No description provided for @saveCopySuccess.
  ///
  /// In en, this message translates to:
  /// **'File copy saved at: {path}'**
  String saveCopySuccess(Object path);

  /// No description provided for @savedFiles.
  ///
  /// In en, this message translates to:
  /// **'Saved Files'**
  String get savedFiles;

  /// No description provided for @noSavedFiles.
  ///
  /// In en, this message translates to:
  /// **'No saved files found'**
  String get noSavedFiles;

  /// No description provided for @history.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get history;

  /// No description provided for @deleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Confirm Deletion'**
  String get deleteTitle;

  /// No description provided for @deleteContent.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to remove this item?'**
  String get deleteContent;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @find.
  ///
  /// In en, this message translates to:
  /// **'Find'**
  String get find;

  /// No description provided for @replace.
  ///
  /// In en, this message translates to:
  /// **'Replace'**
  String get replace;

  /// No description provided for @replaceAll.
  ///
  /// In en, this message translates to:
  /// **'Replace All'**
  String get replaceAll;

  /// No description provided for @replacedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Replaced {count} occurrences'**
  String replacedSuccess(Object count);

  /// No description provided for @includeOriginal.
  ///
  /// In en, this message translates to:
  /// **'Include File Content'**
  String get includeOriginal;

  /// No description provided for @processing.
  ///
  /// In en, this message translates to:
  /// **'Processing...'**
  String get processing;

  /// No description provided for @processingColumns.
  ///
  /// In en, this message translates to:
  /// **'Analyzing {columns} columns...'**
  String processingColumns(Object columns);

  /// No description provided for @pdfReportTitle.
  ///
  /// In en, this message translates to:
  /// **'MviewerPlus Report'**
  String get pdfReportTitle;

  /// No description provided for @pdfGeneratedLabel.
  ///
  /// In en, this message translates to:
  /// **'Generated:'**
  String get pdfGeneratedLabel;

  /// No description provided for @pdfFileLabel.
  ///
  /// In en, this message translates to:
  /// **'File:'**
  String get pdfFileLabel;

  /// No description provided for @pdfSizeLabel.
  ///
  /// In en, this message translates to:
  /// **'Size:'**
  String get pdfSizeLabel;

  /// No description provided for @pdfRecordsLabel.
  ///
  /// In en, this message translates to:
  /// **'Records:'**
  String get pdfRecordsLabel;

  /// No description provided for @pdfPage.
  ///
  /// In en, this message translates to:
  /// **'Page'**
  String get pdfPage;

  /// No description provided for @pdfOf.
  ///
  /// In en, this message translates to:
  /// **'of'**
  String get pdfOf;

  /// No description provided for @rows.
  ///
  /// In en, this message translates to:
  /// **'rows'**
  String get rows;

  /// No description provided for @files.
  ///
  /// In en, this message translates to:
  /// **'files'**
  String get files;

  /// No description provided for @lines.
  ///
  /// In en, this message translates to:
  /// **'lines'**
  String get lines;

  /// No description provided for @archiveBadge.
  ///
  /// In en, this message translates to:
  /// **'ARCHIVE'**
  String get archiveBadge;

  /// No description provided for @zipEmpty.
  ///
  /// In en, this message translates to:
  /// **'Empty or invalid ZIP archive'**
  String get zipEmpty;

  /// No description provided for @zipArchiveInfo.
  ///
  /// In en, this message translates to:
  /// **'Zip Archive ({count} files)'**
  String zipArchiveInfo(Object count);

  /// No description provided for @fileName.
  ///
  /// In en, this message translates to:
  /// **'File Name'**
  String get fileName;

  /// No description provided for @fileType.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get fileType;

  /// No description provided for @fileSizeCol.
  ///
  /// In en, this message translates to:
  /// **'Size (KB)'**
  String get fileSizeCol;

  /// No description provided for @searchNotAvailableZip.
  ///
  /// In en, this message translates to:
  /// **'Search not available for archive files.'**
  String get searchNotAvailableZip;

  /// No description provided for @readOnlyFormat.
  ///
  /// In en, this message translates to:
  /// **'This format is read-only.'**
  String get readOnlyFormat;

  /// No description provided for @processingWait.
  ///
  /// In en, this message translates to:
  /// **'Reading file, please wait.'**
  String get processingWait;

  /// No description provided for @loadingTitle.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loadingTitle;

  /// No description provided for @help.
  ///
  /// In en, this message translates to:
  /// **'Help'**
  String get help;

  /// No description provided for @helpTitle.
  ///
  /// In en, this message translates to:
  /// **'MviewerPlus Help Guide'**
  String get helpTitle;

  /// No description provided for @featuresSection.
  ///
  /// In en, this message translates to:
  /// **'Key Features'**
  String get featuresSection;

  /// No description provided for @featuresContent.
  ///
  /// In en, this message translates to:
  /// **'• Quick View: Open large files instantly with native performance.\n• Edit & Search: Edit text, code, and data. Use advanced \'Find and Replace\'.\n• Safe Editing: Your original files are never changed. Copies are saved in \'History\' via the Main Menu.\n• Smart Tables: View CSVs and Excel as interactive spreadsheets with sorting and filters.\n• Code Editor: Syntax highlighting for 30+ languages (Dart, JS, Python, SQL...).\n• Security Check: verify app integrity, root, debuggers, and digital signatures.\n• AI Analysis: Connect your Groq Key to \'chat\' with your documents.\n• ZIP Archives: Browse inside compressed files like folders.\n• Multimedia: Native player for audio and video.'**
  String get featuresContent;

  /// No description provided for @formatsSection.
  ///
  /// In en, this message translates to:
  /// **'Supported Formats'**
  String get formatsSection;

  /// No description provided for @exit.
  ///
  /// In en, this message translates to:
  /// **'Exit'**
  String get exit;

  /// No description provided for @exitConfirm.
  ///
  /// In en, this message translates to:
  /// **'Do you want to close the app?'**
  String get exitConfirm;

  /// No description provided for @formatsContent.
  ///
  /// In en, this message translates to:
  /// **'• Text & Code: .txt, .md, .log, .json, .xml, .yaml, .yml, .html, .css, .js, .ts, .dart, .java, .kt, .swift, .py, .rb, .php, .go, .c, .cpp, .cs, .sql, .sh, .conf, .env, .ini\n• Data & Spreadsheets: .csv, .xlsx, .xls\n• Documents: .pdf, .docx (text)\n• Images: .png, .jpg, .jpeg, .gif, .webp, .bmp\n• Audio: .mp3, .wav, .ogg, .m4a, .aac, .flac\n• Video: .mp4, .mov, .avi, .mkv, .webm, .wmv, .flv, .3gp\n• Archives: .zip, .apk, .jar\n• Certificates: .pem, .crt, .cer, .p12, .pfx, .der'**
  String get formatsContent;

  /// No description provided for @cookieInspector.
  ///
  /// In en, this message translates to:
  /// **'Cookie Inspector'**
  String get cookieInspector;

  /// No description provided for @cookieInspectorDesc.
  ///
  /// In en, this message translates to:
  /// **'Manage and analyze cookies'**
  String get cookieInspectorDesc;

  /// No description provided for @httpCookies.
  ///
  /// In en, this message translates to:
  /// **'HTTP Cookies'**
  String get httpCookies;

  /// No description provided for @webviewCookies.
  ///
  /// In en, this message translates to:
  /// **'WebView Cookies'**
  String get webviewCookies;

  /// No description provided for @securityLogs.
  ///
  /// In en, this message translates to:
  /// **'Security & Logs'**
  String get securityLogs;

  /// No description provided for @cookieWarning.
  ///
  /// In en, this message translates to:
  /// **'Cookies may contain session and login tokens. Use with caution.'**
  String get cookieWarning;

  /// No description provided for @urlOrDomain.
  ///
  /// In en, this message translates to:
  /// **'URL or Domain'**
  String get urlOrDomain;

  /// No description provided for @listCookies.
  ///
  /// In en, this message translates to:
  /// **'List'**
  String get listCookies;

  /// No description provided for @exportCookies.
  ///
  /// In en, this message translates to:
  /// **'Export'**
  String get exportCookies;

  /// No description provided for @deleteAllCookies.
  ///
  /// In en, this message translates to:
  /// **'Delete All'**
  String get deleteAllCookies;

  /// No description provided for @noCookiesFound.
  ///
  /// In en, this message translates to:
  /// **'No cookies found'**
  String get noCookiesFound;

  /// No description provided for @enterUrlAndList.
  ///
  /// In en, this message translates to:
  /// **'Enter a URL and click \'List\''**
  String get enterUrlAndList;

  /// No description provided for @cookieName.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get cookieName;

  /// No description provided for @cookieValue.
  ///
  /// In en, this message translates to:
  /// **'Value'**
  String get cookieValue;

  /// No description provided for @cookieDomain.
  ///
  /// In en, this message translates to:
  /// **'Domain'**
  String get cookieDomain;

  /// No description provided for @cookiePath.
  ///
  /// In en, this message translates to:
  /// **'Path'**
  String get cookiePath;

  /// No description provided for @cookieExpires.
  ///
  /// In en, this message translates to:
  /// **'Expires'**
  String get cookieExpires;

  /// No description provided for @cookieSecure.
  ///
  /// In en, this message translates to:
  /// **'Secure'**
  String get cookieSecure;

  /// No description provided for @cookieHttpOnly.
  ///
  /// In en, this message translates to:
  /// **'HttpOnly'**
  String get cookieHttpOnly;

  /// No description provided for @cookieSameSite.
  ///
  /// In en, this message translates to:
  /// **'SameSite'**
  String get cookieSameSite;

  /// No description provided for @cookieSensitive.
  ///
  /// In en, this message translates to:
  /// **'Sensitive cookie'**
  String get cookieSensitive;

  /// No description provided for @securitySignals.
  ///
  /// In en, this message translates to:
  /// **'Security Signals'**
  String get securitySignals;

  /// No description provided for @copyValue.
  ///
  /// In en, this message translates to:
  /// **'Copy Value'**
  String get copyValue;

  /// No description provided for @editCookie.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get editCookie;

  /// No description provided for @deleteCookie.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get deleteCookie;

  /// No description provided for @revealValue.
  ///
  /// In en, this message translates to:
  /// **'Reveal full value'**
  String get revealValue;

  /// No description provided for @confirmDeletion.
  ///
  /// In en, this message translates to:
  /// **'Confirm Deletion'**
  String get confirmDeletion;

  /// No description provided for @deleteConfirmMsg.
  ///
  /// In en, this message translates to:
  /// **'Do you want to delete the cookie \"{name}\"?'**
  String deleteConfirmMsg(Object name);

  /// No description provided for @sessionWarning.
  ///
  /// In en, this message translates to:
  /// **'This action may end active sessions.'**
  String get sessionWarning;

  /// No description provided for @deleteAllConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'⚠️ Confirm Mass Deletion'**
  String get deleteAllConfirmTitle;

  /// No description provided for @deleteAllConfirmMsg.
  ///
  /// In en, this message translates to:
  /// **'Do you want to delete ALL cookies?'**
  String get deleteAllConfirmMsg;

  /// No description provided for @deleteAllWarning.
  ///
  /// In en, this message translates to:
  /// **'ATTENTION: This action is irreversible!\n• All sessions will be ended\n• You will be logged out of sites\n• Saved settings will be lost'**
  String get deleteAllWarning;

  /// No description provided for @understandWarning.
  ///
  /// In en, this message translates to:
  /// **'I understand this may end sessions'**
  String get understandWarning;

  /// No description provided for @exportFormat.
  ///
  /// In en, this message translates to:
  /// **'Export Cookies'**
  String get exportFormat;

  /// No description provided for @exportWarning.
  ///
  /// In en, this message translates to:
  /// **'This report contains authentication cookies.'**
  String get exportWarning;

  /// No description provided for @exportMasked.
  ///
  /// In en, this message translates to:
  /// **'Masked values (recommended)'**
  String get exportMasked;

  /// No description provided for @exportMaskedDesc.
  ///
  /// In en, this message translates to:
  /// **'Sensitive cookies will be protected'**
  String get exportMaskedDesc;

  /// No description provided for @exportReal.
  ///
  /// In en, this message translates to:
  /// **'Real values'**
  String get exportReal;

  /// No description provided for @exportRealDesc.
  ///
  /// In en, this message translates to:
  /// **'Requires additional authentication'**
  String get exportRealDesc;

  /// No description provided for @statistics.
  ///
  /// In en, this message translates to:
  /// **'📊 Statistics'**
  String get statistics;

  /// No description provided for @totalCookies.
  ///
  /// In en, this message translates to:
  /// **'Total Cookies'**
  String get totalCookies;

  /// No description provided for @totalDomains.
  ///
  /// In en, this message translates to:
  /// **'Total Domains'**
  String get totalDomains;

  /// No description provided for @secureCookies.
  ///
  /// In en, this message translates to:
  /// **'Secure Cookies'**
  String get secureCookies;

  /// No description provided for @httpOnlyCookies.
  ///
  /// In en, this message translates to:
  /// **'HttpOnly Cookies'**
  String get httpOnlyCookies;

  /// No description provided for @expiredCookies.
  ///
  /// In en, this message translates to:
  /// **'Expired Cookies'**
  String get expiredCookies;

  /// No description provided for @securityReport.
  ///
  /// In en, this message translates to:
  /// **'🔐 Security Report'**
  String get securityReport;

  /// No description provided for @viewDetails.
  ///
  /// In en, this message translates to:
  /// **'View Details'**
  String get viewDetails;

  /// No description provided for @securitySettings.
  ///
  /// In en, this message translates to:
  /// **'🔒 Security Settings'**
  String get securitySettings;

  /// No description provided for @biometricAuth.
  ///
  /// In en, this message translates to:
  /// **'Biometric Authentication'**
  String get biometricAuth;

  /// No description provided for @protectSensitiveActions.
  ///
  /// In en, this message translates to:
  /// **'Protect sensitive actions'**
  String get protectSensitiveActions;

  /// No description provided for @configurePin.
  ///
  /// In en, this message translates to:
  /// **'Configure PIN'**
  String get configurePin;

  /// No description provided for @alternativePin.
  ///
  /// In en, this message translates to:
  /// **'Alternative security PIN'**
  String get alternativePin;

  /// No description provided for @authRequired.
  ///
  /// In en, this message translates to:
  /// **'Authentication Required'**
  String get authRequired;

  /// No description provided for @configurePinMsg.
  ///
  /// In en, this message translates to:
  /// **'Configure a security PIN to protect sensitive actions.'**
  String get configurePinMsg;

  /// No description provided for @enterPin.
  ///
  /// In en, this message translates to:
  /// **'Enter your PIN'**
  String get enterPin;

  /// No description provided for @pinMinLength.
  ///
  /// In en, this message translates to:
  /// **'PIN (minimum 4 digits)'**
  String get pinMinLength;

  /// No description provided for @confirmPin.
  ///
  /// In en, this message translates to:
  /// **'Confirm PIN'**
  String get confirmPin;

  /// No description provided for @pinsDoNotMatch.
  ///
  /// In en, this message translates to:
  /// **'PINs do not match'**
  String get pinsDoNotMatch;

  /// No description provided for @pinTooShort.
  ///
  /// In en, this message translates to:
  /// **'PIN must be at least 4 digits'**
  String get pinTooShort;

  /// No description provided for @pinConfigured.
  ///
  /// In en, this message translates to:
  /// **'PIN configured'**
  String get pinConfigured;

  /// No description provided for @errorConfiguringPin.
  ///
  /// In en, this message translates to:
  /// **'Error configuring PIN'**
  String get errorConfiguringPin;

  /// No description provided for @webviewLimitations.
  ///
  /// In en, this message translates to:
  /// **'Note: Cookies with httpOnly and secure flags may not be visible through JavaScript. To view all cookies, use browser developer tools or access via HTTP Cookie Manager.'**
  String get webviewLimitations;

  /// No description provided for @webviewRequiresActive.
  ///
  /// In en, this message translates to:
  /// **'This functionality requires an active WebView.'**
  String get webviewRequiresActive;

  /// No description provided for @valueCopied.
  ///
  /// In en, this message translates to:
  /// **'Value copied to clipboard'**
  String get valueCopied;

  /// No description provided for @cookieUpdated.
  ///
  /// In en, this message translates to:
  /// **'Cookie updated'**
  String get cookieUpdated;

  /// No description provided for @errorUpdatingCookie.
  ///
  /// In en, this message translates to:
  /// **'Error updating cookie'**
  String get errorUpdatingCookie;

  /// No description provided for @cookieDeleted.
  ///
  /// In en, this message translates to:
  /// **'Cookie deleted'**
  String get cookieDeleted;

  /// No description provided for @errorDeletingCookie.
  ///
  /// In en, this message translates to:
  /// **'Error deleting cookie'**
  String get errorDeletingCookie;

  /// No description provided for @allCookiesDeleted.
  ///
  /// In en, this message translates to:
  /// **'All cookies have been deleted'**
  String get allCookiesDeleted;

  /// No description provided for @errorDeletingCookies.
  ///
  /// In en, this message translates to:
  /// **'Error deleting cookies'**
  String get errorDeletingCookies;

  /// No description provided for @noCookiesToExport.
  ///
  /// In en, this message translates to:
  /// **'No cookies to export'**
  String get noCookiesToExport;

  /// No description provided for @jsonCopied.
  ///
  /// In en, this message translates to:
  /// **'JSON copied to clipboard'**
  String get jsonCopied;

  /// No description provided for @csvCopied.
  ///
  /// In en, this message translates to:
  /// **'CSV copied to clipboard'**
  String get csvCopied;

  /// No description provided for @errorExporting.
  ///
  /// In en, this message translates to:
  /// **'Error exporting: {error}'**
  String errorExporting(Object error);

  /// No description provided for @fullSecurityReport.
  ///
  /// In en, this message translates to:
  /// **'Full Security Report'**
  String get fullSecurityReport;

  /// No description provided for @reportCopied.
  ///
  /// In en, this message translates to:
  /// **'Report copied'**
  String get reportCopied;

  /// No description provided for @premium.
  ///
  /// In en, this message translates to:
  /// **'Premium'**
  String get premium;

  /// No description provided for @goPremium.
  ///
  /// In en, this message translates to:
  /// **'Go Premium'**
  String get goPremium;

  /// No description provided for @restorePurchases.
  ///
  /// In en, this message translates to:
  /// **'Restore Purchases'**
  String get restorePurchases;

  /// No description provided for @premiumDesc.
  ///
  /// In en, this message translates to:
  /// **'Unlock unlimited access and remove ads.'**
  String get premiumDesc;

  /// No description provided for @securityCheck.
  ///
  /// In en, this message translates to:
  /// **'Security Check'**
  String get securityCheck;

  /// No description provided for @securityCheckDesc.
  ///
  /// In en, this message translates to:
  /// **'Verify device security'**
  String get securityCheckDesc;

  /// No description provided for @refresh.
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get refresh;

  /// No description provided for @securityCheckError.
  ///
  /// In en, this message translates to:
  /// **'Error checking security: {error}'**
  String securityCheckError(Object error);

  /// No description provided for @noResultsAvailable.
  ///
  /// In en, this message translates to:
  /// **'No results available'**
  String get noResultsAvailable;

  /// No description provided for @securityLevel.
  ///
  /// In en, this message translates to:
  /// **'Security Level'**
  String get securityLevel;

  /// No description provided for @riskScore.
  ///
  /// In en, this message translates to:
  /// **'Risk Score'**
  String get riskScore;

  /// No description provided for @checks.
  ///
  /// In en, this message translates to:
  /// **'Checks'**
  String get checks;

  /// No description provided for @recommendedActions.
  ///
  /// In en, this message translates to:
  /// **'Recommended Actions'**
  String get recommendedActions;

  /// No description provided for @criticalThreats.
  ///
  /// In en, this message translates to:
  /// **'Critical Threats'**
  String get criticalThreats;

  /// No description provided for @warnings.
  ///
  /// In en, this message translates to:
  /// **'Warnings'**
  String get warnings;

  /// No description provided for @safe.
  ///
  /// In en, this message translates to:
  /// **'Safe'**
  String get safe;

  /// No description provided for @critical.
  ///
  /// In en, this message translates to:
  /// **'Critical'**
  String get critical;

  /// No description provided for @warning.
  ///
  /// In en, this message translates to:
  /// **'Warning'**
  String get warning;

  /// No description provided for @checksPerformed.
  ///
  /// In en, this message translates to:
  /// **'Checks Performed'**
  String get checksPerformed;

  /// No description provided for @checkRootJailbreak.
  ///
  /// In en, this message translates to:
  /// **'Root/Jailbreak'**
  String get checkRootJailbreak;

  /// No description provided for @checkDebugger.
  ///
  /// In en, this message translates to:
  /// **'Debugger'**
  String get checkDebugger;

  /// No description provided for @checkHooking.
  ///
  /// In en, this message translates to:
  /// **'Hooking'**
  String get checkHooking;

  /// No description provided for @checkIntegrity.
  ///
  /// In en, this message translates to:
  /// **'App Integrity'**
  String get checkIntegrity;

  /// No description provided for @checkOSVersion.
  ///
  /// In en, this message translates to:
  /// **'Updated System'**
  String get checkOSVersion;

  /// No description provided for @checkScreenLock.
  ///
  /// In en, this message translates to:
  /// **'Screen Lock'**
  String get checkScreenLock;

  /// No description provided for @checkRealDevice.
  ///
  /// In en, this message translates to:
  /// **'Real Device'**
  String get checkRealDevice;

  /// No description provided for @statusOk.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get statusOk;

  /// No description provided for @statusFailed.
  ///
  /// In en, this message translates to:
  /// **'FAILED'**
  String get statusFailed;

  /// No description provided for @understood.
  ///
  /// In en, this message translates to:
  /// **'Understood'**
  String get understood;

  /// No description provided for @securityLevelSafe.
  ///
  /// In en, this message translates to:
  /// **'Safe'**
  String get securityLevelSafe;

  /// No description provided for @securityLevelWarning.
  ///
  /// In en, this message translates to:
  /// **'Warnings Detected'**
  String get securityLevelWarning;

  /// No description provided for @securityLevelCritical.
  ///
  /// In en, this message translates to:
  /// **'CRITICAL THREATS'**
  String get securityLevelCritical;

  /// No description provided for @securityDescSafe.
  ///
  /// In en, this message translates to:
  /// **'All security checks passed'**
  String get securityDescSafe;

  /// No description provided for @securityDescWarning.
  ///
  /// In en, this message translates to:
  /// **'Some settings can be improved'**
  String get securityDescWarning;

  /// No description provided for @securityDescCritical.
  ///
  /// In en, this message translates to:
  /// **'Critical threats detected - Action required'**
  String get securityDescCritical;

  /// No description provided for @actionRootTitle.
  ///
  /// In en, this message translates to:
  /// **'Root Device Detected'**
  String get actionRootTitle;

  /// No description provided for @actionRootDesc.
  ///
  /// In en, this message translates to:
  /// **'Your device has superuser privileges (root). This compromises app security.'**
  String get actionRootDesc;

  /// No description provided for @actionRootRec.
  ///
  /// In en, this message translates to:
  /// **'Remove root or use a non-rooted device.'**
  String get actionRootRec;

  /// No description provided for @actionDebuggerTitle.
  ///
  /// In en, this message translates to:
  /// **'Debugger Detected'**
  String get actionDebuggerTitle;

  /// No description provided for @actionDebuggerDesc.
  ///
  /// In en, this message translates to:
  /// **'A debugger is attached to the application. This may indicate an attempt to analyze or modify the app.'**
  String get actionDebuggerDesc;

  /// No description provided for @actionDebuggerRec.
  ///
  /// In en, this message translates to:
  /// **'Close all developer tools and restart.'**
  String get actionDebuggerRec;

  /// No description provided for @actionHookingTitle.
  ///
  /// In en, this message translates to:
  /// **'Hooking Framework Detected'**
  String get actionHookingTitle;

  /// No description provided for @actionHookingDesc.
  ///
  /// In en, this message translates to:
  /// **'A hooking framework (Frida, Xposed) was detected. This allows modifying app behavior.'**
  String get actionHookingDesc;

  /// No description provided for @actionHookingRec.
  ///
  /// In en, this message translates to:
  /// **'Remove hooking frameworks and restart.'**
  String get actionHookingRec;

  /// No description provided for @actionIntegrityTitle.
  ///
  /// In en, this message translates to:
  /// **'Compromised App Integrity'**
  String get actionIntegrityTitle;

  /// No description provided for @actionIntegrityDesc.
  ///
  /// In en, this message translates to:
  /// **'The app signature does not match expected. The app may have been modified.'**
  String get actionIntegrityDesc;

  /// No description provided for @actionIntegrityRec.
  ///
  /// In en, this message translates to:
  /// **'Reinstall from the official store (Play Store).'**
  String get actionIntegrityRec;

  /// No description provided for @actionOSTitle.
  ///
  /// In en, this message translates to:
  /// **'Outdated Operating System'**
  String get actionOSTitle;

  /// No description provided for @actionOSDesc.
  ///
  /// In en, this message translates to:
  /// **'Your OS is outdated and may contain vulnerabilities.'**
  String get actionOSDesc;

  /// No description provided for @actionOSRec.
  ///
  /// In en, this message translates to:
  /// **'Update your OS to the latest version.'**
  String get actionOSRec;

  /// No description provided for @actionLockTitle.
  ///
  /// In en, this message translates to:
  /// **'No Screen Lock Configured'**
  String get actionLockTitle;

  /// No description provided for @actionLockDesc.
  ///
  /// In en, this message translates to:
  /// **'Your device has no screen lock. This facilitates unauthorized access.'**
  String get actionLockDesc;

  /// No description provided for @actionLockRec.
  ///
  /// In en, this message translates to:
  /// **'Set up a PIN, password, or pattern in settings.'**
  String get actionLockRec;

  /// No description provided for @actionEmulatorTitle.
  ///
  /// In en, this message translates to:
  /// **'Running on Emulator'**
  String get actionEmulatorTitle;

  /// No description provided for @actionEmulatorDesc.
  ///
  /// In en, this message translates to:
  /// **'The app is running on an emulator. Some features may be limited.'**
  String get actionEmulatorDesc;

  /// No description provided for @actionEmulatorRec.
  ///
  /// In en, this message translates to:
  /// **'Use a physical device for better experience.'**
  String get actionEmulatorRec;

  /// No description provided for @actionUnknownSourcesTitle.
  ///
  /// In en, this message translates to:
  /// **'Unknown Sources Enabled'**
  String get actionUnknownSourcesTitle;

  /// No description provided for @actionUnknownSourcesDesc.
  ///
  /// In en, this message translates to:
  /// **'Your device allows installing apps from unknown sources. This facilitates malware installation.'**
  String get actionUnknownSourcesDesc;

  /// No description provided for @actionUnknownSourcesRec.
  ///
  /// In en, this message translates to:
  /// **'Disable \'Install unknown apps\' in security settings.'**
  String get actionUnknownSourcesRec;

  /// No description provided for @actionLocationTitle.
  ///
  /// In en, this message translates to:
  /// **'Apps with \'Always\' Location'**
  String get actionLocationTitle;

  /// No description provided for @actionLocationDesc.
  ///
  /// In en, this message translates to:
  /// **'{count} app(s) have background location permission. This poses a privacy risk.'**
  String actionLocationDesc(Object count);

  /// No description provided for @actionLocationRec.
  ///
  /// In en, this message translates to:
  /// **'Review location permissions.'**
  String get actionLocationRec;

  /// No description provided for @actionNotifTitle.
  ///
  /// In en, this message translates to:
  /// **'Sensitive Notifications on Lock Screen'**
  String get actionNotifTitle;

  /// No description provided for @actionNotifDesc.
  ///
  /// In en, this message translates to:
  /// **'Sensitive notification previews (codes, messages) are visible on lock screen.'**
  String get actionNotifDesc;

  /// No description provided for @actionNotifRec.
  ///
  /// In en, this message translates to:
  /// **'Hide sensitive content on lock screen notifications.'**
  String get actionNotifRec;

  /// No description provided for @actionPatchTitle.
  ///
  /// In en, this message translates to:
  /// **'Outdated Security Patch'**
  String get actionPatchTitle;

  /// No description provided for @actionPatchDesc.
  ///
  /// In en, this message translates to:
  /// **'Security patch is older than 60 days. Known vulnerabilities may not be patched.'**
  String get actionPatchDesc;

  /// No description provided for @actionPatchRec.
  ///
  /// In en, this message translates to:
  /// **'Check for system updates.'**
  String get actionPatchRec;

  /// No description provided for @action2FATitle.
  ///
  /// In en, this message translates to:
  /// **'Enable Two-Factor Authentication (2FA)'**
  String get action2FATitle;

  /// No description provided for @action2FADesc.
  ///
  /// In en, this message translates to:
  /// **'2FA adds an extra layer of security to your critical accounts (Google/Apple ID).'**
  String get action2FADesc;

  /// No description provided for @action2FARec.
  ///
  /// In en, this message translates to:
  /// **'Enable 2FA in your account security settings.'**
  String get action2FARec;

  /// No description provided for @expAppSignaturesTitle.
  ///
  /// In en, this message translates to:
  /// **'App Monitoring'**
  String get expAppSignaturesTitle;

  /// No description provided for @expAppSignaturesDesc.
  ///
  /// In en, this message translates to:
  /// **'Checks if sensitive apps (like banking and social media apps) are original and have not been modified by hackers.\n\n⚠️ Why is it critical?\n• Fake apps can steal your banking credentials\n• Can clone your WhatsApp\n• Can intercept 2FA codes\n\n✅ What does it mean?\nIf failed: An installed app is not the original from the official store (Play Store) and may be dangerous.'**
  String get expAppSignaturesDesc;

  /// No description provided for @expRootTitle.
  ///
  /// In en, this message translates to:
  /// **'Root/Jailbreak'**
  String get expRootTitle;

  /// No description provided for @expRootDesc.
  ///
  /// In en, this message translates to:
  /// **'Root (Android) or Jailbreak (iOS) is when someone modifies the system to gain full access.\n\n⚠️ Why is it dangerous?\n• Malicious apps can steal your passwords\n• Your banking data becomes vulnerable\n• Banking apps might not work\n\n✅ What to do?\nIf you didn\'t do this on purpose, your device may be compromised. Consider factory resetting it.'**
  String get expRootDesc;

  /// No description provided for @expDebuggerTitle.
  ///
  /// In en, this message translates to:
  /// **'Debugger Detected'**
  String get expDebuggerTitle;

  /// No description provided for @expDebuggerDesc.
  ///
  /// In en, this message translates to:
  /// **'A debugger is a tool used by programmers to analyze apps.\n\n⚠️ Why is it dangerous?\n• Hackers can use it to spy on the app\n• Can discover passwords and sensitive data\n• Can modify app behavior\n\n✅ What to do?\nIf you are not a developer, you shouldn\'t have an active debugger. Close developer instruments or restart the phone.'**
  String get expDebuggerDesc;

  /// No description provided for @expHookingTitle.
  ///
  /// In en, this message translates to:
  /// **'Hooking Framework'**
  String get expHookingTitle;

  /// No description provided for @expHookingDesc.
  ///
  /// In en, this message translates to:
  /// **'Hooking is when a malicious program intercepts and modifies how apps work.\n\n⚠️ Why is it dangerous?\n• Can steal your passwords as you type\n• Can modify banking transactions\n• Can read private messages\n\n✅ What to do?\nUninstall suspicious apps, especially \'optimizers\' or \'boosters\' you don\'t recognize.'**
  String get expHookingDesc;

  /// No description provided for @expIntegrityTitle.
  ///
  /// In en, this message translates to:
  /// **'App Integrity'**
  String get expIntegrityTitle;

  /// No description provided for @expIntegrityDesc.
  ///
  /// In en, this message translates to:
  /// **'Checks if this app has been modified after installation.\n\n⚠️ Why is it important?\n• Modified apps may contain viruses\n• Can steal your data\n• Might not work correctly\n\n✅ What does it mean?\nIf passed: The app is original and safe\nIf failed: The app may have been tampered with'**
  String get expIntegrityDesc;

  /// No description provided for @expOSTitle.
  ///
  /// In en, this message translates to:
  /// **'System Updated'**
  String get expOSTitle;

  /// No description provided for @expOSDesc.
  ///
  /// In en, this message translates to:
  /// **'Checks if your Android/iOS is up to date.\n\n⚠️ Why is it important?\n• Old systems have known security flaws\n• Hackers exploit these flaws\n• You are vulnerable to viruses\n\n✅ What to do?\nGo to Settings → System Update and install available updates.'**
  String get expOSDesc;

  /// No description provided for @expLockTitle.
  ///
  /// In en, this message translates to:
  /// **'Screen Lock'**
  String get expLockTitle;

  /// No description provided for @expLockDesc.
  ///
  /// In en, this message translates to:
  /// **'Checks if you have a password, PIN, pattern, or biometrics set up.\n\n⚠️ Why is it important?\n• Anyone can take your unlocked phone\n• Can access your apps, photos, and messages\n• Can make purchases or transfers\n\n✅ What to do?\nSet up a strong password or use your fingerprint/face ID in Settings → Security.'**
  String get expLockDesc;

  /// No description provided for @expEmulatorTitle.
  ///
  /// In en, this message translates to:
  /// **'Real Device'**
  String get expEmulatorTitle;

  /// No description provided for @expEmulatorDesc.
  ///
  /// In en, this message translates to:
  /// **'Checks if you are using a real phone or an emulator (virtual phone on computer).\n\n⚠️ Why is it important?\n• Emulators are used by hackers to test attacks\n• Banking apps don\'t work on emulators\n• May indicate fraud attempt\n\n✅ What does it mean?\nIf you are on a real phone, you should pass this check.'**
  String get expEmulatorDesc;

  /// No description provided for @securitySignatureStatus.
  ///
  /// In en, this message translates to:
  /// **'Signature Status ({count})'**
  String securitySignatureStatus(Object count);

  /// No description provided for @securityAppNotInstalled.
  ///
  /// In en, this message translates to:
  /// **'Not Installed'**
  String get securityAppNotInstalled;

  /// No description provided for @securityAppVerified.
  ///
  /// In en, this message translates to:
  /// **'Verified'**
  String get securityAppVerified;

  /// No description provided for @securityAppPendingConfig.
  ///
  /// In en, this message translates to:
  /// **'Config Pending'**
  String get securityAppPendingConfig;

  /// No description provided for @securityAppInvalidSignature.
  ///
  /// In en, this message translates to:
  /// **'Invalid Signature!'**
  String get securityAppInvalidSignature;

  /// No description provided for @securityAppUnknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get securityAppUnknown;

  /// No description provided for @securityAppActualHash.
  ///
  /// In en, this message translates to:
  /// **'Actual:'**
  String get securityAppActualHash;

  /// No description provided for @securityAppExpectedHash.
  ///
  /// In en, this message translates to:
  /// **'Expected:'**
  String get securityAppExpectedHash;

  /// No description provided for @securityConfigNeeded.
  ///
  /// In en, this message translates to:
  /// **'Configure...'**
  String get securityConfigNeeded;

  /// No description provided for @viewerDocUnsupported.
  ///
  /// In en, this message translates to:
  /// **'Viewing .doc files (Word 97-2003) is not yet supported due to technical limitations.\n\nPlease save the file as .docx to view.'**
  String get viewerDocUnsupported;

  /// No description provided for @viewerDocEmpty.
  ///
  /// In en, this message translates to:
  /// **'The file appears empty or text could not be extracted.\n\nNote: Images and complex formatting are not displayed.'**
  String get viewerDocEmpty;

  /// No description provided for @viewerDocInvalid.
  ///
  /// In en, this message translates to:
  /// **'Format Error:\nThis is not a valid DOCX file.\n1. It might be an old .doc file manually renamed.\n2. It might be corrupted.\n\nSolution: Open in Word and use \'Save As\' -> \'.docx\'.'**
  String get viewerDocInvalid;

  /// No description provided for @viewerDocError.
  ///
  /// In en, this message translates to:
  /// **'Error reading DOCX document:\n{error}'**
  String viewerDocError(Object error);

  /// No description provided for @viewerExcelError.
  ///
  /// In en, this message translates to:
  /// **'Error reading Excel file:\n{error}'**
  String viewerExcelError(Object error);

  /// No description provided for @viewerZipError.
  ///
  /// In en, this message translates to:
  /// **'Error reading ZIP file:\n{error}'**
  String viewerZipError(Object error);

  /// No description provided for @viewerCertificateBinary.
  ///
  /// In en, this message translates to:
  /// **'This certificate file ({extension}) is binary.\nRaw content view is not supported for this format.'**
  String viewerCertificateBinary(Object extension);

  /// No description provided for @viewerFileError.
  ///
  /// In en, this message translates to:
  /// **'Error reading file:\n{error}'**
  String viewerFileError(Object error);

  /// No description provided for @viewerSaveError.
  ///
  /// In en, this message translates to:
  /// **'Error saving: {error}'**
  String viewerSaveError(Object error);

  /// No description provided for @viewerTooltipShowFormatted.
  ///
  /// In en, this message translates to:
  /// **'Show Formatted'**
  String get viewerTooltipShowFormatted;

  /// No description provided for @viewerTooltipShowRaw.
  ///
  /// In en, this message translates to:
  /// **'Show Raw'**
  String get viewerTooltipShowRaw;

  /// No description provided for @aiErrorKeyMissing.
  ///
  /// In en, this message translates to:
  /// **'Error: API Key is missing. Please configure it in Settings.'**
  String get aiErrorKeyMissing;

  /// No description provided for @aiErrorCommunication.
  ///
  /// In en, this message translates to:
  /// **'Error communicating with AI: {error}'**
  String aiErrorCommunication(Object error);

  /// No description provided for @aiSystemPrompt.
  ///
  /// In en, this message translates to:
  /// **'You are an intelligent File Assistant integrated into MviewerPlus. Your task is to analyze the file content provided and help the user. Answer in language: {language}.'**
  String aiSystemPrompt(Object language);

  /// No description provided for @aiDisclaimer.
  ///
  /// In en, this message translates to:
  /// **'AI can make mistakes. Check important info.'**
  String get aiDisclaimer;

  /// No description provided for @reportContent.
  ///
  /// In en, this message translates to:
  /// **'Report'**
  String get reportContent;

  /// No description provided for @reportContentDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Report Content'**
  String get reportContentDialogTitle;

  /// No description provided for @reportContentDialogDesc.
  ///
  /// In en, this message translates to:
  /// **'Do you want to report and clear this conversation due to inappropriate content?'**
  String get reportContentDialogDesc;

  /// No description provided for @reportActionClear.
  ///
  /// In en, this message translates to:
  /// **'Report & Clear'**
  String get reportActionClear;

  /// No description provided for @reportThanks.
  ///
  /// In en, this message translates to:
  /// **'Thank you for your report. Content has been removed.'**
  String get reportThanks;

  /// No description provided for @unknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get unknown;

  /// No description provided for @videoError.
  ///
  /// In en, this message translates to:
  /// **'Error playing video: {error}'**
  String videoError(Object error);

  /// No description provided for @videoLoadingError.
  ///
  /// In en, this message translates to:
  /// **'Failed to load video'**
  String get videoLoadingError;

  /// No description provided for @globalErrorTitle.
  ///
  /// In en, this message translates to:
  /// **'Oops, something went wrong.'**
  String get globalErrorTitle;

  /// No description provided for @globalErrorDesc.
  ///
  /// In en, this message translates to:
  /// **'Don\'t worry, your data is safe.'**
  String get globalErrorDesc;

  /// No description provided for @backToHome.
  ///
  /// In en, this message translates to:
  /// **'Back to Home'**
  String get backToHome;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es', 'pt'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when language+country codes are specified.
  switch (locale.languageCode) {
    case 'pt':
      {
        switch (locale.countryCode) {
          case 'BR':
            return AppLocalizationsPtBr();
          case 'PT':
            return AppLocalizationsPtPt();
        }
        break;
      }
  }

  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'pt':
      return AppLocalizationsPt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
