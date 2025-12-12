import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:file_viewer/l10n/app_localizations.dart';

class PdfViewerScreen extends StatefulWidget {
  final String fileName;
  final String content;
  final List<Map<String, String>> messages;
  final bool isDirectFileView;
  final List<List<dynamic>>? csvData;

  const PdfViewerScreen({
    super.key,
    required this.fileName,
    required this.content,
    this.messages = const [],
    this.isDirectFileView = false,
    this.csvData,
  });

  @override
  State<PdfViewerScreen> createState() => _PdfViewerScreenState();
}

class _PdfViewerScreenState extends State<PdfViewerScreen> {
  bool _includeOriginal = false;
  late bool _isDirectFileView;
  late bool _isCsvFile;
  Key _previewKey = UniqueKey();

  @override
  void initState() {
    super.initState();
    _isDirectFileView = widget.isDirectFileView;
    _isCsvFile = widget.csvData != null && widget.csvData!.isNotEmpty;
    // If direct view, we MUST show original content (since there is no chat)
    if (_isDirectFileView) {
      _includeOriginal = true;
    }
  }

  Future<Uint8List> _generatePdf(PdfPageFormat format) async {
    final t = AppLocalizations.of(context)!;
    final pdf = pw.Document();

    // Load fonts safely
    pw.Font font;
    pw.Font boldFont;
    pw.Font monoFont;

    try {
      font = await PdfGoogleFonts.openSansRegular();
      boldFont = await PdfGoogleFonts.openSansBold();
      monoFont = await PdfGoogleFonts.robotoMonoRegular();
    } catch (e) {
      debugPrint('Error loading Google Fonts: $e');
      font = pw.Font.helvetica();
      boldFont = pw.Font.helveticaBold();
      monoFont = pw.Font.courier();
    }

    // 1. Chat Section (Only if NOT direct file view)
    if (!_isDirectFileView) {
      pdf.addPage(
        pw.MultiPage(
          maxPages: 2000,
          pageFormat: format,
          build: (pw.Context context) {
            return [
              pw.Header(
                level: 0,
                child: pw.Text('${t.aiAssistant} - ${widget.fileName}',
                    style: pw.TextStyle(font: boldFont, fontSize: 24)),
              ),
              pw.SizedBox(height: 20),
              ...widget.messages.reversed.map((msg) {
                final isUser = msg['role'] == 'user';
                final prefix = isUser ? 'You: ' : 'AI: ';
                return pw.Container(
                    margin: const pw.EdgeInsets.only(bottom: 10),
                    child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text(prefix,
                              style: pw.TextStyle(
                                  font: boldFont,
                                  fontSize: 12,
                                  color: PdfColors.grey700)),
                          pw.Text(msg['text']!,
                              style: pw.TextStyle(font: font, fontSize: 12)),
                        ]));
              }),
            ];
          },
        ),
      );
    }

    // 2. Original File Section (if requested or direct view)
    if (_includeOriginal) { 
      pdf.addPage(
        pw.MultiPage(
          maxPages: 2000,
          pageFormat: format,
          build: (pw.Context context) {
            return [
              pw.Header(
                level: 0,
                child: pw.Text(
                    _isDirectFileView 
                       ? widget.fileName
                       : t.analyzedFile(widget.fileName),
                    style: pw.TextStyle(font: boldFont, fontSize: 24)),
              ),
              pw.SizedBox(height: 12),
              
              // If CSV, render as table
              if (_isCsvFile)
                pw.Table.fromTextArray(
                  context: context,
                  data: widget.csvData!,
                  headerStyle: pw.TextStyle(
                    font: boldFont,
                    fontSize: 9,
                    color: PdfColors.white,
                  ),
                  headerDecoration: const pw.BoxDecoration(
                    color: PdfColors.grey800,
                  ),
                  cellStyle: pw.TextStyle(font: font, fontSize: 8),
                  cellAlignment: pw.Alignment.centerLeft,
                  cellPadding: const pw.EdgeInsets.all(4),
                  border: pw.TableBorder.all(color: PdfColors.grey400, width: 0.5),
                  oddRowDecoration: const pw.BoxDecoration(
                    color: PdfColors.grey100,
                  ),
                )
              else
                pw.Paragraph(
                  text: widget.content,
                  style: pw.TextStyle(font: monoFont, fontSize: 10),
                ),
            ];
          },
        ),
      );
    }

    return pdf.save();
  }

  void _printPdf() async {
    final bytes = await _generatePdf(PdfPageFormat.a4);
    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => bytes,
        name: '${widget.fileName}_report.pdf');
  }

  void _sharePdf() async {
    final bytes = await _generatePdf(PdfPageFormat.a4);
    await Printing.sharePdf(
        bytes: bytes, filename: '${widget.fileName}_report.pdf');
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(t.exportPdf), 
      ),
      body: PdfPreview(
        key: _previewKey,
        build: (format) => _generatePdf(format),
        allowPrinting: false, 
        allowSharing: false, 
        canChangeOrientation: false,
        canChangePageFormat: false,
        actions: [], 
      ),
      bottomNavigationBar: Container(
        color: const Color(0xFF1E1E1E), 
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.print, color: Colors.white),
                iconSize: 28,
                onPressed: _printPdf, 
              ),
              IconButton(
                icon: const Icon(Icons.share, color: Colors.white),
                 iconSize: 28,
                onPressed: _sharePdf, 
              ),
               
              // Toggle for "Include Original". Hide if direct view (implied true always)
              if (!_isDirectFileView)
                Row(
                  children: [
                    Text(t.includeOriginal, style: const TextStyle(color: Colors.white70, fontSize: 12)),
                    Switch(
                      value: _includeOriginal,
                      onChanged: (val) {
                        setState(() {
                          _includeOriginal = val;
                          _previewKey = UniqueKey(); // Force rebuild
                        });
                      },
                      activeColor: Theme.of(context).colorScheme.primary,
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
