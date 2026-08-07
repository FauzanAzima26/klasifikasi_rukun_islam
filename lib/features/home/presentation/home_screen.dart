import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../models/home_menu.dart';
import '../models/rukun_item.dart';
import '../widgets/app_bottom_navigation.dart';
import '../widgets/app_header.dart';
import '../widgets/hero_card.dart';
import '../widgets/quick_menu_card.dart';
import '../widgets/rukun_card.dart';
import '../widgets/home_search_bar.dart';
import '../widgets/section_header.dart';
import '../widgets/verse_card.dart';
import '../widgets/empty_activity.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<HomeMenuItem> _menuItems = [
    const HomeMenuItem(
      title: 'Klasifikasi',
      icon: Icons.analytics_rounded,
      backgroundColor: AppColors.primarySoft,
    ),
    HomeMenuItem(
      title: 'Riwayat',
      icon: Icons.history_rounded,
      backgroundColor: AppColors.accentGold.withValues(alpha: 0.16),
    ),
    HomeMenuItem(
      title: 'Profil',
      icon: Icons.person_rounded,
      backgroundColor: AppColors.success.withValues(alpha: 0.16),
    ),
    const HomeMenuItem(
      title: 'Tentang',
      icon: Icons.info_rounded,
      backgroundColor: AppColors.primarySoft,
    ),
  ];

  final List<RukunItem> _rukunItems = const [
    RukunItem(
      title: 'Syahadat',
      icon: Icons.book_rounded,
      color: Color(0xFF7C3AED),
    ),
    RukunItem(
      title: 'Shalat',
      icon: Icons.self_improvement_rounded,
      color: Color(0xFF0EA5E9),
    ),
    RukunItem(
      title: 'Zakat',
      icon: Icons.volunteer_activism_rounded,
      color: Color(0xFFF59E0B),
    ),
    RukunItem(
      title: 'Puasa',
      icon: Icons.wb_sunny_rounded,
      color: Color(0xFF16A34A),
    ),
    RukunItem(
      title: 'Haji',
      icon: Icons.flight_takeoff_rounded,
      color: Color(0xFFC27803),
    ),
  ];

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final rukunColumns = width > 720 ? 3 : 2;

    return Scaffold(
      backgroundColor: AppColors.background,
      bottomNavigationBar: AppBottomNavigation(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              sliver: SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const AppHeader(
                      greeting: 'Assalamu\'alaikum',
                      subtitle: 'Selamat Datang',
                    ),
                    const SizedBox(height: 24),
                    HeroCard(
                      title: 'Mulai Belajar Rukun Islam',
                      description:
                          'Pelajari kandungan ayat Al-Qur\'an mengenai lima Rukun Islam menggunakan teknologi klasifikasi.',
                      onPressed: () {},
                    ),
                    const SizedBox(height: 24),
                    const HomeSearchBar(),
                    const SizedBox(height: 24),
                    const SectionHeader(
                      title: 'Menu Cepat',
                      subtitle: 'Navigasi fitur utama aplikasi.',
                    ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              sliver: SliverGrid(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final item = _menuItems[index];
                    return QuickMenuCard(item: item);
                  },
                  childCount: _menuItems.length,
                ),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.3,
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
              sliver: SliverToBoxAdapter(
                child: const SectionHeader(
                  title: 'Rukun Islam',
                  subtitle: 'Pelajari setiap rukun secara bertahap.',
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              sliver: SliverGrid(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final item = _rukunItems[index];
                    return RukunCard(item: item);
                  },
                  childCount: _rukunItems.length,
                ),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: rukunColumns,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.3,
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
              sliver: SliverToBoxAdapter(
                child: const SectionHeader(
                  title: 'Ayat Hari Ini',
                  subtitle: 'Jangan lupa membaca ayat hari ini.',
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
              sliver: SliverToBoxAdapter(
                child: const VerseCard(
                  surahNumber: '2',
                  surahName: 'Al-Baqarah',
                  verseText: 'Yang telah Kami turunkan kepadamu Al-Qur\'an sebagai penjelas segala sesuatu.',
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
              sliver: SliverToBoxAdapter(
                child: const SectionHeader(
                  title: 'Aktivitas Terakhir',
                  subtitle: 'Riwayat klasifikasi akan muncul di sini.',
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
              sliver: SliverToBoxAdapter(
                child: const EmptyActivity(
                  title: 'Belum ada riwayat klasifikasi.',
                  subtitle: 'Aktivitas terakhir akan ditampilkan setelah kamu melakukan klasifikasi.',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
