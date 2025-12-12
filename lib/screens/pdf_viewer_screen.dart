import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:file_viewer/l10n/app_localizations.dart';
import 'package:intl/intl.dart';

class PdfViewerScreen extends StatefulWidget {
  final String fileName;
  final String content;
  final List<Map<String, String>> messages;
  final bool isDirectFileView;
  final List<List<dynamic>>? csvData;
  final List<Map<String, dynamic>>? zipFiles;
  final int? fileSize;

  const PdfViewerScreen({
    super.key,
    required this.fileName,
    required this.content,
    this.messages = const [],
    this.isDirectFileView = false,
    this.csvData,
    this.zipFiles,
    this.fileSize,
  });

  @override
  State<PdfViewerScreen> createState() => _PdfViewerScreenState();
}

class _PdfViewerScreenState extends State<PdfViewerScreen> {
  bool _includeOriginal = false;
  late bool _isDirectFileView;
  late bool _isCsvFile;
  late bool _isZipFile;
  Key _previewKey = UniqueKey();

  @override
  void initState() {
    super.initState();
    _isDirectFileView = widget.isDirectFileView;
    _isCsvFile = widget.csvData != null && widget.csvData!.isNotEmpty;
    _isZipFile = widget.zipFiles != null && widget.zipFiles!.isNotEmpty;
    
    // If direct view, we MUST show original content (since there is no chat)
    if (_isDirectFileView) {
      _includeOriginal = true;
    }
    debugPrint('PDF Debug: isCsv=$_isCsvFile, isZip=$_isZipFile, zipFilesCount=${widget.zipFiles?.length}');
  }

