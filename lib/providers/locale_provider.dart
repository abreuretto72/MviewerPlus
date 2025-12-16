import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleProvider with ChangeNotifier {
  Locale? _locale = const Locale('en'); // Default to English

  Locale? get locale => _locale;

  LocaleProvider() {
    _loadLocale();
  }

  void _loadLocale() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? languageCode = prefs.getString('languageCode');
      final String? countryCode = prefs.getString('countryCode');
      
      if (languageCode != null) {
        _locale = Locale(languageCode, countryCode);
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error loading locale: $e');
    }
  }

  void setLocale(Locale locale) async {
    _locale = locale;
    notifyListeners();
    
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('languageCode', locale.languageCode);
      if (locale.countryCode != null) {
        await prefs.setString('countryCode', locale.countryCode!);
      } else {
        await prefs.remove('countryCode');
      }
    } catch (e) {
      debugPrint('Error saving locale: $e');
    }
  }

  void clearLocale() async {
    _locale = null;
    notifyListeners();
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('languageCode');
      await prefs.remove('countryCode');
    } catch (e) {
      debugPrint('Error clearing locale: $e');
    }
  }
}
