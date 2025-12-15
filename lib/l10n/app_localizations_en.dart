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
  String get termsOfService => 'Terms of Service';

  @override
  String get language => 'Language';

  @override
  String get theme => 'Theme';

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
      'Last updated: December 2025\n\nThis Privacy Policy describes how MviewerPlus handles your information.\n\n1. Data Collection\nWe do not collect personal data. File processing is local.\n\n2. AI Features (Groq)\nWhen using the AI assistant, file content is sent to Groq API using your personal API Key. No data is stored by us.\n\n3. Free Model\nThis app is 100% free, open-source, and does not display ads.\n\n4. Contact\nFor questions, please contact: contato@multiversodigital.com.br';

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

  @override
  String get pdfReportTitle => 'MviewerPlus Report';

  @override
  String get pdfGeneratedLabel => 'Generated:';

  @override
  String get pdfFileLabel => 'File:';

  @override
  String get pdfSizeLabel => 'Size:';

  @override
  String get pdfRecordsLabel => 'Records:';

  @override
  String get pdfPage => 'Page';

  @override
  String get pdfOf => 'of';

  @override
  String get rows => 'rows';

  @override
  String get files => 'files';

  @override
  String get lines => 'lines';

  @override
  String get archiveBadge => 'ARCHIVE';

  @override
  String get zipEmpty => 'Empty or invalid ZIP archive';

  @override
  String zipArchiveInfo(Object count) {
    return 'Zip Archive ($count files)';
  }

  @override
  String get fileName => 'File Name';

  @override
  String get fileType => 'Type';

  @override
  String get fileSizeCol => 'Size (KB)';

  @override
  String get searchNotAvailableZip => 'Search not available for archive files.';

  @override
  String get readOnlyFormat => 'This format is read-only.';

  @override
  String get processingWait => 'Reading file, please wait.';

  @override
  String get loadingTitle => 'Loading...';

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
}
