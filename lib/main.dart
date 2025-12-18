import 'package:file_viewer/screens/home_screen.dart';
import 'package:file_viewer/theme/app_theme.dart';
import 'package:flutter/foundation.dart'; // Para kReleaseMode
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:file_viewer/l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:file_viewer/providers/locale_provider.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:file_viewer/services/app_signature_validator.dart';

import 'dart:async'; 
import 'dart:ui'; // Para PlatformDispatcher
import 'package:flutter/services.dart'; 
import 'package:file_viewer/services/file_picker_service.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 1. Captura de Erros Assíncronos (PlatformDispatcher)
  // Trata erros de background, timers, I/O, etc.
  PlatformDispatcher.instance.onError = (error, stack) {
    debugPrint('🔴 Async Error Caught by PlatformDispatcher: $error');
    debugPrint('Stacktrace: $stack');
    return true; // Impede o crash do app
  };

  // 2. Captura de Erros de Interface (FlutterError)
  // Trata erros de renderização e layout
  FlutterError.onError = (FlutterErrorDetails details) {
    // Em debug, ainda queremos ver o log detalhado
    FlutterError.presentError(details);
    debugPrint('🔴 Flutter UI Error: ${details.exception}');
    debugPrint('Stacktrace: ${details.stack}');
  };

  // 3. A 'Tela de Desculpas' (Custom Error Widget)
  // Substitui a 'Tela Vermelha da Morte' em Produção
  ErrorWidget.builder = (FlutterErrorDetails details) {
    // Em debug, mostra o erro normal para facilitar o desenvolvimento
    if (kDebugMode) {
      return ErrorWidget(details.exception);
    }
    // Em release, mostra a tela amigável
    return const _GlobalErrorWidget();
  };

  // 4. Execução Blindada (runZonedGuarded)
  runZonedGuarded(() async {
    // Bloquear orientação na vertical (Portrait)
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    
    // Carregar variáveis de ambiente
    await dotenv.load(fileName: ".env");
    
    // Inicializar Firebase
    try {
       await Firebase.initializeApp();
       // Inicializar Remote Config para hashes de apps
       await TrustedAppHashesService.instance.initialize();
    } catch (e, s) {
       debugPrint('Firebase initialization failed: $e');
       debugPrint(s.toString());
    }

    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => LocaleProvider()),
          Provider<FilePickerService>(create: (_) => FilePickerService()),
        ],
        child: const MyApp(),
      ),
    );
  }, (error, stack) {
    debugPrint('🔴 Uncaught Error in Zone: $error');
    debugPrint('Stacktrace: $stack');
    // Note: We cannot show a UI widget here directly for background threads, 
    // but PlatformDispatcher + FlutterError covers the UI part.
  });
}

class _GlobalErrorWidget extends StatelessWidget {
  const _GlobalErrorWidget();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('pt', 'BR'),
        Locale('pt', 'PT'),
        Locale('es'),
      ],
      home: Builder(
        builder: (context) {
          final t = AppLocalizations.of(context);
          // Fallback if localization fails
          final title = t?.globalErrorTitle ?? 'Ops, algo não saiu como esperado.';
          final desc = t?.globalErrorDesc ?? 'Não se preocupe, seus dados estão seguros.';
          final btn = t?.backToHome ?? 'Voltar para o Início';

          return Scaffold(
            backgroundColor: const Color(0xFFFAFAFA),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Design "Recovery Mode" - Repair Icon
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.blue.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.build_rounded, // Repair icon as requested
                        color: Colors.blueAccent,
                        size: 64,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      title,
                      style: GoogleFonts.outfit(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF2D3748),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      desc,
                      style: GoogleFonts.outfit(
                        fontSize: 16,
                        color: const Color(0xFF718096),
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 48),
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          // Try to recover state by fully restarting to Home
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (context) => const HomeScreen()),
                            (route) => false,
                          );
                        },
                        icon: const Icon(Icons.refresh_rounded),
                        label: Text(btn, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  final ThemeData? theme; // Allow overriding theme for testing
  const MyApp({super.key, this.theme});

  @override
  Widget build(BuildContext context) {
    return Consumer<LocaleProvider>(
      builder: (context, localeProvider, child) {
        return MaterialApp(
          title: 'MviewerPlus',
          debugShowCheckedModeBanner: false,
          theme: theme ?? AppTheme.darkTheme,
          locale: localeProvider.locale, // Uses the provider's locale
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en'),
            Locale('pt', 'BR'),
            Locale('pt', 'PT'),
            Locale('es'),
          ],
          home: const HomeScreen(),
        );
      },
    );
  }
}
