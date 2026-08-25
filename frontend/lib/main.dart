import 'package:flutter/material.dart';
import 'theme.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const CineVibeApp());
}

class CineVibeApp extends StatelessWidget {
  const CineVibeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CineVibe',
      debugShowCheckedModeBanner: false,
      theme: CineVibeTheme.darkTheme,
      home: const LoginScreen(),
    );
  }
}
