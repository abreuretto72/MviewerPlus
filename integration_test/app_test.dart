
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:file_viewer/main.dart';
import 'package:file_viewer/services/file_picker_service.dart';
import 'package:file_viewer/providers/locale_provider.dart';
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:google_fonts/google_fonts.dart';

// Mock Service
class MockFilePickerService implements FilePickerService {
  final String filePath;
  MockFilePickerService(this.filePath);

  @override
  Future<FilePickerResult?> pickFiles() async {
    // Simulate user delay
    await Future.delayed(const Duration(milliseconds: 500));
    return FilePickerResult([
      PlatformFile(
        path: filePath,
        name: 'test_image.png',
        size: 1024,
      ),
    ]);
  }
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  GoogleFonts.config.allowRuntimeFetching = false;
  
  // Test-specific overrides
  // We will override the theme in the test widget pump to enforce a standard font


  testWidgets('End-to-end test: Open app, pick file and view it', (WidgetTester tester) async {
    // 1. Setup Mock File
    final directory = await getTemporaryDirectory();
    final file = File('${directory.path}/test_image.png');
    
    // Create a simple 1x1 transparent PNG
    final List<int> pngBytes = [
      0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A, 0x00, 0x00, 0x00, 0x0D, 
      0x49, 0x48, 0x44, 0x52, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x01, 
      0x08, 0x06, 0x00, 0x00, 0x00, 0x1F, 0x15, 0xC4, 0x89, 0x00, 0x00, 0x00, 
      0x0A, 0x49, 0x44, 0x41, 0x54, 0x78, 0x9C, 0x63, 0x00, 0x01, 0x00, 0x00, 
      0x05, 0x00, 0x01, 0x0D, 0x0A, 0x2D, 0xB4, 0x00, 0x00, 0x00, 0x00, 0x49, 
      0x45, 0x4E, 0x44, 0xAE, 0x42, 0x60, 0x82
    ];
    await file.writeAsBytes(pngBytes);
    
    print('Created mock file at: ${file.path}');

    // 2. Pump App with Mock Service
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => LocaleProvider()),
          Provider<FilePickerService>(create: (_) => MockFilePickerService(file.path)),
        ],
        child: MyApp(theme: ThemeData.dark()), // Use basic theme for tests
      ),
    );

    // Initial pump to load widget tree
    await tester.pump(); 
    // Wait a bit for async logic but DO NOT use pumpAndSettle due to infinite animation in HomeScreen background
    await tester.pump(const Duration(seconds: 2));

    // 3. Verify Home Screen
    expect(find.text('MviewerPlus'), findsOneWidget); // App Title
    expect(find.text('The Universal File Reader'), findsOneWidget); // Subtitle

    // 4. Tap "Open File" button
    final openButton = find.byIcon(Icons.add_rounded);
    expect(openButton, findsOneWidget);

    await tester.tap(openButton);
    await tester.pump(); // Start tap animation

    // Wait for mocked file picking logic (500ms delay in mock) + navigation
    // We wait enough time for the screen transition to happen
    await tester.pump(const Duration(seconds: 3));

    // 5. Verify Navigation to ViewerScreen
    // Check if we found the Share icon which is typically present in ViewerScreen AppBar
    expect(find.byIcon(Icons.share), findsOneWidget); 
    
    // Also verify that we are likely not on the home screen anymore by checking for absence of "Open File" button (if covered)
    // or just assume the presence of Share icon is enough proof of navigation.
    
    print('Integration test finished successfully.');
  });
}
