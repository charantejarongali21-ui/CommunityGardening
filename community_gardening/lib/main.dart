import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'state/app_state.dart';
import 'package:community_gardening/screens/auth_gate.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ChangeNotifierProvider(
      create: (_) => AppState(),
      child: const CommunityGardeningApp(),
    ),
  );
}

class CommunityGardeningApp extends StatelessWidget {
  const CommunityGardeningApp({super.key});

  @override
  Widget build(BuildContext context) {
    const forest = Color(0xFF285C3B);
    return MaterialApp(
      title: 'Community Gardening',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: forest,
          primary: forest,
          secondary: const Color(0xFF8BAF68),
          surface: const Color(0xFFF7F8F2),
        ),
        scaffoldBackgroundColor: const Color(0xFFF7F8F2),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFF7F8F2),
          foregroundColor: Color(0xFF203B2B),
          elevation: 0,
          centerTitle: false,
        ),
        cardTheme: CardThemeData(
          color: Colors.white,
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
      ),
      home: const AuthGate(),
    );
  }
}
