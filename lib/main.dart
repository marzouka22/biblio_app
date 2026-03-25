import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'controllers/auth_controller.dart';
import 'utils/app_theme.dart';
import 'views/main_layout.dart';
// import 'firebase_options.dart'; // Uncomment once configured via flutterfire

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  // Pour production, utilisez: flutterfire configure
  try {
    await Firebase.initializeApp(
      // options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    print(
      "Firebase initialization failed/skipped (expected if not configured): $e",
    );
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthController()..initialize()),
        // Add other providers here (e.g., LibraryController, EventController)
      ],
      child: MaterialApp(
        title: 'BiblioQuartier',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme(),
        darkTheme: AppTheme.darkTheme(),
        themeMode: ThemeMode.system,
        home: const MainLayout(),
      ),
    );
  }
}
