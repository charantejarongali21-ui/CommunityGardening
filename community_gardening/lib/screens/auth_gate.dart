import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:community_gardening/state/app_state.dart';
import 'package:community_gardening/screens/login_screen.dart';
import 'package:community_gardening/screens/main_shell.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    if (state.loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    if (state.user == null) return const LoginScreen();
    return const MainShell();
  }
}
