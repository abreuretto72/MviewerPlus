import 'dart:io';
import 'package:csv/csv.dart';
import 'package:path/path.dart' as p;

class FileUtils {
  static String getFileName(File file) {
    return p.basename(file.path);
  }

  static String getFileExtension(File file) {
    return p.extension(file.path).toLowerCase().replaceAll('.', '');
  }

  static Future<String> readFileContent(File file) async {
    // Try reading as UTF-8 first, handle potential encoding issues if needed
    // For now we assume mostly text files
    return await file.readAsString();
  }

  static Future<List<List<dynamic>>> parseCsv(String content) async {
    // Basic CSV parsing
    // Check if it uses comma or semicolon
    String delimiter = ',';
    if (content.contains(';') && content.split(';').length > content.split(',').length) {
      delimiter = ';';
    }
    
    return const CsvToListConverter().convert(content, fieldDelimiter: delimiter);
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

enum FileType {
  text,
  code,
  table,
}
