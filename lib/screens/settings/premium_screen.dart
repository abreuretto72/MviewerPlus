import 'package:file_viewer/services/premium_service.dart';
import 'package:flutter/material.dart';
import 'package:file_viewer/l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PremiumScreen extends StatefulWidget {
  const PremiumScreen({super.key});

  @override
  State<PremiumScreen> createState() => _PremiumScreenState();
}

class _PremiumScreenState extends State<PremiumScreen> {
  bool _isLoading = false;

  Future<void> _buyPremium(BuildContext context) async {
    setState(() => _isLoading = true);
    final service = Provider.of<PremiumService>(context, listen: false);
    await service.purchasePremium();
    if (!mounted) return;
    setState(() => _isLoading = false);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    
    return Scaffold(
      appBar: AppBar(title: Text(t.premium)),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          children: [
            const Icon(Icons.star_rounded, size: 80, color: Color(0xFFFFD700)),
            const SizedBox(height: 24),
            Text(
              t.goPremium,
              style: GoogleFonts.outfit(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              t.premiumDesc,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18, color: Colors.white70),
            ),
            const Spacer(),
            if (_isLoading)
               const CircularProgressIndicator()
            else
              ElevatedButton(
                onPressed: () => _buyPremium(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFD700),
                  foregroundColor: Colors.black,
                  minimumSize: const Size(double.infinity, 56),
                ),
                child: Text(t.goPremium),
              ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                Provider.of<PremiumService>(context, listen: false).purchasePremium(); // Simulate restore
                Navigator.pop(context);
              },
              child: Text(t.restorePurchases),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
