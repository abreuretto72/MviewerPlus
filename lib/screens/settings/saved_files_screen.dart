import 'dart:io';
import 'package:file_viewer/screens/viewer_screen.dart';
import 'package:file_viewer/utils/file_utils.dart';
import 'package:flutter/material.dart';
import 'package:file_viewer/l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SavedFilesScreen extends StatefulWidget {
  const SavedFilesScreen({super.key});

  @override
  State<SavedFilesScreen> createState() => _SavedFilesScreenState();
}

class _SavedFilesScreenState extends State<SavedFilesScreen> {
  List<String> _savedFiles = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSavedFiles();
  }

  Future<void> _loadSavedFiles() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      if (mounted) {
        setState(() {
          _savedFiles = prefs.getStringList('saved_files') ?? [];
          _isLoading = false;
        });
      }
    } catch (e) {
      debugPrint('Error loading saved files: $e');
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _removeFile(String path) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      if (mounted) {
        setState(() {
          _savedFiles.remove(path);
          prefs.setStringList('saved_files', _savedFiles);
        });
      }
    } catch (e) {
      debugPrint('Error removing saved file: $e');
    }
  }

  void _openFile(String path) {
    File file = File(path);
    if (!file.existsSync()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('File not found')),
      );
      _removeFile(path);
      return;
    }
    
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ViewerScreen(file: file),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          t.savedFiles,
          style: GoogleFonts.outfit(fontWeight: FontWeight.bold),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _savedFiles.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.save_outlined, size: 64, color: Colors.white24),
                      const SizedBox(height: 16),
                      Text(
                        t.noSavedFiles,
                        style: const TextStyle(color: Colors.white54),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _savedFiles.length,
                  itemBuilder: (context, index) {
                    final path = _savedFiles[index];
                    // Using reverse index to show newest first?
                    // Actually standard list logic:
                    final file = File(path);
                    final name = FileUtils.getFileName(file);
                    
                    return Card(
                      color: const Color(0xFF2A2A2A),
                      margin: const EdgeInsets.only(bottom: 8),
                      child: ListTile(
                        leading: const Icon(Icons.description, color: Colors.white70),
                        title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text(path, style: const TextStyle(fontSize: 10, color: Colors.white38)),
                        onTap: () => _openFile(path),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                          onPressed: () {
                             showDialog(
                               context: context,
                               builder: (ctx) => AlertDialog(
                                 title: Text(t.deleteTitle),
                                 content: Text(t.deleteContent),
                                 actions: [
                                   TextButton(
                                     onPressed: () => Navigator.pop(ctx),
                                     child: Text(t.cancel),
                                   ),
                                   FilledButton(
                                     style: FilledButton.styleFrom(backgroundColor: Colors.redAccent),
                                     onPressed: () {
                                       Navigator.pop(ctx);
                                       _removeFile(path);
                                     },
                                     child: Text(t.delete),
                                   ),
                                 ],
                               ),
                             );
                           },
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
