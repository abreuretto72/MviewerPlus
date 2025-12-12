import 'dart:io';

import 'package:flutter/foundation.dart';

import 'package:file_viewer/screens/ai_chat_screen.dart';
import 'package:file_viewer/screens/pdf_viewer_screen.dart';
import 'package:file_viewer/utils/file_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/dracula.dart';
import 'package:flutter_highlight/themes/github.dart';
import 'package:file_viewer/l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ViewerScreen extends StatefulWidget {
  final File file;

  const ViewerScreen({super.key, required this.file});

  @override
  State<ViewerScreen> createState() => _ViewerScreenState();
}

class _ViewerScreenState extends State<ViewerScreen> {
  String _content = '';
  List<List<dynamic>> _csvData = [];
  bool _isLoading = true;
  String? _error;
  bool _isRaw = false; // Toggle for Raw vs Formatted
  late String _extension;
  late FileType _fileType;

  // Search
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  // Edit
  bool _isEditing = false;
  final TextEditingController _editController = TextEditingController();
  final TextEditingController _replaceController = TextEditingController();

  // CSV Sorting
  int? _sortColumnIndex;
  bool _sortAscending = true;
  
  // Horizontal scroll synchronization for CSV table
  final ScrollController _horizontalScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _loadContent();
  }

  Future<void> _loadContent() async {
    try {
      _extension = FileUtils.getFileExtension(widget.file);
      _fileType = FileUtils.getFileType(_extension);
      
      final content = await FileUtils.readFileContent(widget.file);
      
      if (_fileType == FileType.table) {
        // Parse CSV in background isolate to keep UI responsive
        _csvData = await FileUtils.parseCsv(content);
        
        // Update state with row count info
        if (mounted) {
          setState(() {
            _content = content;
            _isLoading = false;
          });
        }
      } else {
        if (mounted) {
          setState(() {
            _content = content;
            _isLoading = false;
          });
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString();
          _isLoading = false;
        });
      }
    }
  }

  void _onSort(int columnIndex, bool ascending) {
    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending;
      
      // Skip header
      final header = _csvData.first;
      final rows = _csvData.skip(1).toList();
      
      rows.sort((a, b) {
        if (columnIndex >= a.length || columnIndex >= b.length) return 0;
        final cellA = a[columnIndex].toString();
        final cellB = b[columnIndex].toString();
        return ascending ? cellA.compareTo(cellB) : cellB.compareTo(cellA);
      });
      
      _csvData = [header, ...rows];
    });
  }

  void _toggleEdit() {
    setState(() {
      _isEditing = !_isEditing;
      if (_isEditing) {
        _editController.text = _content;
      } else {
        _content = _editController.text;
        // Re-parsing CSV if it was CSV would be nice but let's stick to text update for now
        // Or disable CSV view if edited in Text mode
      }
    });
  }

  void _saveContent() async {
    try {
      if (_isEditing) {
        _content = _editController.text;
      }
      
      final t = AppLocalizations.of(context)!;
      final confirmed = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(t.saveChangesTitle),
          content: Text(t.saveChangesContent),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text(t.cancel),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text(t.save),
            ),
          ],
        ),
      );

      if (confirmed != true) {
         // Reset editing state if cancelled? Or just return?
         // User might want to continue editing.
         return; 
      }
      
      _isEditing = false;
      
      // Create new filename: name_YYYYMMDD_HHMMSS.ext
      final name = FileUtils.getFileName(widget.file);
      final ext = FileUtils.getFileExtension(widget.file);
      
      String baseName = name;
      if (name.toLowerCase().endsWith('.$ext')) {
         baseName = name.substring(0, name.length - (ext.length + 1));
      }
      
      final timestamp = DateFormat('yyyyMMdd_HHmmss').format(DateTime.now());
      final newName = '${baseName}_$timestamp.$ext';
      
      // Try to save to Public Downloads folder
      String newPath;
      if (Platform.isAndroid) {
         newPath = '/storage/emulated/0/Download/$newName';
      } else {
         // Fallback for other platforms (e.g. Windows) to same directory or specialized logic
         // For now, let's try same directory if not Android, or a known Downloads path
         newPath = '${widget.file.parent.path}${Platform.pathSeparator}$newName';
      }

      final newFile = File(newPath);
      
      // Ensure directory exists (mostly for non-standard paths)
      if (!await newFile.parent.exists()) {
        try {
           await newFile.parent.create(recursive: true);
        } catch (_) {
           // Fallback to local app storage parent if public fails permissions
           newPath = '${widget.file.parent.path}${Platform.pathSeparator}$newName';
        }
      }

      try {
         await newFile.writeAsString(_content);
      } catch (e) {
         // Fallback if permission denied
         debugPrint('Failed to write to primary target: $e');
         newPath = '${widget.file.parent.path}${Platform.pathSeparator}$newName';
         await File(newPath).writeAsString(_content);
      }
      
      // Save path to history
      final prefs = await SharedPreferences.getInstance();
      final savedFiles = prefs.getStringList('saved_files') ?? [];
      if (!savedFiles.contains(newPath)) {
        savedFiles.add(newPath);
        await prefs.setStringList('saved_files', savedFiles);
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(t.saveCopySuccess(newPath))),
      );
      setState(() {});
    } catch (e) {
       ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving: $e')),
      );
    }
  }

  void _toggleView() {
    setState(() {
      _isRaw = !_isRaw;
    });
  }

  Future<void> _copyContent() async {
    await Clipboard.setData(ClipboardData(text: _content));
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(AppLocalizations.of(context)!.copiedToClipboard)),
    );
  }

  void _performReplaceAll(AppLocalizations t) {
     final find = _searchController.text;
     final replace = _replaceController.text;
     
     if (find.isEmpty) return;

     int count = find.allMatches(_content).length;
     if (count == 0) return;

     final newContent = _content.replaceAll(find, replace);
     
     setState(() {
       _content = newContent;
       // If CSV, re-parse is expensive but necessary if we want to show updated table.
       // Or force Raw view if modified?
       // Let's re-parse simply or warn.
       // Actually content update implies we might need to update _csvData if it's Table view.
     });

     // If it's a table, we should re-parse CSV to reflect changes in grid
     if (_fileType == FileType.table) {
       FileUtils.parseCsv(_content).then((data) {
          if (mounted) setState(() => _csvData = data);
       });
     }
     
     // Mark as editing/modified so user knows to save? 
     // Or just set _isEditing = true?
     // If we set _isEditing = true, the content is in _editController.
     _editController.text = newContent;
     
     ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(t.replacedSuccess(count))),
     );
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: _isSearching
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   SizedBox(
                     height: 36,
                     child: TextField(
                        controller: _searchController,
                        autofocus: true,
                        style: const TextStyle(color: Colors.white, fontSize: 13),
                        decoration: InputDecoration(
                          hintText: t.find,
                          hintStyle: const TextStyle(color: Colors.white54),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                          filled: true,
                          fillColor: Colors.white12,
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
                        ),
                        onChanged: (value) => setState(() => _searchQuery = value),
                      ),
                   ),
                   const SizedBox(height: 4),
                   SizedBox(
                     height: 36,
                     child: TextField(
                        controller: _replaceController,
                        style: const TextStyle(color: Colors.white, fontSize: 13),
                        decoration: InputDecoration(
                          hintText: t.replace,
                          hintStyle: const TextStyle(color: Colors.white54),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                          filled: true,
                          fillColor: Colors.white12,
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.published_with_changes, size: 16),
                            onPressed: () => _performReplaceAll(t),
                            tooltip: t.replaceAll,
                          )
                        ),
                      ),
                   ),
                ]
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    FileUtils.getFileName(widget.file),
                    style: const TextStyle(fontSize: 16),
                  ),
                  Text(
                    _extension.toUpperCase(),
                    style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
        toolbarHeight: _isSearching ? 100 : kToolbarHeight,
        actions: [
          if (_isEditing || (_isSearching && _replaceController.text.isNotEmpty)) 
             IconButton(
               icon: const Icon(Icons.save, color: Color(0xFF00E5FF)), // Highlight save
               onPressed: _saveContent
             )
          else ...[
            IconButton(
              icon: Icon(_isSearching ? Icons.close : Icons.find_replace),
              tooltip: _isSearching ? t.close : t.find,
              onPressed: () {
                setState(() {
                  _isSearching = !_isSearching;
                  if (!_isSearching) {
                    _searchQuery = '';
                    _searchController.clear();
                    _replaceController.clear();
                  }
                });
              },
            ),
            IconButton(
              tooltip: _isRaw ? 'Show Formatted' : 'Show Raw',
              icon: Icon(_isRaw ? Icons.code_off : Icons.code),
              onPressed: _toggleView,
            ),
            IconButton(
              icon: const Icon(Icons.picture_as_pdf),
              tooltip: t.exportPdf,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PdfViewerScreen(
                      fileName: FileUtils.getFileName(widget.file),
                      content: _content,
                      isDirectFileView: true,
                      csvData: _fileType == FileType.table ? _csvData : null,
                    ),
                  ),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: _toggleEdit,
            ),
          ]
        ],
      ),
      body: _buildBody(t),
      floatingActionButton: (!_isLoading && _error == null && _content.isNotEmpty)
          ? FloatingActionButton.extended(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AiChatScreen(
                      fileName: FileUtils.getFileName(widget.file),
                      fileType: _extension,
                      content: _content,
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.auto_awesome),
              label: const Text('Ask AI'),
              backgroundColor: Theme.of(context).colorScheme.secondary,
              foregroundColor: Colors.black,
            )
          : null,
    );
  }

  Widget _buildBody(AppLocalizations t) {
    if (_isLoading) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 16),
            Text(
              t.processing,
              style: const TextStyle(fontSize: 16, color: Colors.white70),
            ),
          ],
        ),
      );
    }

    if (_error != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, size: 48, color: Theme.of(context).colorScheme.error),
              const SizedBox(height: 16),
              Text(
                t.errorLoadingFile,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(
                _error!,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white70),
              ),
            ],
          ),
        ),
      );
    }

    // Force Raw View or Edit Mode
    // Also force Raw View if searching in Code files (to show highlights)
    if (_isEditing || _isRaw || (_isSearching && _fileType != FileType.table) || _fileType == FileType.text) {
      return _buildRawView();
    }

    switch (_fileType) {
      case FileType.code:
        return _buildCodeView();
      case FileType.table:
        return _buildTableView();
      default:
        return _buildRawView();
    }
  }

  Widget _buildRawView() {
    if (_isEditing) {
       return Container(
        padding: const EdgeInsets.all(16),
        color: const Color(0xFF1E1E1E),
        child: TextField(
          controller: _editController,
          maxLines: null,
          style: GoogleFonts.firaCode(fontSize: 14, color: Colors.white),
          decoration: const InputDecoration(border: InputBorder.none),
        ),
      );
    }
    
    if (_searchQuery.isNotEmpty) {
      // Simple highlighting logic
      final matches = _searchQuery.allMatches(_content.toLowerCase());
      // For a robust implementation, use a specialized package or richer processing 
      // This is a minimal implementation for demonstration
      // Ideally, we split the string into spans
    }

    return Container(
      width: double.infinity,
      height: double.infinity,
      color: const Color(0xFF1E1E1E),
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: SelectableText.rich(
           _buildHighlightedText(),
          style: GoogleFonts.firaCode(
            fontSize: 14,
            color: Colors.white.withOpacity(0.9),
            height: 1.5,
          ),
        ),
      ),
    );
  }

  TextSpan _buildHighlightedText() {
    if (_searchQuery.isEmpty) return TextSpan(text: _content);
    
    final lowerContent = _content.toLowerCase();
    final lowerQuery = _searchQuery.toLowerCase();
    List<TextSpan> spans = [];
    int start = 0;
    int indexOfMatch;
    
    while ((indexOfMatch = lowerContent.indexOf(lowerQuery, start)) != -1) {
       spans.add(TextSpan(text: _content.substring(start, indexOfMatch)));
       spans.add(TextSpan(
         text: _content.substring(indexOfMatch, indexOfMatch + lowerQuery.length),
         style: const TextStyle(backgroundColor: Colors.yellow, color: Colors.black),
       ));
       start = indexOfMatch + lowerQuery.length;
    }
    spans.add(TextSpan(text: _content.substring(start)));
    
    return TextSpan(children: spans);
  }

  Widget _buildCodeView() {
    // Detect Language map
    var language = 'plaintext';
    switch (_extension) {
      case 'json': language = 'json'; break;
      case 'xml': language = 'xml'; break;
      case 'sql': language = 'sql'; break;
      case 'yaml': 
      case 'yml': language = 'yaml'; break;
      case 'dart': language = 'dart'; break;
      // Add more as needed
      default: language = 'plaintext';
    }

    return Container(
      width: double.infinity,
      height: double.infinity,
      color: const Color(0xFF282A36), // Dracula background
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: HighlightView(
          _content,
          language: language,
          theme: draculaTheme,
          textStyle: GoogleFonts.firaCode(
            fontSize: 14,
            height: 1.5,
          ),
        ),
      ),
    );
  }



  Widget _buildTableView() {
    if (_csvData.isEmpty) {
      return Center(child: Text(AppLocalizations.of(context)!.emptyCsv));
    }

    final headerRow = _csvData.first;
    final int columnCount = headerRow.length;

    // Filter rows for display
    var displayRows = _csvData.skip(1).toList();
    if (_searchQuery.isNotEmpty) {
      final query = _searchQuery.toLowerCase();
      displayRows = displayRows.where((row) {
        return row.any((cell) => cell.toString().toLowerCase().contains(query));
      }).toList();
    }

    // Single horizontal scroll view for perfect synchronization
    return Container(
      color: const Color(0xFF1E1E1E),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        controller: _horizontalScrollController,
        child: SizedBox(
          width: columnCount * 150.0, // Fixed width based on column count
          child: Column(
            children: [
              // Header row (fixed height)
              Container(
                height: 48,
                color: const Color(0xFF2D2D2D),
                child: Row(
                  children: headerRow.asMap().entries.map((entry) {
                    return InkWell(
                      onTap: () => _onSort(entry.key, !_sortAscending),
                      child: Container(
                        width: 150,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white12),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                entry.value.toString(),
                                style: GoogleFonts.outfit(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            if (_sortColumnIndex == entry.key)
                              Icon(
                                _sortAscending ? Icons.arrow_upward : Icons.arrow_downward,
                                size: 16,
                                color: Colors.white70,
                              ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              
              // Data rows (virtualized with ListView.builder)
              Expanded(
                child: ListView.builder(
                  itemCount: displayRows.length,
                  itemBuilder: (context, index) {
                    final row = displayRows[index];
                    // Normalize row length
                    final List<dynamic> processedRow = List.from(row);
                    while (processedRow.length < columnCount) {
                      processedRow.add('');
                    }
                    if (processedRow.length > columnCount) {
                      processedRow.length = columnCount;
                    }

                    return Container(
                      height: 48, // Fixed row height
                      color: index % 2 == 0 
                          ? Colors.white.withOpacity(0.02) 
                          : Colors.white.withOpacity(0.05),
                      child: Row(
                        children: processedRow.map((cell) {
                          return Container(
                            width: 150,
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white12),
                            ),
                            child: Text(
                              cell.toString(),
                              style: GoogleFonts.robotoMono(
                                fontSize: 13,
                                color: Colors.white70,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          );
                        }).toList(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
