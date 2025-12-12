import 'package:file_viewer/l10n/app_localizations.dart';
import 'package:file_viewer/providers/locale_provider.dart';
import 'package:file_viewer/screens/settings/premium_screen.dart';
import 'package:file_viewer/screens/settings/privacy_screen.dart';
import 'package:file_viewer/screens/settings/saved_files_screen.dart';
import 'package:file_viewer/screens/settings/terms_screen.dart';
import 'package:file_viewer/services/premium_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final isPremium = context.watch<PremiumService>().isPremium;

    return Scaffold(
      appBar: AppBar(title: Text(t.settings)),
      body: ListView(
        children: [
          if (!isPremium) ...[
            ListTile(
              leading: const Icon(Icons.star, color: Color(0xFFFFD700)),
              title: Text(t.goPremium),
              subtitle: Text(t.premiumDesc),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PremiumScreen()),
                );
              },
            ),
            const Divider(),
          ],
          ListTile(
            leading: const Icon(Icons.language),
            title: Text(t.language),
            subtitle: Text(_getLanguageName(context)),
            onTap: () => _showLanguageDialog(context),
          ),
          ListTile(
            leading: const Icon(Icons.key),
            title: Text(t.apiKey),
            subtitle: Text(t.apiKeyDesc),
            onTap: () => _showApiKeyDialog(context),
          ),
          ListTile(
            leading: const Icon(Icons.policy),
            title: Text(t.privacyPolicy),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PrivacyPolicyScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.description),
            title: Text(t.termsOfService),
            onTap: () {
               Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const TermsScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.history),
            title: Text(t.savedFiles),
            subtitle: Text(t.history),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SavedFilesScreen()),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.info),
            title: Text(t.about),
            onTap: () {
              showAboutDialog(
                context: context,
                applicationName: t.appTitle,
                applicationVersion: t.appVersion,
                applicationIcon: const Icon(Icons.folder_open, size: 48),
                children: [
                   const SizedBox(height: 16),
                   Text(t.companyName, style: const TextStyle(fontWeight: FontWeight.bold)),
                   const SizedBox(height: 8),
                   SelectableText(t.contactEmail),
                ],
              );
            },
          ),

        ],
      ),
    );
  }

  String _getLanguageName(BuildContext context) {
    // Current locale can be obtained from Localizations or Provider
    final locale = Localizations.localeOf(context);
    switch (locale.languageCode) {
      case 'pt':
        return locale.countryCode == 'PT' ? 'Português (Portugal)' : 'Português (Brasil)';
      case 'es':
        return 'Español';
      case 'en':
      default:
        return 'English';
    }
  }

  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text(AppLocalizations.of(context)!.language),
        children: [
          _buildLanguageOption(context, 'English', const Locale('en')),
          _buildLanguageOption(context, 'Português (Brasil)', const Locale('pt', 'BR')),
          _buildLanguageOption(context, 'Português (Portugal)', const Locale('pt', 'PT')),
          _buildLanguageOption(context, 'Español', const Locale('es')),
        ],
      ),
    );
  }



  Widget _buildLanguageOption(BuildContext context, String name, Locale locale) {
    return SimpleDialogOption(
      onPressed: () {
        context.read<LocaleProvider>().setLocale(locale);
        Navigator.pop(context);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Text(name),
      ),
    );
  }

  void _showApiKeyDialog(BuildContext context) async {
    final t = AppLocalizations.of(context)!;
    final prefs = await SharedPreferences.getInstance();
    final currentKey = prefs.getString('custom_groq_api_key') ?? '';
    final controller = TextEditingController(text: currentKey);

    if (!context.mounted) return;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(t.apiKey),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(t.apiKeyDesc, style: Theme.of(context).textTheme.bodySmall),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text(t.getApiKeyDialogTitle),
                    content: SingleChildScrollView(
                      child: Text(t.getApiKeyDialogContent),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text(t.close),
                      ),
                    ],
                  ),
                );
              },
              child: Text(
                t.getApiKeyHelpBtn,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: controller,
              decoration: InputDecoration(
                labelText: t.enterApiKey,
                border: const OutlineInputBorder(),
              ),
              obscureText: true,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(t.cancel),
          ),
          FilledButton(
            onPressed: () async {
              await prefs.setString('custom_groq_api_key', controller.text.trim());
              if (context.mounted) Navigator.pop(context);
            },
            child: Text(t.save),
          ),
        ],
      ),
    );
  }
}
