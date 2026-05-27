import 'package:flutter/material.dart';

import 'screens/main_nav_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const StoneSnapApp());
}

class StoneSnapApp extends StatelessWidget {
  const StoneSnapApp({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: Colors.tealAccent,
      brightness: Brightness.dark,
    );

    return MaterialApp(
      title: 'StoneSnap',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: colorScheme,
        scaffoldBackgroundColor: const Color(0xFF0D0F14),
        cardColor: const Color(0xFF171A22),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF0D0F14),
          foregroundColor: Colors.white,
        ),
      ),
      home: const MainNavScreen(),
    );
  }
}
