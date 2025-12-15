import 'package:flutter/foundation.dart';

/// Utilitário para logging no modo debug
class CookieLogger {
  static void log(String message) {
    if (kDebugMode) {
      debugPrint('[CookieInspector] $message');
    }
  }

  static void error(String message, [Object? error]) {
    if (kDebugMode) {
      debugPrint('[CookieInspector ERROR] $message${error != null ? ': $error' : ''}');
    }
  }

  static void warning(String message) {
    if (kDebugMode) {
      debugPrint('[CookieInspector WARNING] $message');
    }
  }
}
