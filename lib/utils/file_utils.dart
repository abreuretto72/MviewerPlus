import 'dart:convert';
import 'dart:io';
import 'package:csv/csv.dart';
import 'package:spreadsheet_decoder/spreadsheet_decoder.dart';
import 'package:archive/archive.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as p;

class FileUtils {
  static String getFileName(File file) {
    return p.basename(file.path);
  }

  static String getFileExtension(File file) {
    return p.extension(file.path).toLowerCase().replaceAll('.', '');
  }

  static Future<String> readFileContent(File file) async {
    try {
      // Try reading as UTF-8 first
      return await file.readAsString();
    } catch (e) {
      // If it fails (likely encoding), try Latin1 (ISO-8859-1)
      try {
        return await file.readAsString(encoding: latin1);
      } catch (e2) {
        // If that also fails, rethrow the original or a generic error
        throw 'Failed to read file. Unknown encoding or binary file.';
      }
    }
  }

  static Future<List<List<dynamic>>> parseCsv(String content) async {
    // Parse CSV in background to avoid blocking UI
    return await compute(_parseCsvInBackground, content);
  }

  static Future<Map<String, List<List<dynamic>>>> parseExcel(File file) async {
    // Parse Excel in background
    final bytes = await file.readAsBytes();
    return await compute(_parseExcelInBackground, bytes);
  }

  static Future<List<Map<String, dynamic>>> parseZip(File file) async {
    final bytes = await file.readAsBytes();
    return await compute(_parseZipInBackground, bytes);
  }

  static FileType getFileType(String extension) {
    switch (extension) {
      // Data formats
      case 'json':
      case 'xml':
      case 'yaml':
      case 'yml':
      case 'ascx': // ASP.NET User Control
      case 'aspx': // ASP.NET Web Form  
      case 'asmx': // ASP.NET Web Service
      case 'doc':
      case 'docx': // Microsoft Word documents
        return FileType.code;
      
      // Database
      case 'sql':
        return FileType.code;
      
      // Email
      case 'eml': // Email message (MIME format)
        return FileType.code;
      
      // Web
      case 'html':
      case 'htm':
      case 'css':
      case 'scss':
      case 'sass':
      case 'less':
      case 'js':
      case 'jsx':
      case 'ts':
      case 'tsx':
        return FileType.code;
      
      // Mobile/App Development
      case 'dart':
      case 'java':
      case 'kt':
      case 'kts':
      case 'swift':
        return FileType.code;
      
      // Systems Programming
      case 'c':
      case 'cpp':
      case 'cc':
      case 'cxx':
      case 'h':
      case 'hpp':
      case 'cs':
      case 'go':
      case 'rs':
        return FileType.code;
      
      // Scripting
      case 'py':
      case 'rb':
      case 'php':
      case 'pl':
      case 'sh':
      case 'bash':
      case 'ps1':
        return FileType.code;
      
      // Other programming languages
      case 'r':
      case 'scala':
      case 'lua':
      case 'vim':
      case 'el':
      case 'clj':
      case 'ex':
      case 'exs':
        return FileType.code;
      
      // Markup
      case 'md':
      case 'markdown':
        return FileType.markdown;
      
      // Table
      case 'csv':
      case 'xlsx':
      case 'xls':
        return FileType.table;
      
      // Archive
      case 'zip':
      case 'apk':
      case 'jar':
        return FileType.archive;

      case 'pdf':
        return FileType.pdf;
      
      // Audio
      case 'mp3':
      case 'wav':
      case 'ogg':
      case 'm4a':
      case 'aac':
      case 'flac':
        return FileType.audio;

      // Video
      case 'mp4':
      case 'mov':
      case 'avi':
      case 'mkv':
      case 'webm':
      case 'wmv':
      case 'flv':
      case '3gp':
      case 'm4v':
        return FileType.video;

      // Images
      case 'png':
      case 'jpg':
      case 'jpeg':
      case 'gif':
      case 'webp':
      case 'bmp':
        return FileType.image;

      // Configuration files (now with syntax highlighting)
      case 'conf':
      case 'config':
      case 'env':
      case 'ini':
      case 'cfg':
      case 'properties':
      case 'toml':
        return FileType.code;
      
      // Log files (now with syntax highlighting)
      case 'log':
        return FileType.code;
      
      // Plain text
      case 'txt':
        return FileType.text;
      
      default:
        return FileType.text;
    }
  }
}

