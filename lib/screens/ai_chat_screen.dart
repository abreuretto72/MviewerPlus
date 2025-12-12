import 'package:file_viewer/screens/pdf_viewer_screen.dart';
import 'package:file_viewer/services/ai_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:file_viewer/l10n/app_localizations.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
 


class AiChatScreen extends StatefulWidget {
  final String fileName;
  final String fileType;
  final String content;

  const AiChatScreen({
    super.key,
    required this.fileName,
    required this.fileType,
    required this.content,
  });

  @override
  State<AiChatScreen> createState() => _AiChatScreenState();
}

class _AiChatScreenState extends State<AiChatScreen> {
  final AiService _aiService = AiService();
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<Map<String, String>> _messages = []; // {'role': 'user'|'model', 'text': '...'}
  bool _isLoading = false;
  String? _initWarning;
  String _selectedLanguage = 'Português (Brasil)'; // Default to Portuguese for this user

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Initialize language based on app locale if not already manually set (though state persists in widget lifetime)
    if (_messages.isEmpty && !_isLoading) {
       final locale = Localizations.localeOf(context);
       if (locale.languageCode == 'pt') {
         _selectedLanguage = 'Português (${locale.countryCode == 'PT' ? 'Portugal' : 'Brasil'})';
       } else if (locale.languageCode == 'es') {
         _selectedLanguage = 'Español';
       } else {
         _selectedLanguage = 'English';
       }
       // Initial chat message needs context for localization, so we call it here
       _initializeChat();
    }
  }

  void _initializeChat() {
    // Only init if not already loaded or loading (handled by didChangeDependencies check)
    // But we need to allow re-init on language change.
    // Separating logic:
    
    final t = AppLocalizations.of(context)!;
    setState(() => _isLoading = true);

    Future.microtask(() {
      final warning = _aiService.initChatWithFile(
        widget.fileName,
        widget.fileType,
        widget.content,
        language: _selectedLanguage,
      );
      
      if (!mounted) return;

      setState(() {
        _isLoading = false;
        
        // Prepare localized warning if applicable
        String? displayWarning;
        if (warning != null) {
          if (warning.contains('File is too large')) {
             displayWarning = t.fileTooLarge;
          } else {
             displayWarning = warning; 
          }
        }

        if (displayWarning != null) {
          _initWarning = displayWarning;
          _messages.insert(0, {
            'role': 'model',
            'text': '⚠️ ${t.systemNote}: $displayWarning\n\n${t.analyzedFile(widget.fileName)}'
          });
        } else {
           _messages.insert(0, {
            'role': 'model',
            'text': t.analyzedFile(widget.fileName)
          });
        }
      });
    });
  }

  Future<void> _handleSend() async {
    final text = _textController.text.trim();
    if (text.isEmpty) return;

    _textController.clear();
    setState(() {
      _messages.insert(0, {'role': 'user', 'text': text});
      _isLoading = true;
    });
    _scrollToBottom();

    final response = await _aiService.sendMessage(text);

    if (!mounted) return;
    setState(() {
      _messages.insert(0, {'role': 'model', 'text': response});
      _isLoading = false;
    });
    _scrollToBottom();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          0, 
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<void> _copyMessage(String text) async {
    await Clipboard.setData(ClipboardData(text: text));
    if (mounted) {
       final t = AppLocalizations.of(context)!;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(t.copyMessage)),
      );
    }
  }



  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Icon(Icons.auto_awesome, color: Color(0xFF00E5FF)),
            const SizedBox(width: 8),
            Expanded( // Use Expanded to allow text to take remaining space but not overflow
              child: Text(
                t.aiAssistant,
                style: GoogleFonts.outfit(fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis, // Add ellipsis for long titles
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.picture_as_pdf),
            tooltip: t.exportPdf,
            onPressed: () {
               Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PdfViewerScreen(
                    fileName: widget.fileName,
                    content: widget.content,
                    messages: _messages,
                  ),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.info_outline),
            tooltip: t.getApiKeyHelpBtn,
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text(t.getApiKeyDialogTitle),
                  content: SingleChildScrollView(
                    child: Text(t.getApiKeyDialogContent),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(t.close),
                    ),
                  ],
                ),
              );
            },
          ),

          const SizedBox(width: 8),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(color: Colors.white10, height: 1.0),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              reverse: true,
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                final isUser = msg['role'] == 'user';
                return _buildMessageBubble(msg['text']!, isUser);
              },
            ),
          ),
          if (_isLoading)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: LinearProgressIndicator(backgroundColor: Colors.transparent),
            ),
          _buildInputArea(t),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(String text, bool isUser) {
    return GestureDetector(
      onLongPress: () => _copyMessage(text),
      child: Align(
        alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(12),
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.85),
        decoration: BoxDecoration(
          color: isUser 
              ? Theme.of(context).colorScheme.primary.withOpacity(0.2) 
              : const Color(0xFF2A2A2A),
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: Radius.circular(isUser ? 16 : 4),
            bottomRight: Radius.circular(isUser ? 4 : 16),
          ),
          border: Border.all(
            color: isUser 
                ? Theme.of(context).colorScheme.primary.withOpacity(0.5) 
                : Colors.white10,
          ),
        ),
        child: isUser
            ? Text(text, style: const TextStyle(fontSize: 16))
            : MarkdownBody(
                data: text,
                styleSheet: MarkdownStyleSheet(
                  p: const TextStyle(fontSize: 15, height: 1.5),
                  code: GoogleFonts.firaCode(
                    backgroundColor: Colors.black26, 
                    fontSize: 13,
                  ),
                  codeblockDecoration: BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.white10),
                  ),
                ),
              ),
      ),
    ),
    );
  }

  Widget _buildInputArea(AppLocalizations t) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Color(0xFF1E1E1E),
        border: Border(top: BorderSide(color: Colors.white10)),
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _textController,
                onSubmitted: (_) => _handleSend(),
                decoration: InputDecoration(
                  hintText: t.askAboutFile,
                  filled: true,
                  fillColor: Colors.black26,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                ),
              ),
            ),
            const SizedBox(width: 8),
            IconButton.filled(
              onPressed: _isLoading ? null : _handleSend,
              icon: const Icon(Icons.send_rounded),
              style: IconButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }


}
