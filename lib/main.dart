import 'package:file_viewer/screens/home_screen.dart';
import 'package:file_viewer/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:file_viewer/l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:file_viewer/providers/locale_provider.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:file_viewer/services/app_signature_validator.dart';

import 'dart:async'; 
import 'package:flutter/services.dart'; // Importante para SystemChrome

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

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
  } catch (e) {
     debugPrint('Firebase initialization failed: $e');
  }
  
  // 3. Configurar tratamento global de erros (PROMPT PADRÃO)
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    debugPrint('🔴 Flutter Framework Error: ${details.exception}');
    debugPrint('Stacktrace: ${details.stack}');
    // Aqui poderia enviar para Sentry/Crashlytics
  };

  runZonedGuarded(() {
    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => LocaleProvider()),
        ],
        child: const MyApp(),
      ),
    );
  }, (error, stack) {
    debugPrint('🔴 Uncaught Async Error: $error');
    debugPrint('Stacktrace: $stack');
    // Aqui poderia enviar para Sentry/Crashlytics
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LocaleProvider>(
      builder: (context, localeProvider, child) {
        return MaterialApp(
          title: 'MviewerPlus',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.darkTheme,
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
