import 'package:flutter/material.dart';
import 'package:file_viewer/l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.privacyPolicy),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Privacy Policy',
              style: GoogleFonts.outfit(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              'Last updated: December 2025\n\n'
              'This Privacy Policy describes how MviewerPlus collects, uses, and discloses your information '
              'when you use our Service.\n\n'
              '1. Data Collection\n'
              'We do not collect any personal data. Files opened in this application are processed locally '
              'on your device and are not uploaded to any server.\n\n'
              '2. Permissions\n'
              'The app requires storage permissions only to read the files you explicitly select.\n\n'
              '3. Third-Party Services\n'
              'If you opt for the Free version, we may use third-party advertising services (e.g., AdMob) '
              'which may collect device identifiers to show relevant ads. '
              'In the Premium version, no ads are displayed.\n\n'
              '4. Contact Us\n'
              'If you have any questions about this Privacy Policy, please contact us.',
              style: TextStyle(fontSize: 16, height: 1.5, color: Colors.white70),
            ),
          ],
        ),
      ),
    );
  }
}
