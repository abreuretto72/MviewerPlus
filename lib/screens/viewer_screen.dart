import 'dart:io';

import 'package:file_viewer/screens/ai_chat_screen.dart';
import 'package:file_viewer/utils/file_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/dracula.dart';
import 'package:flutter_highlight/themes/github.dart';
import 'package:file_viewer/l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

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

  // CSV Sorting
  int? _sortColumnIndex;
  bool _sortAscending = true;

  @override
  void initState() {
    super.initState();
    _loadContent();
  }

  Future<void> _loadContent() async {
    try {
      _extension = FileUtils.getFileExtension(widget.file);
      _fileType = FileUtils.getFileType(_extension);
      
      // Basic size check - alert if too big? For now just read.
      // 5MB limit check could be good but let's just read for MVP.
      
      final content = await FileUtils.readFileContent(widget.file);
      
      if (_fileType == FileType.table) {
        _csvData = await FileUtils.parseCsv(content);
      }

      if (mounted) {
        setState(() {
          _content = content;
          _isLoading = false;
        });
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
        _isEditing = false;
      }
      await widget.file.writeAsString(_content);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('File saved successfully')),
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

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: _isSearching
            ? TextField(
                controller: _searchController,
                autofocus: true,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: 'Search...',
                  hintStyle: TextStyle(color: Colors.white54),
                  border: InputBorder.none,
                ),
                onChanged: (value) => setState(() => _searchQuery = value),
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
        actions: [
          if (_isEditing)
             IconButton(icon: const Icon(Icons.save), onPressed: _saveContent)
          else ...[
            IconButton(
              icon: Icon(_isSearching ? Icons.close : Icons.search),
              onPressed: () {
                setState(() {
                  _isSearching = !_isSearching;
                  if (!_isSearching) {
                    _searchQuery = '';
                    _searchController.clear();
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
      return const Center(child: CircularProgressIndicator());
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

    // Force Raw View
    if (_isRaw || _fileType == FileType.text) {
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

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          sortColumnIndex: _sortColumnIndex,
          sortAscending: _sortAscending,
          headingRowColor: MaterialStateProperty.all(Theme.of(context).colorScheme.surface),
          dataRowColor: MaterialStateProperty.all(Theme.of(context).colorScheme.surface.withOpacity(0.5)),
          border: TableBorder.all(color: Colors.white10),
          columns: headerRow.asMap().entries.map<DataColumn>((entry) {
            final index = entry.key;
            final e = entry.value;
            return DataColumn(
              label: Text(
                e.toString(),
                style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
              onSort: (columnIndex, ascending) => _onSort(columnIndex, ascending),
            );
          }).toList(),
          rows: _csvData.skip(1).map((row) {
            // Normalize row length
            final List<dynamic> processedRow = List.from(row);
            while (processedRow.length < columnCount) {
              processedRow.add('');
            }
            // Truncate if too long
            if (processedRow.length > columnCount) {
              processedRow.length = columnCount;
            }

            return DataRow(
              cells: processedRow.map((cell) {
                return DataCell(
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 300),
                    child: Text(
                      cell.toString(),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                );
              }).toList(),
            );
          }).toList(),
        ),
      ),
    );
  }
}
