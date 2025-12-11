import 'package:file_viewer/screens/settings/premium_screen.dart';
import 'package:file_viewer/screens/settings/privacy_screen.dart';
import 'package:file_viewer/services/premium_service.dart';
import 'package:flutter/material.dart';
import 'package:file_viewer/l10n/app_localizations.dart';
import 'package:provider/provider.dart';

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
              // Open URL or ToS screen
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('Version'),
            subtitle: const Text('1.0.0'),
          ),
        ],
      ),
    );
  }
}
