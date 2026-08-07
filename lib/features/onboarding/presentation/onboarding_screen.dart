import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/app_primary_button.dart';
import '../widgets/onboarding_indicator.dart';
import '../widgets/onboarding_page_content.dart';
import '../../home/presentation/home_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<_OnboardingData> _pages = [
    _OnboardingData(
      title: 'Kenali Kandungan Ayat Al-Qur\'an',
      description:
          'Temukan ayat Al-Qur\'an yang berkaitan dengan Rukun Islam melalui teknologi klasifikasi yang mudah dipahami.',
      icon: Icons.menu_book_rounded,
      accentColor: AppColors.primary,
    ),
    _OnboardingData(
      title: 'Belajar Lebih Mudah',
      description:
          'Pelajari kandungan ayat mengenai Syahadat, Shalat, Zakat, Puasa, dan Haji secara sederhana.',
      icon: Icons.school_rounded,
      accentColor: AppColors.accentGold,
    ),
    _OnboardingData(
      title: 'Mari Memulai',
      description:
          'Mulailah menjelajahi ayat Al-Qur\'an dan temukan kandungan Rukun Islam dengan mudah.',
      icon: Icons.rocket_launch_rounded,
      accentColor: AppColors.success,
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goToNextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      _pageController.animateToPage(
                        _pages.length - 1,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                    child: const Text('Skip'),
                  ),
                ],
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemCount: _pages.length,
                itemBuilder: (context, index) {
                  final page = _pages[index];
                  return OnboardingPageContent(
                    title: page.title,
                    description: page.description,
                    icon: page.icon,
                    accentColor: page.accentColor,
                  );
                },
              ),
            ),
            OnboardingIndicator(
              currentPage: _currentPage,
              itemCount: _pages.length,
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              child: AppPrimaryButton(
                label: _currentPage == _pages.length - 1
                    ? 'Get Started'
                    : 'Next',
                onPressed: _currentPage == _pages.length - 1
                    ? () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const HomeScreen(), // Pastikan nama class sesuai
                          ),
                        );
                      }
                    : _goToNextPage,
                isExpanded: true,
                icon: Icons.arrow_forward_rounded,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OnboardingData {
  const _OnboardingData({
    required this.title,
    required this.description,
    required this.icon,
    required this.accentColor,
  });

  final String title;
  final String description;
  final IconData icon;
  final Color accentColor;
}
