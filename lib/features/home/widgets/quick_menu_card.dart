import 'package:flutter/material.dart';

import '../models/home_menu.dart';
import '../../../core/theme/app_text_styles.dart';

class QuickMenuCard extends StatelessWidget {
  const QuickMenuCard({super.key, required this.item});

  final HomeMenuItem item;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          switch (item.title) {
            case 'Klasifikasi':
              Navigator.pushNamed(context, '/classification');
              break;
            case 'Riwayat':
              Navigator.pushNamed(context, '/history');
              break;
            case 'Profil':
              Navigator.pushNamed(context, '/profile');
              break;
            case 'Tentang':
              Navigator.pushNamed(context, '/about');
              break;
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: item.backgroundColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  item.icon,
                  color: Theme.of(context).colorScheme.onSurface,
                  size: 28,
                ),
              ),
              const SizedBox(height: 12),
              Flexible(
                child: Text(
                  item.title,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.bodyLarge,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
