import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import '../theme.dart';
import 'loading_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Film strip background (simplified with a gradient and patterns)
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    CineVibeTheme.background,
                    CineVibeTheme.background.withOpacity(0.8),
                    CineVibeTheme.background,
                  ],
                ),
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FadeInDown(
                  duration: const Duration(milliseconds: 1000),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: CineVibeTheme.accent, width: 2),
                    ),
                    child: const Icon(
                      Icons.movie_filter,
                      size: 80,
                      color: CineVibeTheme.accent,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                FadeInUp(
                  duration: const Duration(milliseconds: 1000),
                  child: Text(
                    'CineVibe',
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      fontSize: 48,
                      color: CineVibeTheme.accent,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                FadeIn(
                  delay: const Duration(milliseconds: 500),
                  child: const Text(
                    'Music meets Cinema',
                    style: TextStyle(
                      color: Colors.white54,
                      fontSize: 16,
                      letterSpacing: 2,
                    ),
                  ),
                ),
                const SizedBox(height: 60),
                FadeInUp(
                  delay: const Duration(milliseconds: 800),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // Mocking login for now
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const LoadingScreen()),
                      );
                    },
                    icon: const Icon(Icons.music_note, color: Colors.white),
                    label: const Text('Connect with Spotify'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: CineVibeTheme.spotifyGreen,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
