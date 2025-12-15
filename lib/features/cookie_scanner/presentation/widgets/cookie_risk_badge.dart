import 'package:flutter/material.dart';
import '../../domain/models/cookie_risk_result.dart';

class CookieRiskBadge extends StatelessWidget {
  final RiskLevel riskLevel;
  final bool showLabel;

  const CookieRiskBadge({
    super.key,
    required this.riskLevel,
    this.showLabel = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = _getColor();
    final icon = _getIcon();
    final label = _getLabel();

    if (showLabel) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: color.withOpacity(0.2),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(icon, style: const TextStyle(fontSize: 12)),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        shape: BoxShape.circle,
        border: Border.all(color: color, width: 2),
      ),
      child: Text(icon, style: const TextStyle(fontSize: 10)),
    );
  }

  Color _getColor() {
    switch (riskLevel) {
      case RiskLevel.none:
        return Colors.green;
      case RiskLevel.low:
        return Colors.yellow.shade700;
      case RiskLevel.medium:
        return Colors.orange;
      case RiskLevel.high:
        return Colors.red;
      case RiskLevel.critical:
        return Colors.red.shade900;
    }
  }

  String _getIcon() {
    switch (riskLevel) {
      case RiskLevel.none:
        return '✅';
      case RiskLevel.low:
        return '⚠️';
      case RiskLevel.medium:
        return '🟠';
      case RiskLevel.high:
        return '🔴';
      case RiskLevel.critical:
        return '🚨';
    }
  }

  String _getLabel() {
    return riskLevel.name.toUpperCase();
  }
}
