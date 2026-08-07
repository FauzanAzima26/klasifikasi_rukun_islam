import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class EmptyActivity extends StatelessWidget {
  const EmptyActivity({
    super.key,
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.history_rounded, size: 48, color: AppColors.textSecondary),
          const SizedBox(height: 16),
          Text(title, style: AppTextStyles.titleLarge, textAlign: TextAlign.center),
          const SizedBox(height: 8),
          Text(subtitle, style: AppTextStyles.bodyLarge, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
