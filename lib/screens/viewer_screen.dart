import 'dart:io';

import 'package:flutter/foundation.dart';

import 'package:file_viewer/screens/ai_chat_screen.dart';
import 'package:docx_to_text/docx_to_text.dart';
import 'package:file_viewer/screens/pdf_viewer_screen.dart';
import 'package:printing/printing.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:file_viewer/utils/file_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/dracula.dart';
import 'package:flutter_highlight/themes/github.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
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
  // Audio
  late AudioPlayer _audioPlayer;
  bool _isPlaying = false;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;

  // Video
  VideoPlayerController? _videoPlayerController;
  ChewieController? _chewieController;

  String _content = '';
  List<List<dynamic>> _csvData = [];
  Map<String, List<List<dynamic>>> _excelSheets = {};
  String? _currentSheetName;
  List<Map<String, dynamic>> _zipFiles = [];
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
    _audioPlayer = AudioPlayer();
    _audioPlayer.onPlayerStateChanged.listen((state) {
      if (mounted) setState(() => _isPlaying = state == PlayerState.playing);
    });
    _audioPlayer.onDurationChanged.listen((newDuration) {
      if (mounted) setState(() => _duration = newDuration);
    });
    _audioPlayer.onPositionChanged.listen((newPosition) {
      if (mounted) setState(() => _position = newPosition);
    });
    _loadContent();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    _videoPlayerController?.dispose();
    _chewieController?.dispose();
    _searchController.dispose();
    _editController.dispose();
    _replaceController.dispose();
    _horizontalScrollController.dispose();
    super.dispose();
  }

  Future<void> _loadContent() async {
    try {
      _extension = FileUtils.getFileExtension(widget.file);
      _fileType = FileUtils.getFileType(_extension);
      
      debugPrint('File extension: $_extension');
      debugPrint('File type: $_fileType');
      
      // Special handling for DOC/DOCX (binary files)
      if (_extension == 'doc' || _extension == 'docx') {
        String extractedText;
        if (_extension == 'doc') {
          extractedText = 'Visualização de arquivos .doc (Word 97-2003) ainda não é suportada por limitações técnicas.\n\nPor favor, salve o arquivo como .docx para visualizar.';
        } else {
          try {
            final bytes = await widget.file.readAsBytes();
            // Check if it's a valid ZIP (DOCX is XML inside ZIP) - Magic bytes: PK (0x50, 0x4B)
            if (bytes.length > 2 && bytes[0] == 0x50 && bytes[1] == 0x4B) {
               extractedText = docxToText(bytes);
               if (extractedText.isEmpty) {
                 extractedText = 'O arquivo parece vazio ou o texto não pôde ser extraído.\n\nNota: Imagens e formatações complexas não são exibidas.';
               }
            } else {
               extractedText = 'Erro de Formato:\nEste arquivo não é um DOCX válido.\n1. Pode ser um arquivo .doc antigo (Word 97-2003) renomeado manualmente.\n2. Pode estar corrompido.\n\nSolução: Abra no Word e use "Salvar Como" -> ".docx".';
            }
          } catch (e) {
            extractedText = 'Erro ao ler o documento DOCX:\n$e';
          }
        }

        if (mounted) {
          setState(() {
            _content = extractedText;
            _isLoading = false;
          });
        }
        return;
      }

      // Special handling for Excel (binary files)
      if (_extension == 'xlsx' || _extension == 'xls') {
        final sheets = await FileUtils.parseExcel(widget.file);
        if (mounted) {
          setState(() {
            _excelSheets = sheets;
            if (sheets.isNotEmpty) {
              _currentSheetName = sheets.keys.first;
              _csvData = sheets[_currentSheetName]!;
            } else {
              _csvData = [];
            }
            _content = ''; // Not used for Table View
            _isLoading = false;
          });
        }
        return;
      }

      // Special handling for Zip (binary files)
      if (_extension == 'zip') {
        final files = await FileUtils.parseZip(widget.file);
        if (mounted) {
          setState(() {
            _zipFiles = files;
            _content = 'Zip Archive (${files.length} files)';
            _isLoading = false;
          });
        }
        return;
      }

      // Special handling for Images
      if (_fileType == FileType.image) {
        if (mounted) {
          setState(() {
            _content = ''; // Content not needed for Image widget
            _isLoading = false;
          });
        }
        return;
      }

      // Special handling for PDF
      if (_fileType == FileType.pdf) {
        if (mounted) {
          setState(() {
            _content = '';
            _isLoading = false;
          });
        }
        return;
      }

      // Special handling for Audio
      if (_fileType == FileType.audio) {
        if (mounted) {
          setState(() {
            _content = ''; // not used
            _isLoading = false;
          });
        }
        return;
      }

      // Special handling for Video
      if (_fileType == FileType.video) {
        if (mounted) {
          setState(() {
            _content = ''; // not used
            _isLoading = true; // Still loading video player
          });
        }
        _initializeVideoPlayer();
        return;
      }

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
                if (_extension == 'zip') {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(AppLocalizations.of(context)!.searchNotAvailableZip)),
                  );
                  return;
                }
                
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
            if (_fileType != FileType.pdf && _fileType != FileType.audio && _fileType != FileType.video)
            IconButton(
              icon: const Icon(Icons.picture_as_pdf),
              tooltip: t.exportPdf,
              onPressed: () async {
                // Determine file size string
                String fileSize = 'Unknown';
                try {
                  final size = await widget.file.length();
                  if (size < 1024) {
                    fileSize = '$size B';
                  } else if (size < 1024 * 1024) {
                    fileSize = '${(size / 1024).toStringAsFixed(2)} KB';
                  } else {
                    fileSize = '${(size / (1024 * 1024)).toStringAsFixed(2)} MB';
                  }
                } catch (e) {
                  debugPrint('Error getting file size: $e');
                }

                if (!mounted) return;

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PdfViewerScreen(
                      fileName: FileUtils.getFileName(widget.file),
                      content: _content,
                      csvData: _fileType == FileType.table ? _csvData : null,
                      zipFiles: _fileType == FileType.archive ? _zipFiles : null,
                      fileSize: widget.file.lengthSync(), // Use sync for simplicity here or pass async var
                      filePath: widget.file.path,
                    ),
                  ),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                if (['xlsx', 'xls', 'doc', 'zip', 'pdf'].contains(_extension) || _fileType == FileType.image || _fileType == FileType.audio || _fileType == FileType.video) {
                   ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(AppLocalizations.of(context)!.readOnlyFormat)),
                   );
                   return;
                }
                _toggleEdit();
              },
            ),
          ]
        ],
      ),
      body: _buildBody(t),
      floatingActionButton: (!_isLoading && _error == null && (_content.isNotEmpty || _fileType == FileType.image || _fileType == FileType.pdf))
          ? FloatingActionButton(
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
              backgroundColor: Theme.of(context).colorScheme.secondary,
              foregroundColor: Colors.black,
              child: const Icon(Icons.auto_awesome),
            )
          : null,
    );
  }

  Widget _buildBody(AppLocalizations t) {
    if (_isLoading) {
      return Container(
        color: const Color(0xFF1E1E1E),
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: const Color(0xFF2D2D2D),
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                 BoxShadow(
                   color: Colors.black.withOpacity(0.3),
                   blurRadius: 30,
                   spreadRadius: 5,
                 )
              ],
              border: Border.all(color: Colors.white10),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                   width: 60, height: 60,
                   child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).colorScheme.primary),
                      strokeWidth: 4,
                      backgroundColor: Colors.white10,
                   ),
                ),
                const SizedBox(height: 24),
                Text(
                        t.processing,
                        style: GoogleFonts.outfit(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        t.processingWait,
                        style: GoogleFonts.outfit(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
              ],
            ),
          ),
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
    if (_isEditing || _isRaw || (_isSearching && _fileType != FileType.table && _fileType != FileType.markdown) || _fileType == FileType.text) {
      debugPrint('Using RAW view');
      return _buildRawView();
    }

    debugPrint('Using formatted view for type: $_fileType');
    
    switch (_fileType) {
      case FileType.code:
        debugPrint('Building CODE view');
        return _buildCodeView();
      case FileType.table:
        return _buildTableView();
      case FileType.markdown:
        return _buildMarkdownView();
      case FileType.archive:
        return _buildZipView();
      case FileType.image:
        return _buildImageView();
      case FileType.pdf:
        return _buildPdfView();
      case FileType.audio:
        return _buildAudioPlayer();
      case FileType.video:
        return _buildVideoPlayer();
      default:
        return _buildRawView();
    }
  }

  Widget _buildImageView() {
    return Container(
      color: Colors.black,
      child: InteractiveViewer(
        minScale: 0.1,
        maxScale: 5.0,
        child: Center(
          child: Image.file(
            widget.file,
            errorBuilder: (context, error, stackTrace) {
              return Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                    const Icon(Icons.broken_image, size: 64, color: Colors.white54),
                    const SizedBox(height: 16),
                    Text(
                      AppLocalizations.of(context)!.errorLoadingFile,
                      style: const TextStyle(color: Colors.white54),
                    )
                 ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildPdfView() {
    return PdfPreview(
      build: (format) => widget.file.readAsBytes(),
      allowPrinting: true,
      allowSharing: true,
      canChangeOrientation: false, 
      canChangePageFormat: false,
    );
  }

  Future<void> _initializeVideoPlayer() async {
    try {
      _videoPlayerController = VideoPlayerController.file(widget.file);
      await _videoPlayerController!.initialize();
      
      _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController!,
        autoPlay: false,
        looping: false,
        aspectRatio: _videoPlayerController!.value.aspectRatio,
        errorBuilder: (context, errorMessage) {
          return Center(
            child: Text(
              'Erro ao reproduzir vídeo: $errorMessage',
              style: const TextStyle(color: Colors.white),
            ),
          );
        },
      );
    } catch (e) {
      debugPrint('Error initializing video player: $e');
    }

    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Widget _buildVideoPlayer() {
    if (_chewieController != null && _videoPlayerController != null && _videoPlayerController!.value.isInitialized) {
       return Center(
         child: AspectRatio(
            aspectRatio: _videoPlayerController!.value.aspectRatio,
            child: Chewie(controller: _chewieController!),
         ),
       );
    } else {
       if (!_isLoading) return const Center(child: Text("Falha ao carregar vídeo", style: TextStyle(color: Colors.white)));
       return const Center(child: CircularProgressIndicator());
    }
  }

  Widget _buildAudioPlayer() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.audiotrack, size: 80, color: Theme.of(context).colorScheme.primary),
          const SizedBox(height: 24),
          Text(
            FileUtils.getFileName(widget.file), 
            style: const TextStyle(fontSize: 18, color: Colors.white),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: Slider(
              min: 0,
              max: _duration.inSeconds.toDouble(),
              value: (_position.inSeconds.toDouble()).clamp(0, _duration.inSeconds.toDouble()),
              onChanged: (value) async {
                final position = Duration(seconds: value.toInt());
                await _audioPlayer.seek(position);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(_formatDuration(_position), style: const TextStyle(color: Colors.white70)),
                Text(_formatDuration(_duration), style: const TextStyle(color: Colors.white70)),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                iconSize: 64,
                icon: Icon(_isPlaying ? Icons.pause_circle_filled : Icons.play_circle_filled),
                color: Theme.of(context).colorScheme.primary,
                onPressed: () async {
                  if (_isPlaying) {
                    await _audioPlayer.pause();
                  } else {
                    await _audioPlayer.play(DeviceFileSource(widget.file.path));
                  }
                },
              ),
              const SizedBox(width: 20),
               IconButton(
                iconSize: 48,
                icon: const Icon(Icons.stop_circle_outlined),
                color: Colors.white70,
                onPressed: () async {
                  await _audioPlayer.stop();
                  setState(() => _position = Duration.zero);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
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
    // Comprehensive language detection map
    var language = 'plaintext';
    switch (_extension) {
      // Data formats
      case 'json': language = 'json'; break;
      case 'xml': language = 'xml'; break;
      case 'yaml': 
      case 'yml': language = 'yaml'; break;
      
      // Database
      case 'sql': language = 'sql'; break;
      
      // Web
      case 'html':
      case 'htm': language = 'xml'; break; // HTML uses XML highlighting
      case 'ascx': // ASP.NET User Control
      case 'aspx': // ASP.NET Web Form
      case 'asmx': // ASP.NET Web Service
        language = 'xml';
        break;
      case 'css': language = 'css'; break;
      case 'scss':
      case 'sass': language = 'scss'; break;
      case 'js': language = 'javascript'; break;
      case 'jsx': language = 'javascript'; break;
      case 'ts': language = 'typescript'; break;
      case 'tsx': language = 'typescript'; break;
      
      // Mobile/App Development
      case 'dart': language = 'dart'; break;
      case 'java': language = 'java'; break;
      case 'kt':
      case 'kts': language = 'kotlin'; break;
      case 'swift': language = 'swift'; break;
      
      // Systems Programming
      case 'c': language = 'c'; break;
      case 'cpp':
      case 'cc':
      case 'cxx':
      case 'h':
      case 'hpp': language = 'cpp'; break;
      case 'cs': language = 'cs'; break;
      case 'go': language = 'go'; break;
      case 'rs': language = 'rust'; break;
      
      // Scripting
      case 'py': language = 'python'; break;
      case 'rb': language = 'ruby'; break;
      case 'php': language = 'php'; break;
      case 'pl': language = 'perl'; break;
      case 'sh':
      case 'bash': language = 'bash'; break;
      case 'ps1': language = 'powershell'; break;
      
      // Other
      case 'r': language = 'r'; break;
      case 'scala': language = 'scala'; break;
      case 'lua': language = 'lua'; break;
      case 'md':
      case 'markdown': language = 'markdown'; break;
      
      // Configuration files
      case 'ini':
      case 'cfg': language = 'ini'; break;
      case 'toml': language = 'ini'; break; // TOML similar to INI
      case 'properties': language = 'properties'; break;
      case 'env': language = 'bash'; break; // ENV files use bash-like syntax
      case 'conf': language = 'nginx'; break; // CONF files often use nginx-like syntax
      case 'config': language = 'xml'; break; // .config files are usually XML (like web.config)
      
      // Log files
      case 'log': language = 'log'; break;
      
      // Email files
      case 'eml': 
        debugPrint('Language detected: EML');
        language = 'eml'; 
        break;

      // Word documents
      case 'doc': 
      case 'docx': language = 'doc'; break;
      
      default: language = 'plaintext';
    }
    
    debugPrint('Detected language for .$_extension: $language');

    // Get language display name
    String getLanguageDisplayName() {
      final names = {
        'sql': 'SQL',
        'python': 'Python',
        'javascript': 'JavaScript',
        'typescript': 'TypeScript',
        'dart': 'Dart',
        'java': 'Java',
        'kotlin': 'Kotlin',
        'swift': 'Swift',
        'cpp': 'C++',
        'cs': 'C#',
        'go': 'Go',
        'rust': 'Rust',
        'php': 'PHP',
        'ruby': 'Ruby',
        'json': 'JSON',
        'xml': 'XML/HTML',
        'yaml': 'YAML',
        'css': 'CSS',
        'scss': 'SCSS',
        'bash': 'Bash',
        'powershell': 'PowerShell',
        'markdown': 'Markdown',
        'ini': 'INI/Config',
        'properties': 'Properties',
        'nginx': 'Config',
        'log': 'Log File',
        'eml': 'Email',
        'doc': 'Word Document',
        'docx': 'Word Document',
      };
      return names[language] ?? language.toUpperCase();
    }

    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF282A36), // Dracula background
            const Color(0xFF1E1E2E),
          ],
        ),
      ),
      child: Column(
        children: [
          // Language indicator bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.black26,
              border: Border(
                bottom: BorderSide(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                  width: 1,
                ),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.code,
                  size: 16,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  getLanguageDisplayName(),
                  style: GoogleFonts.outfit(
                    fontSize: 13,
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Theme.of(context).colorScheme.secondary.withOpacity(0.5),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.auto_awesome,
                        size: 12,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Syntax Highlighting',
                        style: GoogleFonts.outfit(
                          fontSize: 11,
                          color: Theme.of(context).colorScheme.secondary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Code content with syntax highlighting
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: language == 'sql' 
                  ? _buildSqlHighlightedText()
                  : (language == 'ini' || language == 'properties' || language == 'nginx')
                      ? _buildConfigHighlightedText()
                      : language == 'log'
                          ? _buildLogHighlightedText()
                          : language == 'eml'
                              ? _buildEmailHighlightedText()
                              : (language == 'doc' || language == 'docx')
                                  ? _buildDocxHighlightedText()
                                  : HighlightView(
                      _content,
                      language: language,
                      theme: draculaTheme,
                      padding: const EdgeInsets.all(16),
                      textStyle: GoogleFonts.firaCode(
                        fontSize: 14,
                        height: 1.6,
                        letterSpacing: 0.2,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  // Markdown View with beautiful rendering
  Widget _buildMarkdownView() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF0A0A0A),
            const Color(0xFF1A1A1A),
          ],
        ),
      ),
      child: Markdown(
        data: _content,
        selectable: true,
        styleSheet: MarkdownStyleSheet(
          // Headings
          h1: GoogleFonts.outfit(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
            height: 1.5,
          ),
          h2: GoogleFonts.outfit(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary.withOpacity(0.9),
            height: 1.4,
          ),
          h3: GoogleFonts.outfit(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.secondary,
            height: 1.3,
          ),
          h4: GoogleFonts.outfit(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.white.withOpacity(0.9),
            height: 1.3,
          ),
          h5: GoogleFonts.outfit(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.white.withOpacity(0.85),
            height: 1.2,
          ),
          h6: GoogleFonts.outfit(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.white.withOpacity(0.8),
            height: 1.2,
          ),
          
          // Body text
          p: GoogleFonts.outfit(
            fontSize: 16,
            color: Colors.white.withOpacity(0.85),
            height: 1.6,
          ),
          
          // Lists
          listBullet: GoogleFonts.outfit(
            fontSize: 16,
            color: Theme.of(context).colorScheme.secondary,
          ),
          
          // Links
          a: GoogleFonts.outfit(
            fontSize: 16,
            color: Theme.of(context).colorScheme.secondary,
            decoration: TextDecoration.underline,
          ),
          
          // Code
          code: GoogleFonts.firaCode(
            fontSize: 14,
            backgroundColor: Colors.black26,
            color: Theme.of(context).colorScheme.secondary,
          ),
          codeblockDecoration: BoxDecoration(
            color: const Color(0xFF282A36),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
              width: 1,
            ),
          ),
          codeblockPadding: const EdgeInsets.all(16),
          
          // Blockquotes
          blockquote: GoogleFonts.outfit(
            fontSize: 16,
            color: Colors.white.withOpacity(0.7),
            fontStyle: FontStyle.italic,
          ),
          blockquoteDecoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(4),
            border: Border(
              left: BorderSide(
                color: Theme.of(context).colorScheme.primary,
                width: 4,
              ),
            ),
          ),
          blockquotePadding: const EdgeInsets.all(16),
          
          // Horizontal rule
          horizontalRuleDecoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                width: 2,
              ),
            ),
          ),
          
          // Tables
          tableHead: GoogleFonts.outfit(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          tableBody: GoogleFonts.outfit(
            fontSize: 14,
            color: Colors.white.withOpacity(0.85),
          ),
          tableBorder: TableBorder.all(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
            width: 1,
          ),
          tableColumnWidth: const FlexColumnWidth(),
          
          // Emphasis
          em: const TextStyle(fontStyle: FontStyle.italic),
          strong: const TextStyle(fontWeight: FontWeight.bold),
          del: const TextStyle(decoration: TextDecoration.lineThrough),
        ),
        padding: const EdgeInsets.all(24),
      ),
    );
  }

  // Custom SQL syntax highlighter with Dracula colors
  Widget _buildSqlHighlightedText() {
    final List<TextSpan> spans = [];
    
    // Dracula color scheme
    const keywordColor = Color(0xFFFF79C6); // Pink for keywords
    const functionColor = Color(0xFF8BE9FD); // Cyan for functions
    const stringColor = Color(0xFFF1FA8C); // Yellow for strings
    const numberColor = Color(0xFFBD93F9); // Purple for numbers
    const commentColor = Color(0xFF6272A4); // Blue-gray for comments
    const defaultColor = Color(0xFFF8F8F2); // White for default text
    
    // SQL Keywords
    final keywords = [
      'SELECT', 'FROM', 'WHERE', 'INSERT', 'UPDATE', 'DELETE', 'CREATE', 'DROP',
      'ALTER', 'TABLE', 'DATABASE', 'INDEX', 'VIEW', 'JOIN', 'LEFT', 'RIGHT',
      'INNER', 'OUTER', 'ON', 'AS', 'AND', 'OR', 'NOT', 'NULL', 'IS', 'IN',
      'BETWEEN', 'LIKE', 'ORDER', 'BY', 'GROUP', 'HAVING', 'LIMIT', 'OFFSET',
      'DISTINCT', 'ALL', 'UNION', 'INTERSECT', 'EXCEPT', 'EXISTS', 'CASE',
      'WHEN', 'THEN', 'ELSE', 'END', 'PRIMARY', 'KEY', 'FOREIGN', 'REFERENCES',
      'CONSTRAINT', 'UNIQUE', 'CHECK', 'DEFAULT', 'AUTO_INCREMENT', 'CASCADE',
      'SET', 'VALUES', 'INTO', 'TRUNCATE', 'GRANT', 'REVOKE', 'COMMIT', 'ROLLBACK',
      'BEGIN', 'TRANSACTION', 'SAVEPOINT', 'PROCEDURE', 'FUNCTION', 'TRIGGER',
      'DECLARE', 'CURSOR', 'FETCH', 'OPEN', 'CLOSE', 'IF', 'WHILE', 'LOOP',
      'RETURN', 'VARCHAR', 'INT', 'INTEGER', 'DECIMAL', 'FLOAT', 'DOUBLE',
      'DATE', 'TIME', 'TIMESTAMP', 'BOOLEAN', 'TEXT', 'BLOB', 'CHAR'
    ];
    
    // SQL Functions
    final functions = [
      'COUNT', 'SUM', 'AVG', 'MIN', 'MAX', 'ROUND', 'FLOOR', 'CEIL', 'ABS',
      'UPPER', 'LOWER', 'TRIM', 'LTRIM', 'RTRIM', 'LENGTH', 'SUBSTRING', 'CONCAT',
      'REPLACE', 'COALESCE', 'NULLIF', 'CAST', 'CONVERT', 'NOW', 'CURDATE',
      'CURTIME', 'DATE_FORMAT', 'YEAR', 'MONTH', 'DAY', 'HOUR', 'MINUTE', 'SECOND'
    ];
    
    final lines = _content.split('\n');
    
    for (int i = 0; i < lines.length; i++) {
      final line = lines[i];
      
      // Check if line is a comment
      if (line.trim().startsWith('--') || line.trim().startsWith('#')) {
        spans.add(TextSpan(
          text: line + (i < lines.length - 1 ? '\n' : ''),
          style: GoogleFonts.firaCode(
            fontSize: 14,
            height: 1.6,
            letterSpacing: 0.2,
            color: commentColor,
            fontStyle: FontStyle.italic,
          ),
        ));
        continue;
      }
      
      // Process line word by word
      final words = line.split(RegExp(r'(\s+|(?=[(),;])|(?<=[(),;]))'));
      
      for (final word in words) {
        final upperWord = word.toUpperCase();
        
        // Check for strings
        if (word.startsWith("'") || word.startsWith('"')) {
          spans.add(TextSpan(
            text: word,
            style: GoogleFonts.firaCode(
              fontSize: 14,
              height: 1.6,
              letterSpacing: 0.2,
              color: stringColor,
            ),
          ));
        }
        // Check for numbers
        else if (RegExp(r'^\d+(\.\d+)?$').hasMatch(word)) {
          spans.add(TextSpan(
            text: word,
            style: GoogleFonts.firaCode(
              fontSize: 14,
              height: 1.6,
              letterSpacing: 0.2,
              color: numberColor,
            ),
          ));
        }
        // Check for keywords
        else if (keywords.contains(upperWord)) {
          spans.add(TextSpan(
            text: word,
            style: GoogleFonts.firaCode(
              fontSize: 14,
              height: 1.6,
              letterSpacing: 0.2,
              color: keywordColor,
              fontWeight: FontWeight.bold,
            ),
          ));
        }
        // Check for functions
        else if (functions.contains(upperWord)) {
          spans.add(TextSpan(
            text: word,
            style: GoogleFonts.firaCode(
              fontSize: 14,
              height: 1.6,
              letterSpacing: 0.2,
              color: functionColor,
              fontWeight: FontWeight.w600,
            ),
          ));
        }
        // Default text
        else {
          spans.add(TextSpan(
            text: word,
            style: GoogleFonts.firaCode(
              fontSize: 14,
              height: 1.6,
              letterSpacing: 0.2,
              color: defaultColor,
            ),
          ));
        }
      }
      
      // Add newline
      if (i < lines.length - 1) {
        spans.add(const TextSpan(text: '\n'));
      }
    }
    
    return Container(
      padding: const EdgeInsets.all(16),
      child: SelectableText.rich(
        TextSpan(children: spans),
      ),
    );
  }

  // Custom Config file syntax highlighter with Dracula colors
  Widget _buildConfigHighlightedText() {
    final List<TextSpan> spans = [];
    
    // Dracula color scheme
    const sectionColor = Color(0xFFFF79C6); // Pink for [sections]
    const keyColor = Color(0xFF8BE9FD); // Cyan for keys
    const valueColor = Color(0xFFF1FA8C); // Yellow for values
    const commentColor = Color(0xFF6272A4); // Blue-gray for comments
    const specialColor = Color(0xFFBD93F9); // Purple for = and :
    const defaultColor = Color(0xFFF8F8F2); // White for default text
    
    final lines = _content.split('\n');
    
    for (int i = 0; i < lines.length; i++) {
      final line = lines[i];
      
      // Empty line
      if (line.trim().isEmpty) {
        spans.add(const TextSpan(text: '\n'));
        continue;
      }
      
      // Comment line (# or ; or //)
      if (line.trimLeft().startsWith('#') || 
          line.trimLeft().startsWith(';') ||
          line.trimLeft().startsWith('//')) {
        spans.add(TextSpan(
          text: '$line\n',
          style: const TextStyle(
            color: commentColor,
            fontStyle: FontStyle.italic,
          ),
        ));
        continue;
      }
      
      // Section header [section]
      final sectionMatch = RegExp(r'^\s*\[([^\]]+)\]').firstMatch(line);
      if (sectionMatch != null) {
        final indent = line.substring(0, line.indexOf('['));
        spans.add(TextSpan(text: indent));
        spans.add(TextSpan(
          text: '[${sectionMatch.group(1)}]',
          style: const TextStyle(
            color: sectionColor,
            fontWeight: FontWeight.bold,
          ),
        ));
        spans.add(const TextSpan(text: '\n'));
        continue;
      }
      
      // Key = Value or Key: Value
      final kvMatch = RegExp(r'^(\s*)([^=:#]+?)\s*([:=])\s*(.*)$').firstMatch(line);
      if (kvMatch != null) {
        final indent = kvMatch.group(1) ?? '';
        final key = kvMatch.group(2) ?? '';
        final separator = kvMatch.group(3) ?? '';
        final value = kvMatch.group(4) ?? '';
        
        spans.add(TextSpan(text: indent));
        spans.add(TextSpan(
          text: key,
          style: const TextStyle(
            color: keyColor,
            fontWeight: FontWeight.w600,
          ),
        ));
        spans.add(TextSpan(
          text: separator,
          style: const TextStyle(color: specialColor),
        ));
        
        // Check if value has inline comment
        final commentMatch = RegExp(r'^([^#;]*)(#|;)(.*)$').firstMatch(value);
        if (commentMatch != null) {
          spans.add(TextSpan(
            text: commentMatch.group(1),
            style: const TextStyle(color: valueColor),
          ));
          spans.add(TextSpan(
            text: '${commentMatch.group(2)}${commentMatch.group(3)}',
            style: const TextStyle(
              color: commentColor,
              fontStyle: FontStyle.italic,
            ),
          ));
        } else {
          spans.add(TextSpan(
            text: value,
            style: const TextStyle(color: valueColor),
          ));
        }
        
        spans.add(const TextSpan(text: '\n'));
        continue;
      }
      
      // Default: no highlighting
      spans.add(TextSpan(text: '$line\n'));
    }
    
    return Container(
      padding: const EdgeInsets.all(16),
      child: SelectableText.rich(
        TextSpan(children: spans),
      ),
    );
  }

  // Custom Log file syntax highlighter with colors for log levels
  Widget _buildLogHighlightedText() {
    final List<TextSpan> spans = [];
    
    // Log level colors
    const errorColor = Color(0xFFFF5555); // Red for ERROR/FATAL
    const warnColor = Color(0xFFFFB86C); // Orange for WARN/WARNING
    const infoColor = Color(0xFF8BE9FD); // Cyan for INFO
    const debugColor = Color(0xFF6272A4); // Gray for DEBUG/TRACE
    const successColor = Color(0xFF50FA7B); // Green for SUCCESS/OK
    const timestampColor = Color(0xFFBD93F9); // Purple for timestamps
    const defaultColor = Color(0xFFF8F8F2); // White for default text
    
    final lines = _content.split('\n');
    
    for (int i = 0; i < lines.length; i++) {
      final line = lines[i];
      
      if (line.trim().isEmpty) {
        spans.add(const TextSpan(text: '\n'));
        continue;
      }
      
      // Detect log level and apply color
      Color lineColor = defaultColor;
      FontWeight? weight;
      
      final upperLine = line.toUpperCase();
      
      if (upperLine.contains('ERROR') || upperLine.contains('FATAL') || upperLine.contains('FAIL')) {
        lineColor = errorColor;
        weight = FontWeight.bold;
      } else if (upperLine.contains('WARN')) {
        lineColor = warnColor;
        weight = FontWeight.w600;
      } else if (upperLine.contains('INFO')) {
        lineColor = infoColor;
      } else if (upperLine.contains('DEBUG') || upperLine.contains('TRACE')) {
        lineColor = debugColor;
      } else if (upperLine.contains('SUCCESS') || upperLine.contains(' OK ') || upperLine.contains('[OK]')) {
        lineColor = successColor;
        weight = FontWeight.w600;
      }
      
      // Try to detect and highlight timestamp at the beginning
      // Common formats: [2024-01-01 12:00:00], 2024-01-01T12:00:00, etc.
      final timestampMatch = RegExp(r'^(\[?\d{4}[-/]\d{2}[-/]\d{2}[T\s]\d{2}:\d{2}:\d{2}[^\]]*\]?|\[\d{2}:\d{2}:\d{2}\])').firstMatch(line);
      
      if (timestampMatch != null) {
        final timestamp = timestampMatch.group(0)!;
        final rest = line.substring(timestamp.length);
        
        spans.add(TextSpan(
          text: timestamp,
          style: const TextStyle(
            color: timestampColor,
            fontWeight: FontWeight.w500,
          ),
        ));
        
        spans.add(TextSpan(
          text: '$rest\n',
          style: TextStyle(
            color: lineColor,
            fontWeight: weight,
          ),
        ));
      } else {
        spans.add(TextSpan(
          text: '$line\n',
          style: TextStyle(
            color: lineColor,
            fontWeight: weight,
          ),
        ));
      }
    }
    
    return Container(
      padding: const EdgeInsets.all(16),
      child: SelectableText.rich(
        TextSpan(children: spans),
      ),
    );
  }

  // Custom Email file syntax highlighter with colors for headers
  Widget _buildEmailHighlightedText() {
    final List<TextSpan> spans = [];
    
    // Email colors
    const headerKeyColor = Color(0xFF8BE9FD); // Cyan for header keys
    const headerValueColor = Color(0xFFF1FA8C); // Yellow for header values
    const importantHeaderColor = Color(0xFFFF79C6); // Pink for From/To/Subject
    const dateColor = Color(0xFFBD93F9); // Purple for dates
    const boundaryColor = Color(0xFF50FA7B); // Green for MIME boundaries
    const commentColor = Color(0xFF6272A4); // Gray for comments
    const defaultColor = Color(0xFFF8F8F2); // White for body text
    
    final lines = _content.replaceAll('\r\n', '\n').split('\n');
    bool inHeaders = true;
    debugPrint('EML Highlighter: Processing ${lines.length} lines');
    
    for (int i = 0; i < lines.length; i++) {
      final line = lines[i];
      final trimmedLine = line.trim();
      
      // Empty line marks end of headers
      if (inHeaders && trimmedLine.isEmpty) {
        // Only stop headers if we found at least one header before?
        // But standard says first empty line ends headers.
        inHeaders = false;
        spans.add(const TextSpan(text: '\n'));
        continue;
      }
      
      // MIME boundary
      if (line.startsWith('--')) {
        spans.add(TextSpan(
          text: '$line\n',
          style: const TextStyle(
            color: boundaryColor,
            fontWeight: FontWeight.bold,
          ),
        ));
        continue;
      }
      
      // Headers section
      if (inHeaders) {
        // Header line (Key: Value)
        final headerMatch = RegExp(r'^([^:]+):\s*(.*)$').firstMatch(line);
        if (headerMatch != null) {
          final key = headerMatch.group(1)!;
          final value = headerMatch.group(2)!;
          
          // Important headers in pink
          if (key.toLowerCase() == 'from' || 
              key.toLowerCase() == 'to' || 
              key.toLowerCase() == 'subject' ||
              key.toLowerCase() == 'cc' ||
              key.toLowerCase() == 'bcc') {
            spans.add(TextSpan(
              text: '$key: ',
              style: const TextStyle(
                color: importantHeaderColor,
                fontWeight: FontWeight.bold,
              ),
            ));
            spans.add(TextSpan(
              text: '$value\n',
              style: const TextStyle(
                color: headerValueColor,
                fontWeight: FontWeight.w600,
              ),
            ));
          }
          // Date in purple
          else if (key.toLowerCase() == 'date') {
            spans.add(TextSpan(
              text: '$key: ',
              style: const TextStyle(
                color: headerKeyColor,
                fontWeight: FontWeight.w600,
              ),
            ));
            spans.add(TextSpan(
              text: '$value\n',
              style: const TextStyle(
                color: dateColor,
                fontWeight: FontWeight.w500,
              ),
            ));
          }
          // Other headers in cyan/yellow
          else {
            spans.add(TextSpan(
              text: '$key: ',
              style: const TextStyle(
                color: headerKeyColor,
                fontWeight: FontWeight.w600,
              ),
            ));
            spans.add(TextSpan(
              text: '$value\n',
              style: const TextStyle(color: headerValueColor),
            ));
          }
          continue;
        }
      }
      
      // Body text (after headers)
      spans.add(TextSpan(
        text: '$line\n',
        style: const TextStyle(color: defaultColor),
      ));
    }
    
    return Container(
      padding: const EdgeInsets.all(16),
      child: SelectableText.rich(
        TextSpan(children: spans),
      ),
    );
  }

  // Custom DOC/DOCX file syntax highlighter (plain text extraction)
  Widget _buildDocxHighlightedText() {
    return Container(
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      child: SelectableText(
        _content,
        style: GoogleFonts.robotoMono(
          fontSize: 14,
          color: const Color(0xFFF8F8F2), // Dracula white
        ),
      ),
    );
  }

  Widget _buildZipView() {
    if (_zipFiles.isEmpty) {
      return Center(
        child: Text(
        AppLocalizations.of(context)!.zipEmpty,
        style: GoogleFonts.outfit(color: Colors.white70),
      ),
      );
    }
    
    return Container(
      color: const Color(0xFF1E1E1E),
      child: ListView.separated(
        itemCount: _zipFiles.length,
        separatorBuilder: (_, __) => const Divider(color: Colors.white10, height: 1),
        itemBuilder: (context, index) {
          final file = _zipFiles[index];
          final name = file['name'] as String;
          final size = file['size'] as int;
          final isFile = file['isFile'] as bool;
          
          return ListTile(
            leading: Icon(
              isFile ? Icons.insert_drive_file : Icons.folder,
              color: isFile ? Colors.blueAccent : Colors.amber,
            ),
            title: Text(
              name,
              style: GoogleFonts.robotoMono(color: Colors.white, fontSize: 13),
            ),
            subtitle: isFile 
                ? Text(
                    '${(size / 1024).toStringAsFixed(1)} KB', 
                    style: const TextStyle(color: Colors.white54, fontSize: 11),
                  )
                : null,
            dense: true,
          );
        },
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

    // Calculate dynamic column width based on content
    double calculateColumnWidth(int columnIndex) {
      // Minimum width
      double maxWidth = 120.0;
      
      // Check header width
      final headerText = headerRow[columnIndex].toString();
      final headerWidth = (headerText.length * 8.5).clamp(120.0, 300.0);
      if (headerWidth > maxWidth) maxWidth = headerWidth;
      
      // Sample first 20 rows for performance
      final sampleRows = displayRows.take(20);
      for (var row in sampleRows) {
        if (columnIndex < row.length) {
          final cellText = row[columnIndex].toString();
          final cellWidth = (cellText.length * 7.5).clamp(120.0, 300.0);
          if (cellWidth > maxWidth) maxWidth = cellWidth;
        }
      }
      
      return maxWidth;
    }

    // Calculate all column widths
    final columnWidths = List.generate(columnCount, (i) => calculateColumnWidth(i));
    final totalWidth = columnWidths.reduce((a, b) => a + b);

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF0A0A0A),
            const Color(0xFF1A1A1A),
          ],
        ),
      ),
      child: Column(
        children: [
          // Info bar showing row count
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.black26,
              border: Border(
                bottom: BorderSide(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                  width: 1,
                ),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.table_chart,
                  size: 16,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  '${displayRows.length} ${displayRows.length == 1 ? 'row' : 'rows'} × $columnCount columns',
                  style: GoogleFonts.outfit(
                    fontSize: 13,
                    color: Colors.white70,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (_searchQuery.isNotEmpty) ...[
                  const SizedBox(width: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.filter_alt,
                          size: 14,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Filtered',
                          style: GoogleFonts.outfit(
                            fontSize: 12,
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
          
          // Helper to select sheet (Multi-tab Excel support)
          if (_excelSheets.length > 1)
            Container(
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              color: Colors.black12,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: _excelSheets.length,
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  final sheetName = _excelSheets.keys.elementAt(index);
                  final isSelected = sheetName == _currentSheetName;
                  
                  return Center(
                    child: FilterChip(
                      label: Text(sheetName),
                      selected: isSelected,
                      onSelected: (_) {
                        setState(() {
                          _currentSheetName = sheetName;
                          _csvData = _excelSheets[sheetName]!;
                          // Clear sort when switching sheets
                          _sortColumnIndex = null;
                          _sortAscending = true;
                        });
                      },
                      backgroundColor: Colors.white10,
                      selectedColor: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                      labelStyle: TextStyle(
                        color: isSelected ? Theme.of(context).colorScheme.primary : Colors.white70,
                        fontSize: 13,
                      ),
                      checkmarkColor: Theme.of(context).colorScheme.primary,
                      side: BorderSide(
                        color: isSelected 
                          ? Theme.of(context).colorScheme.primary.withOpacity(0.5) 
                          : Colors.white10,
                      ),
                    ),
                  );
                },
              ),
            ),
            
          // Table with horizontal scroll
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              controller: _horizontalScrollController,
              child: SizedBox(
                width: totalWidth,
                child: Column(
                  children: [
                    // Header row with gradient
                    Container(
                      height: 56,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Theme.of(context).colorScheme.primary.withOpacity(0.15),
                            Theme.of(context).colorScheme.secondary.withOpacity(0.15),
                          ],
                        ),
                        border: Border(
                          bottom: BorderSide(
                            color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
                            width: 2,
                          ),
                        ),
                      ),
                      child: Row(
                        children: headerRow.asMap().entries.map((entry) {
                          final isActive = _sortColumnIndex == entry.key;
                          return InkWell(
                            onTap: () => _onSort(entry.key, !_sortAscending),
                            hoverColor: Colors.white.withOpacity(0.05),
                            child: Container(
                              width: columnWidths[entry.key],
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                              decoration: BoxDecoration(
                                border: Border(
                                  right: BorderSide(
                                    color: Colors.white.withOpacity(0.1),
                                    width: 1,
                                  ),
                                ),
                                color: isActive 
                                    ? Theme.of(context).colorScheme.primary.withOpacity(0.1)
                                    : null,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      entry.value.toString(),
                                      style: GoogleFonts.outfit(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14,
                                        color: isActive 
                                            ? Theme.of(context).colorScheme.primary
                                            : Colors.white,
                                        letterSpacing: 0.5,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  if (isActive)
                                    Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).colorScheme.primary,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Icon(
                                        _sortAscending ? Icons.arrow_upward : Icons.arrow_downward,
                                        size: 14,
                                        color: Colors.black,
                                      ),
                                    )
                                  else
                                    Icon(
                                      Icons.unfold_more,
                                      size: 16,
                                      color: Colors.white30,
                                    ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    
                    // Data rows with improved styling
                    Expanded(
                      child: ListView.builder(
                        itemCount: displayRows.length,
                        itemBuilder: (context, index) {
                          final row = displayRows[index];
                          final isEven = index % 2 == 0;
                          
                          // Normalize row length
                          final List<dynamic> processedRow = List.from(row);
                          while (processedRow.length < columnCount) {
                            processedRow.add('');
                          }
                          if (processedRow.length > columnCount) {
                            processedRow.length = columnCount;
                          }

                          return Container(
                            height: 52,
                            decoration: BoxDecoration(
                              color: isEven 
                                  ? Colors.white.withOpacity(0.03)
                                  : Colors.white.withOpacity(0.01),
                              border: Border(
                                bottom: BorderSide(
                                  color: Colors.white.withOpacity(0.05),
                                  width: 1,
                                ),
                              ),
                            ),
                            child: Row(
                              children: processedRow.asMap().entries.map((entry) {
                                final cellValue = entry.value.toString();
                                final isNumeric = double.tryParse(cellValue.replaceAll(',', '')) != null;
                                final isEmpty = cellValue.trim().isEmpty;
                                
                                // Highlight search matches
                                final hasMatch = _searchQuery.isNotEmpty && 
                                    cellValue.toLowerCase().contains(_searchQuery.toLowerCase());
                                
                                return Container(
                                  width: columnWidths[entry.key],
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      right: BorderSide(
                                        color: Colors.white.withOpacity(0.05),
                                        width: 1,
                                      ),
                                    ),
                                    color: hasMatch 
                                        ? Theme.of(context).colorScheme.secondary.withOpacity(0.15)
                                        : null,
                                  ),
                                  child: Text(
                                    cellValue,
                                    style: GoogleFonts.robotoMono(
                                      fontSize: 13,
                                      height: 1.4,
                                      color: isEmpty 
                                          ? Colors.white24
                                          : hasMatch
                                              ? Theme.of(context).colorScheme.secondary
                                              : isNumeric
                                                  ? const Color(0xFF00E5FF)
                                                  : Colors.white.withOpacity(0.85),
                                      fontWeight: hasMatch ? FontWeight.w600 : FontWeight.w400,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    textAlign: isNumeric ? TextAlign.right : TextAlign.left,
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
          ),
        ],
      ),
    );
  }
}
