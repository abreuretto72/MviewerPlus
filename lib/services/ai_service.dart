import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AiService {
  // Using Llama 3 70b for high quality free inference on Groq
  static const String _model = 'llama-3.3-70b-versatile'; 
  static const String _baseUrl = 'https://api.groq.com/openai/v1/chat/completions';
  
  // Limit for context to avoid hitting token limits (Groq has generous limits but good to be safe)
  static const int _maxCharCount = 120000; 

  final List<Map<String, dynamic>> _history = [];
  String? _systemPrompt;

  // Method to get instructions on how to obtain an API key
  static String getApiKeyInstructions() {
    return '''
To get your free Groq API Key:
1. Go to https://console.groq.com/keys
2. Sign up or Log in.
3. Click "Create API Key".
4. Copy the key (starts with 'gsk_').
''';
  }

  /// Initializes the chat with the file content as context.
  /// Returns a warning message if the file was truncated, null otherwise.
  String? initChatWithFile(String fileName, String fileType, String content, {String language = 'English'}) {
    String? warning;
    String processedContent = content;

    if (content.length > _maxCharCount) {
      processedContent = content.substring(0, _maxCharCount);
      warning = 'File is too large. Content has truncated for analysis.';
    }

    _systemPrompt = '''
You are an intelligent File Assistant integrated into MviewerPlus.
Your task is to analyze the content of the file provided below and help the user with their questions.
IMPORTANT: You must output your responses in $language.

File Name: $fileName
File Type: $fileType

Analysis Guidelines:
- CSV: Perform calculations (average, sum), identify outliers, answer about specific rows/columns.
- JSON/XML: Navigate structure, find specific keys/values, summarize hierarchy.
- Logs/Txt: Identify error patterns, warnings, summarize events, check timestamps.
- Code (SQL, Dart, etc): Explain logic, describe queries or configuration structures.

Be concise, helpful, and professional.

--- FILE CONTENT START ---
$processedContent
--- FILE CONTENT END ---
''';
    
    _history.clear();


    // Verification moved to sendMessage to support async SharedPreferences
    return warning;
  }

  Future<String> _getApiKey() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final customKey = prefs.getString('custom_groq_api_key');
      if (customKey != null && customKey.isNotEmpty) {
        return customKey;
      }
    } catch (e) {
      // Return env key or empty if prefs fails
    }
    return dotenv.env['GROQ_API_KEY'] ?? '';
  }

  Future<String> sendMessage(String message) async {
    final apiKey = await _getApiKey();
    if (apiKey.isEmpty) {
      return 'Error: API Key is missing. Please configure it in Settings.';
    }

    _history.add({'role': 'user', 'content': message});

    final messagesPayload = [
      if (_systemPrompt != null) {'role': 'system', 'content': _systemPrompt},
      ..._history
    ];

    try {
      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {
          'Authorization': 'Bearer $apiKey',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'model': _model,
          'messages': messagesPayload,
          'temperature': 0.7,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(utf8.decode(response.bodyBytes));
        final content = data['choices'][0]['message']['content'] as String;
        
        _history.add({'role': 'assistant', 'content': content});
        return content;
      } else {
        return 'Error ${response.statusCode}: ${response.body}';
      }
    } catch (e) {
      return 'Error communicating with AI: $e';
    }
  }
}
