import 'dart:convert';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '../../domain/models/cookie_entry.dart';
import '../../domain/security/cookie_security_guard.dart';

/// Serviço para exportar cookies em diferentes formatos
class CookieExportService {
  /// Exporta cookies para JSON
  String exportToJson({
    required List<CookieEntry> cookies,
    required String source,
    required String domain,
    bool maskSensitiveValues = true,
  }) {
    final data = {
      'export_date': DateTime.now().toIso8601String(),
      'source': source,
      'domain': domain,
      'total_cookies': cookies.length,
      'masked_values': maskSensitiveValues,
      'cookies': cookies.map((cookie) {
        final analysis = CookieSecurityGuard.analyze(cookie);
        final shouldMask = maskSensitiveValues && analysis.isSensitive;

        return {
          'name': cookie.name,
          'value': shouldMask ? cookie.maskedValue : cookie.value,
          'domain': cookie.domain,
          'path': cookie.path,
          'expires': cookie.expires?.toIso8601String(),
          'secure': cookie.secure,
          'httpOnly': cookie.httpOnly,
          'sameSite': cookie.sameSite,
          'is_sensitive': analysis.isSensitive,
          'risk_level': analysis.riskLevel.name,
          'risk_score': analysis.riskScore,
        };
      }).toList(),
    };

    const encoder = JsonEncoder.withIndent('  ');
    return encoder.convert(data);
  }

  /// Exporta cookies para CSV
  String exportToCsv({
    required List<CookieEntry> cookies,
    bool maskSensitiveValues = true,
  }) {
    final buffer = StringBuffer();
    
    // Cabeçalho
    buffer.writeln(
      'Name,Value,Domain,Path,Expires,Secure,HttpOnly,SameSite,Risk Level,Risk Score',
    );

    // Dados
    for (final cookie in cookies) {
      final analysis = CookieSecurityGuard.analyze(cookie);
      final shouldMask = maskSensitiveValues && analysis.isSensitive;
      final value = shouldMask ? cookie.maskedValue : cookie.value;

      buffer.writeln(
        '"${cookie.name}",'
        '"$value",'
        '"${cookie.domain}",'
        '"${cookie.path}",'
        '"${cookie.expires?.toIso8601String() ?? 'Session'}",'
        '${cookie.secure},'
        '${cookie.httpOnly},'
        '"${cookie.sameSite ?? 'None'}",'
        '${analysis.riskLevel.name},'
        '${analysis.riskScore}',
      );
    }

    return buffer.toString();
  }

