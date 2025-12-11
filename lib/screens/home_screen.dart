import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:file_viewer/screens/settings/settings_screen.dart';
import 'package:file_viewer/screens/viewer_screen.dart';
import 'package:flutter/material.dart';
import 'package:file_viewer/l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    )..repeat(reverse: true);
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result != null && result.files.single.path != null) {
        String filePath = result.files.single.path!;
        if (!mounted) return;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ViewerScreen(file: File(filePath)),
          ),
        );
      } else {
        // User canceled the picker
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error picking file: $e'),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              );
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).colorScheme.surface,
              Theme.of(context).colorScheme.surfaceContainerHighest,
              const Color(0xFF1A103C), // Deep purple tint
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo or Icon
              Container(
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                  border: Border.all(
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                      blurRadius: 40,
                      spreadRadius: 10,
                    )
                  ],
                ),
                child: Icon(
                  Icons.folder_open_rounded,
                  size: 80,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(height: 48),
              // Title
              Text(
                t.appTitle,
                style: GoogleFonts.outfit(
                  fontSize: 42,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -1.0,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      color: Colors.black.withOpacity(0.5),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Text(
                t.subtitle,
                style: GoogleFonts.outfit(
                  fontSize: 18,
                  color: Colors.white70,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 64),
              // Action Button
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: ElevatedButton.icon(
                    onPressed: _pickFile,
                    icon: const Icon(Icons.add_rounded, size: 28),
                    label: Text(t.openFile),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 48,
                        vertical: 24,
                      ),
                      textStyle: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      shadowColor: Theme.of(context).colorScheme.primary,
                      elevation: 10,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Supported formats hint
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  t.supportsHint,
                  style: GoogleFonts.outfit(
                    fontSize: 12,
                    color: Colors.white38,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
