import 'package:flutter/material.dart';
import '../../domain/models/cookie_file_hit.dart';
import '../../domain/models/cookie_risk_result.dart';
import '../screens/cookie_file_detail_screen.dart';
import 'cookie_risk_badge.dart';

class CookieHitTile extends StatelessWidget {
  final CookieFileHit file;
  final CookieRiskResult? riskResult;

  const CookieHitTile({
    super.key,
    required this.file,
    this.riskResult,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ListTile(
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(file.typeIcon, style: const TextStyle(fontSize: 24)),
            if (riskResult != null)
              CookieRiskBadge(riskLevel: riskResult!.riskLevel),
          ],
        ),
        title: Text(file.fileName),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${file.browserIcon} ${file.browserName ?? "Unknown"}'),
            Text(file.formattedSize),
          ],
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CookieFileDetailScreen(
                file: file,
                riskResult: riskResult,
              ),
            ),
          );
        },
      ),
    );
  }
}