  /// Exporta cookies para PDF
  Future<void> exportToPdf({
    required List<CookieEntry> cookies,
    required String source,
    required String domain,
    bool maskSensitiveValues = true,
  }) async {
    final pdf = pw.Document();

    // Agrupa cookies em páginas (máximo 15 por página)
    final cookiesPerPage = 15;
    final totalPages = (cookies.length / cookiesPerPage).ceil();

    for (int page = 0; page < totalPages; page++) {
      final startIndex = page * cookiesPerPage;
      final endIndex = (startIndex + cookiesPerPage).clamp(0, cookies.length);
      final pageCookies = cookies.sublist(startIndex, endIndex);

      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (context) {
            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                // Cabeçalho
                if (page == 0) ...[
                  pw.Header(
                    level: 0,
                    child: pw.Text(
                      'Cookie Report',
                      style: pw.TextStyle(
                        fontSize: 24,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ),
                  pw.SizedBox(height: 10),
                  pw.Text('Source: $source'),
                  pw.Text('Domain: $domain'),
                  pw.Text(
                    'Generated: ${DateTime.now().toString().split('.')[0]}',
                  ),
                  pw.Text('Total Cookies: ${cookies.length}'),
                  if (maskSensitiveValues)
                    pw.Text(
                      'Note: Sensitive values are masked',
                      style: const pw.TextStyle(color: PdfColors.red),
                    ),
                  pw.SizedBox(height: 20),
                  pw.Divider(),
                  pw.SizedBox(height: 10),
                ],

                // Tabela de cookies
                pw.Table(
                  border: pw.TableBorder.all(color: PdfColors.grey),
                  columnWidths: {
                    0: const pw.FlexColumnWidth(2),
                    1: const pw.FlexColumnWidth(3),
                    2: const pw.FlexColumnWidth(2),
                    3: const pw.FlexColumnWidth(1),
                  },
                  children: [
                    // Cabeçalho da tabela
                    pw.TableRow(
                      decoration: const pw.BoxDecoration(
                        color: PdfColors.grey300,
                      ),
                      children: [
                        _buildTableCell('Name', bold: true),
                        _buildTableCell('Value', bold: true),
                        _buildTableCell('Domain', bold: true),
                        _buildTableCell('Risk', bold: true),
                      ],
                    ),

                    // Linhas de dados
                    ...pageCookies.map((cookie) {
                      final analysis = CookieSecurityGuard.analyze(cookie);
                      final shouldMask =
                          maskSensitiveValues && analysis.isSensitive;
                      final value =
                          shouldMask ? cookie.maskedValue : cookie.value;

                      return pw.TableRow(
                        children: [
                          _buildTableCell(cookie.name),
                          _buildTableCell(
                            value.length > 30
                                ? '${value.substring(0, 30)}...'
                                : value,
                          ),
                          _buildTableCell(cookie.domain),
                          _buildTableCell(
                            analysis.riskLevel.name.toUpperCase(),
                            color: _getRiskColor(analysis.riskLevel),
                          ),
                        ],
                      );
                    }).toList(),
                  ],
                ),

                // Rodapé da página
                pw.Spacer(),
                pw.Divider(),
                pw.Text(
                  'Page ${page + 1} of $totalPages',
                  style: const pw.TextStyle(fontSize: 10),
                ),
              ],
            );
          },
        ),
      );
    }

    // Exibe o PDF para impressão/salvamento
    await Printing.layoutPdf(
      onLayout: (format) async => pdf.save(),
      name: 'cookie_report_${DateTime.now().millisecondsSinceEpoch}.pdf',
    );
  }

  /// Constrói uma célula da tabela PDF
  pw.Widget _buildTableCell(
    String text, {
    bool bold = false,
    PdfColor? color,
  }) {
    return pw.Padding(
      padding: const pw.EdgeInsets.all(5),
      child: pw.Text(
        text,
        style: pw.TextStyle(
          fontSize: 9,
          fontWeight: bold ? pw.FontWeight.bold : pw.FontWeight.normal,
          color: color,
        ),
      ),
    );
  }

  /// Retorna a cor PDF baseada no nível de risco
  PdfColor _getRiskColor(RiskLevel level) {
    switch (level) {
      case RiskLevel.high:
        return PdfColors.red;
      case RiskLevel.medium:
        return PdfColors.orange;
      case RiskLevel.low:
        return PdfColors.yellow;
      case RiskLevel.none:
        return PdfColors.green;
    }
  }

  /// Gera um relatório de segurança detalhado
  String generateSecurityReport(List<CookieEntry> cookies) {
    final buffer = StringBuffer();
    buffer.writeln('=== COOKIE SECURITY REPORT ===\n');
    buffer.writeln('Generated: ${DateTime.now()}\n');

    int highRisk = 0;
    int mediumRisk = 0;
    int lowRisk = 0;
    int noRisk = 0;

    final sensitiveDetails = <String>[];

    for (final cookie in cookies) {
      final analysis = CookieSecurityGuard.analyze(cookie);

      switch (analysis.riskLevel) {
        case RiskLevel.high:
          highRisk++;
          break;
        case RiskLevel.medium:
          mediumRisk++;
          break;
        case RiskLevel.low:
          lowRisk++;
          break;
        case RiskLevel.none:
          noRisk++;
          break;
      }

      if (analysis.isSensitive) {
        sensitiveDetails.add(
          '- ${cookie.name} (${cookie.domain}): ${analysis.signals.join(', ')}',
        );
      }
    }

    buffer.writeln('SUMMARY:');
    buffer.writeln('Total Cookies: ${cookies.length}');
    buffer.writeln('High Risk: $highRisk');
    buffer.writeln('Medium Risk: $mediumRisk');
    buffer.writeln('Low Risk: $lowRisk');
    buffer.writeln('No Risk: $noRisk');
    buffer.writeln();

    if (sensitiveDetails.isNotEmpty) {
      buffer.writeln('SENSITIVE COOKIES DETECTED:');
      for (final detail in sensitiveDetails) {
        buffer.writeln(detail);
      }
    }

    return buffer.toString();
  }
}
