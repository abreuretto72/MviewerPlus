import 'dart:convert';
import 'dart:io';
import 'package:csv/csv.dart';
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

  static FileType getFileType(String extension) {
    switch (extension) {
      case 'json':
      case 'xml':
      case 'sql':
      case 'yaml':
      case 'yml':
      case 'dart':
      case 'js':
      case 'html':
      case 'css':
      case 'py':
        return FileType.code;
      case 'csv':
        return FileType.table;
      case 'txt':
      case 'log':
      case 'conf':
      case 'env':
      case 'ini':
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
  
  // Parse CSV
  List<List<dynamic>> rawData = const CsvToListConverter().convert(content, fieldDelimiter: delimiter);
  
  if (rawData.isEmpty) return rawData;
  
  // STEP 1: Remove completely empty rows
  rawData = rawData.where((row) {
    return row.any((cell) => cell.toString().trim().isNotEmpty);
  }).toList();
  
  if (rawData.isEmpty) return rawData;
  
  // STEP 2: Find the header row (first row with substantial data)
  int headerIndex = 0;
  for (int i = 0; i < rawData.length; i++) {
    final nonEmptyCells = rawData[i].where((cell) => cell.toString().trim().isNotEmpty).length;
    if (nonEmptyCells >= 3) { // At least 3 non-empty cells to be considered a header
      headerIndex = i;
      break;
    }
  }
  
  // Remove junk rows before header
  if (headerIndex > 0) {
    rawData = rawData.sublist(headerIndex);
  }
  
  if (rawData.isEmpty) return rawData;
  
  // STEP 3: Identify and remove empty columns
  final maxColumns = rawData.map((row) => row.length).reduce((a, b) => a > b ? a : b);
  
  // Check which columns have at least one non-empty value
  List<bool> columnHasData = List.filled(maxColumns, false);
  
  for (var row in rawData) {
    for (int i = 0; i < row.length && i < maxColumns; i++) {
      if (row[i].toString().trim().isNotEmpty) {
        columnHasData[i] = true;
      }
    }
  }
  
  // Get indices of columns that have data
  List<int> validColumnIndices = [];
  for (int i = 0; i < columnHasData.length; i++) {
    if (columnHasData[i]) {
      validColumnIndices.add(i);
    }
  }
  
  // If no valid columns found, return original data
  if (validColumnIndices.isEmpty) return rawData;
  
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
  
  // STEP 5: Remove trailing empty rows (footer junk)
  while (cleanedData.length > 1) {
    final lastRow = cleanedData.last;
    final hasData = lastRow.any((cell) => cell.toString().trim().isNotEmpty);
    if (!hasData) {
      cleanedData.removeLast();
    } else {
      break;
    }
  }
  
  return cleanedData;
}

enum FileType {
  text,
  code,
  table,
}