// Top-level function for compute (must be outside class)
List<List<dynamic>> _parseCsvInBackground(String content) {
  // Optimize delimiter detection - only check first 5 lines instead of entire file
  String delimiter = ',';
  
  // Get first few lines for delimiter detection (much faster than splitting entire content)
  final lines = content.split('\n').take(5).join('\n');
  
  // Count occurrences in sample
  final commaCount = ','.allMatches(lines).length;
  final semicolonCount = ';'.allMatches(lines).length;
  
  if (semicolonCount > commaCount) {
    delimiter = ';';
  }
  
  // Parse CSV with proper handling of quoted fields
  List<List<dynamic>> rawData;
  try {
    // Use convertSyncAllowMalformed for better handling of complex CSVs
    rawData = const CsvToListConverter(
      shouldParseNumbers: false, // Keep everything as strings initially
      allowInvalid: true,        // Don't fail on malformed rows
    ).convert(
      content, 
      fieldDelimiter: delimiter,
      textDelimiter: '"',
      textEndDelimiter: '"',
      eol: '\n',
    );
    
    debugPrint('CSV Parser: Successfully parsed ${rawData.length} rows');
    if (rawData.isNotEmpty) {
      debugPrint('CSV Parser: First row has ${rawData.first.length} columns');
      if (rawData.length > 1) {
        debugPrint('CSV Parser: Second row has ${rawData[1].length} columns');
      }
    }
  } catch (e) {
    debugPrint('CSV Parser Error: $e');
    // Fallback: try with default settings
    try {
      rawData = const CsvToListConverter().convert(content);
      debugPrint('CSV Parser: Fallback parsing succeeded - ${rawData.length} rows');
    } catch (e2) {
      debugPrint('CSV Parser Fallback Error: $e2');
      // Last resort: return empty
      return [];
    }
  }
  
  if (rawData.isEmpty) return rawData;
  
  // STEP 1: Remove completely empty rows
  rawData = rawData.where((row) {
    return row.any((cell) => cell.toString().trim().isNotEmpty);
  }).toList();
  
  if (rawData.isEmpty) return rawData;
  
  // STEP 2: Find the header row (first row with substantial data)
  // Reduced from 3 to 2 cells to be less aggressive
  int headerIndex = 0;
  for (int i = 0; i < rawData.length; i++) {
    final nonEmptyCells = rawData[i].where((cell) => cell.toString().trim().isNotEmpty).length;
    if (nonEmptyCells >= 2) { // Changed from 3 to 2
      headerIndex = i;
      break;
    }
  }
  
  // Remove junk rows before header
  if (headerIndex > 0) {
    rawData = rawData.sublist(headerIndex);
  }
  
  if (rawData.isEmpty) return rawData;
  
  // STEP 3: Identify and remove ONLY completely empty columns
  final maxColumns = rawData.map((row) => row.length).reduce((a, b) => a > b ? a : b);
  
  // Check which columns have at least one non-empty value across ALL rows
  List<bool> columnHasData = List.filled(maxColumns, false);
  
  for (var row in rawData) {
    for (int i = 0; i < row.length && i < maxColumns; i++) {
      if (row[i].toString().trim().isNotEmpty) {
        columnHasData[i] = true;
      }
    }
  }
  
  // Get indices of columns that have at least some data
  List<int> validColumnIndices = [];
  for (int i = 0; i < columnHasData.length; i++) {
    if (columnHasData[i]) {
      validColumnIndices.add(i);
    }
  }
  
  // If no valid columns found, return original data (don't remove anything)
  if (validColumnIndices.isEmpty) {
    debugPrint('CSV Parser: No valid columns found, returning original data');
    return rawData;
  }
  
  // STEP 4: Rebuild data with only valid columns
  List<List<dynamic>> cleanedData = [];
  for (var row in rawData) {
    List<dynamic> cleanedRow = [];
    for (int colIndex in validColumnIndices) {
      if (colIndex < row.length) {
        cleanedRow.add(row[colIndex]);
      } else {
        cleanedRow.add(''); // Pad with empty if row is shorter
      }
    }
    cleanedData.add(cleanedRow);
  }
  
  // STEP 5: Remove trailing empty rows (footer junk) - but keep at least 1 data row
  while (cleanedData.length > 2) { // Changed from 1 to 2 to keep at least header + 1 row
    final lastRow = cleanedData.last;
    final hasData = lastRow.any((cell) => cell.toString().trim().isNotEmpty);
    if (!hasData) {
      cleanedData.removeLast();
    } else {
      break;
    }
  }
  
  debugPrint('CSV Parser: Final data - ${cleanedData.length} rows, ${cleanedData.isNotEmpty ? cleanedData.first.length : 0} columns');
  
  return cleanedData;
}

Map<String, List<List<dynamic>>> _parseExcelInBackground(List<int> bytes) {
  try {
    var decoder = SpreadsheetDecoder.decodeBytes(bytes, update: true);
    Map<String, List<List<dynamic>>> sheets = {};
    
    for (var tableName in decoder.tables.keys) {
      var table = decoder.tables[tableName];
      if (table != null) {
        List<List<dynamic>> rows = [];
        for (var row in table.rows) {
           rows.add(row.map((cell) => cell?.toString() ?? '').toList());
        }
        sheets[tableName] = rows;
      }
    }
    
    return sheets;
  } catch (e) {
    debugPrint('Excel parsing error: $e');
    return {};
  }
}

List<Map<String, dynamic>> _parseZipInBackground(List<int> bytes) {
  try {
     final archive = ZipDecoder().decodeBytes(bytes);
     return archive.files.map((file) => {
       'name': file.name,
       'size': file.size,
       'isFile': file.isFile,
     }).toList();
  } catch (e) {
     debugPrint('Zip parsing error: $e');
     return [];
  }
}

enum FileType {
  text,
  code,
  table,
  markdown,
  archive,
  image,
  pdf,
  audio,
  video,
}
