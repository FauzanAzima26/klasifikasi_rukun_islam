import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../models/result.dart';

class ResultCard extends StatelessWidget {
  const ResultCard({
    super.key,
    required this.result,
  });

  final ClassificationResult result;

  Color get _badgeColor {
    switch (result.label) {
      case 'Shalat':
      case 'Syahadat':
        return AppColors.success;
      case 'Puasa':
        return AppColors.primary;
      case 'Haji':
        return AppColors.accentGold;
      case 'Zakat':
        return const Color(0xFF7C3AED);
      default:
        return AppColors.textSecondary;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.primarySoft,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(result.label, style: AppTextStyles.displayLarge.copyWith(color: AppColors.textPrimary)),
          const SizedBox(height: 12),
          Text(result.status, style: AppTextStyles.bodyLarge.copyWith(color: AppColors.textSecondary)),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: _badgeColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              result.label,
              style: AppTextStyles.bodyMedium.copyWith(color: _badgeColor),
            ),
          ),
        ],
      ),
    );
  }
}
