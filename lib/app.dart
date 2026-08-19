import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';
import 'features/splash/presentation/splash_screen.dart';
import 'features/onboarding/presentation/onboarding_screen.dart';
import 'features/home/presentation/home_screen.dart';
import 'features/classification/presentation/classification_screen.dart'; // Import halaman klasifikasi Anda
import 'features/result/presentation/result_screen.dart';
import 'features/history/presentation/history_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rukun Islam',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      
      // KONFIGURASI NAVIGASI BAWAAN FLUTTER
      initialRoute: '/', // Aplikasi otomatis memulai dari rute '/' (Splash)
      routes: {
        '/': (context) => const SplashScreen(),
        '/onboarding': (context) => const OnboardingScreen(),
        '/home': (context) => const HomeScreen(),
        '/classification': (context) => const ClassificationScreen(),
        '/result': (context) => const ResultScreen(),
        '/history': (context) => const HistoryScreen(),
      },
    );
  }
}