  Future<Uint8List> _generatePdf(PdfPageFormat format) async {
    final pdf = pw.Document();
    final t = AppLocalizations.of(context)!;

    // Load fonts
    final pdfTheme = pw.ThemeData.withFont(
      base: await PdfGoogleFonts.openSansRegular(),
      bold: await PdfGoogleFonts.openSansBold(),
    );
    
    // Fallback fonts if Google Fonts fail
    pw.Font font = pdfTheme.defaultTextStyle!.font!;
    pw.Font boldFont = pdfTheme.defaultTextStyle!.fontBold!;
    pw.Font monoFont = pw.Font.courier();
    
    try {
      font = await PdfGoogleFonts.robotoRegular();
      boldFont = await PdfGoogleFonts.robotoBold();
      monoFont = await PdfGoogleFonts.robotoMonoRegular();
    } catch (e) {
      debugPrint('Error loading Google Fonts: $e');
      font = pw.Font.helvetica();
      boldFont = pw.Font.helveticaBold();
      // monoFont is already courier, no need to reassign
    }

    final now = DateTime.now();
    final formattedDate = DateFormat('dd/MM/yyyy HH:mm').format(now);

    String fileSizeStr = 'Unknown';
    if (widget.fileSize != null) {
      if (widget.fileSize! < 1024) {
        fileSizeStr = '${widget.fileSize} B';
      } else if (widget.fileSize! < 1024 * 1024) {
        fileSizeStr = '${(widget.fileSize! / 1024).toStringAsFixed(2)} KB';
      } else {
        fileSizeStr = '${(widget.fileSize! / (1024 * 1024)).toStringAsFixed(2)} MB';
      }
    }

    String recordCountStr = 'N/A';
    if (_isCsvFile) {
      recordCountStr = '${widget.csvData!.length} ${t.rows}';
    } else if (_isZipFile) {
      recordCountStr = '${widget.zipFiles!.length} ${t.files}';
    } else {
      recordCountStr = '${widget.content.split('\n').length} ${t.lines}';
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
      // Use landscape for CSV files
      final pageFormat = _isCsvFile ? PdfPageFormat.a4.landscape : format;

      pdf.addPage(
        pw.MultiPage(
          maxPages: 2000,
          pageFormat: pageFormat,
          header: (pw.Context context) {
            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(t.pdfReportTitle, style: pw.TextStyle(font: boldFont, fontSize: 14, color: PdfColors.blue900)),
                    pw.Text('${t.pdfGeneratedLabel} $formattedDate', style: pw.TextStyle(font: font, fontSize: 10, color: PdfColors.grey700)),
                  ],
                ),
                pw.Divider(color: PdfColors.grey400, thickness: 0.5),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Expanded(child: pw.Text('${t.pdfFileLabel} ${widget.fileName}', style: pw.TextStyle(font: boldFont, fontSize: 11))),
                    pw.Text('${t.pdfSizeLabel} $fileSizeStr', style: pw.TextStyle(font: font, fontSize: 10)),
                    pw.SizedBox(width: 16),
                    pw.Text('${t.pdfRecordsLabel} $recordCountStr', style: pw.TextStyle(font: font, fontSize: 10)),
                  ],
                ),
                pw.Divider(color: PdfColors.grey400, thickness: 0.5),
                pw.SizedBox(height: 10),
              ],
            );
          },
          footer: (pw.Context context) {
            return pw.Container(
              alignment: pw.Alignment.centerRight,
              margin: const pw.EdgeInsets.only(top: 10),
              child: pw.Text(
                '${t.pdfPage} ${context.pageNumber} ${t.pdfOf} ${context.pagesCount}',
                style: pw.TextStyle(font: font, fontSize: 10, color: PdfColors.grey600),
              ),
            );
          },
          build: (pw.Context context) {
            return [
              if (_isCsvFile)
                ..._buildCsvTable(widget.csvData!, font, boldFont, monoFont)
              else if (_isZipFile)
                _buildZipTable(widget.zipFiles!, font, boldFont, monoFont, t)
              else
                pw.Paragraph(
                  text: widget.content,
                  style: pw.TextStyle(
                    font: monoFont,
                    fontSize: 9,
                    color: PdfColors.black,
                    height: 1.4,
                  ),
                ),
            ];
          },
        ),
      );
    }

    return pdf.save();
  }

  // Build clean, readable CSV table with automatic splitting for wide tables
  List<pw.Widget> _buildCsvTable(List<List<dynamic>> csvData, pw.Font font, pw.Font boldFont, pw.Font monoFont) {
    if (csvData.isEmpty) {
      return [pw.Text('Empty CSV - No data provided')];
    }

    if (csvData.length == 1) {
      return [
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text('CSV has only headers, no data rows', style: pw.TextStyle(font: boldFont)),
            pw.SizedBox(height: 10),
            pw.Text('Headers: ${csvData.first.join(", ")}'),
          ],
        ),
      ];
    }

    final headers = csvData.first;
    final rows = csvData.skip(1).toList();
    
    debugPrint('PDF CSV Table - Headers: ${headers.length}, Rows: ${rows.length}');
    
    final columnCount = headers.length;
    
    // If table has many columns, split into multiple pages
    const int maxColumnsPerPage = 15;
    final bool needsSplitting = columnCount > maxColumnsPerPage;
    
    if (needsSplitting) {
      return _buildSplitCsvTable(csvData, headers, rows, font, boldFont, monoFont, maxColumnsPerPage);
    } else {
      return [_buildSingleCsvTable(headers, rows, 0, columnCount, font, boldFont, monoFont, null)];
    }
  }

  // Build split table across multiple pages
  List<pw.Widget> _buildSplitCsvTable(
    List<List<dynamic>> csvData,
    List<dynamic> headers,
    List<List<dynamic>> rows,
    pw.Font font,
    pw.Font boldFont,
    pw.Font monoFont,
    int maxColumnsPerPage,
  ) {
    final List<pw.Widget> pages = [];
    final columnCount = headers.length;
    
    // Calculate number of pages needed
    int currentColumn = 0;
    int pageNumber = 1;
    
    while (currentColumn < columnCount) {
      // Always include first column (usually ID/name) for context, except on first page
      final includeFirstColumn = currentColumn > 0;
      final startColumn = currentColumn;
      int endColumn = currentColumn + maxColumnsPerPage;
      
      if (endColumn > columnCount) {
        endColumn = columnCount;
      }
      
      // If including first column, reduce the range by 1
      if (includeFirstColumn && endColumn - startColumn >= maxColumnsPerPage) {
        endColumn--;
      }
      
      final totalPages = ((columnCount - 1) / maxColumnsPerPage).ceil() + (columnCount > maxColumnsPerPage ? 1 : 0);
      final pageInfo = 'Columns ${startColumn + 1}-$endColumn of $columnCount (Page $pageNumber of $totalPages)';
      
      pages.add(_buildSingleCsvTable(
        headers,
        rows,
        startColumn,
        endColumn,
        font,
        boldFont,
        monoFont,
        includeFirstColumn ? 0 : null,
        pageInfo: pageInfo,
      ));
      
      currentColumn = endColumn;
      pageNumber++;
      
      // Add page break between tables
      if (currentColumn < columnCount) {
        pages.add(pw.SizedBox(height: 20));
        pages.add(pw.Divider(thickness: 2, color: PdfColors.grey400));
        pages.add(pw.SizedBox(height: 20));
      }
    }
    
    return pages;
  }

  // Build a single table (or portion of a table)
  pw.Widget _buildSingleCsvTable(
    List<dynamic> allHeaders,
    List<List<dynamic>> allRows,
    int startColumn,
    int endColumn,
    pw.Font font,
    pw.Font boldFont,
    pw.Font monoFont,
    int? repeatColumn, {
    String? pageInfo,
  }) {
    // Extract column range
    List<dynamic> headers = [];
    if (repeatColumn != null && startColumn != repeatColumn) {
      headers.add(allHeaders[repeatColumn]);
    }
    headers.addAll(allHeaders.sublist(startColumn, endColumn));
    
    final columnCount = headers.length;
    
    // Adjust font size based on number of columns - more aggressive reduction
    double headerFontSize = 11;
    double cellFontSize = 10;
    double headerPadding = 10;
    double cellPadding = 8;
    
    if (columnCount > 20) {
      headerFontSize = 6;  // Reduced from 8
      cellFontSize = 5;    // Reduced from 7
      headerPadding = 2;   // Reduced from 5
      cellPadding = 2;     // Reduced from 4
    } else if (columnCount > 12) {
      headerFontSize = 7;  // Reduced from 8
      cellFontSize = 6;    // Reduced from 7
      headerPadding = 3;   // Reduced from 5
      cellPadding = 3;     // Reduced from 4
    } else if (columnCount > 8) {
      headerFontSize = 9;
      cellFontSize = 8;
      headerPadding = 6;
      cellPadding = 5;
    }
    
    final columnWidths = <int, pw.TableColumnWidth>{};
    
    // Give more width to first column if it's repeated
    for (int i = 0; i < columnCount; i++) {
      if (i == 0 && repeatColumn != null && startColumn != repeatColumn) {
        columnWidths[i] = const pw.FlexColumnWidth(1.5);
      } else {
        columnWidths[i] = const pw.FlexColumnWidth(1.0);
      }
    }

    // Build table manually with row limit to prevent overflow
    // Build table manually
    // Removed row limit to show all data
    final rowsToShow = allRows;
    
    final List<pw.TableRow> tableRows = [];
    
    // Header row
    tableRows.add(
      pw.TableRow(
        decoration: const pw.BoxDecoration(
          color: PdfColors.grey800,
        ),
        children: headers.map((header) {
          return pw.Container(
            padding: pw.EdgeInsets.all(headerPadding),
            child: pw.Text(
              header.toString(),
              style: pw.TextStyle(
                font: boldFont,
                fontSize: headerFontSize,
                color: PdfColors.white,
              ),
              maxLines: 1, // Reduced from 2 to 1
              overflow: pw.TextOverflow.clip,
            ),
          );
        }).toList(),
      ),
    );
    
    // Data rows (limited)
    for (int index = 0; index < rowsToShow.length; index++) {
      final row = rowsToShow[index];
      final isEven = index % 2 == 0;
      
      // Extract cells for this column range
      List<dynamic> cells = [];
      if (repeatColumn != null && startColumn != repeatColumn) {
        cells.add(row.length > repeatColumn ? row[repeatColumn] : '');
      }
      for (int i = startColumn; i < endColumn && i < row.length; i++) {
        cells.add(row[i]);
      }
      
      // Pad if necessary
      while (cells.length < columnCount) {
        cells.add('');
      }
      
      tableRows.add(
        pw.TableRow(
          decoration: pw.BoxDecoration(
            color: isEven ? PdfColors.white : PdfColors.grey100,
          ),
          children: cells.map((cell) {
            final cellValue = cell.toString();
            final isNumeric = double.tryParse(cellValue.replaceAll(',', '')) != null;
            
            return pw.Container(
              padding: pw.EdgeInsets.all(cellPadding),
              child: pw.Text(
                cellValue,
                style: pw.TextStyle(
                  font: isNumeric ? monoFont : font,
                  fontSize: cellFontSize,
                  color: cellValue.trim().isEmpty 
                      ? PdfColors.grey400 
                      : PdfColors.black,
                ),
                textAlign: isNumeric ? pw.TextAlign.right : pw.TextAlign.left,
                maxLines: 1, // Reduced from 2 to 1
                overflow: pw.TextOverflow.clip,
              ),
            );
          }).toList(),
        ),
      );
    }
    
    // Rows truncated warning removed

    return pw.Table(
      border: pw.TableBorder.all(
        color: PdfColors.grey600,
        width: 0.5,
      ),
      columnWidths: columnWidths,
      children: tableRows,
    );
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

  pw.Widget _buildZipTable(
    List<Map<String, dynamic>> files,
    pw.Font font,
    pw.Font boldFont,
    pw.Font monoFont,
    AppLocalizations t,
  ) {
    if (files.isEmpty) return pw.Text(t.zipEmpty);

    return pw.Table(
      border: pw.TableBorder.all(color: PdfColors.grey400, width: 0.5),
      columnWidths: {
        0: const pw.FlexColumnWidth(3),
        1: const pw.FlexColumnWidth(1),
        2: const pw.FlexColumnWidth(1),
      },
      children: [
        // Header
        pw.TableRow(
          decoration: const pw.BoxDecoration(color: PdfColors.grey200),
          children: [
            pw.Padding(padding: const pw.EdgeInsets.all(5), child: pw.Text(t.fileName, style: pw.TextStyle(font: boldFont))),
            pw.Padding(padding: const pw.EdgeInsets.all(5), child: pw.Text(t.fileType, style: pw.TextStyle(font: boldFont))),
            pw.Padding(padding: const pw.EdgeInsets.all(5), child: pw.Text(t.fileSizeCol, style: pw.TextStyle(font: boldFont))),
          ],
        ),
        // Rows
        ...files.map((file) {
          final isFile = file['isFile'] as bool;
          final size = (file['size'] as int) / 1024;
          return pw.TableRow(
            children: [
              pw.Padding(padding: const pw.EdgeInsets.all(5), child: pw.Text(file['name'] as String, style: pw.TextStyle(font: font, fontSize: 10))),
              pw.Padding(padding: const pw.EdgeInsets.all(5), child: pw.Text(isFile ? 'File' : 'Folder', style: pw.TextStyle(font: font, fontSize: 10))),
              pw.Padding(padding: const pw.EdgeInsets.all(5), child: pw.Text(isFile ? size.toStringAsFixed(1) : '-', style: pw.TextStyle(font: monoFont, fontSize: 10), textAlign: pw.TextAlign.right)),
            ],
          );
        }).toList(),
      ],
    );
  }
}
