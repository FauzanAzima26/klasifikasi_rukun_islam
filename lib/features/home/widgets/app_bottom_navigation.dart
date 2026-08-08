import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class AppBottomNavigation extends StatefulWidget {
  const AppBottomNavigation({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  State<AppBottomNavigation> createState() => _AppBottomNavigationState();
}

class _AppBottomNavigationState extends State<AppBottomNavigation> {
  void _handleNavigation(int index) {
    // Jika menekan ikon yang sama dengan halaman aktif saat ini, abaikan agar tidak refresh berulang
    if (index == widget.currentIndex) return;

    // Alur perpindahan halaman menggunakan Named Routes sesuai dengan indeks menu
    switch (index) {
      case 0:
        // Gunakan pushNamedAndRemoveUntil agar tumpukan halaman lama dibersihkan saat kembali ke Home
        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
        break;
      case 1:
        Navigator.pushNamed(context, '/classification');
        break;
      case 2:
        Navigator.pushNamed(context, '/history'); // Pastikan sudah didaftarkan di app.dart jika layarnya ada
        break;
      case 3:
        Navigator.pushNamed(context, '/profile'); // Pastikan sudah didaftarkan di app.dart jika layarnya ada
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: widget.currentIndex, // Menggunakan widget.currentIndex yang benar
      onTap: (index) {
        // 1. Jalankan fungsi navigasi otomatis ke halaman baru
        _handleNavigation(index);
        // 2. Tetap kirimkan callback onTap ke widget induk jika diperlukan
        widget.onTap(index);
      },
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.textSecondary,
      showUnselectedLabels: true,
      selectedLabelStyle: const TextStyle(fontSize: 11),
      unselectedLabelStyle: const TextStyle(fontSize: 11),
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_rounded),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.analytics_rounded),
          label: 'Classification',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.history_rounded),
          label: 'History',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_rounded),
          label: 'Profile',
        ),
      ],
    );
  }
}
