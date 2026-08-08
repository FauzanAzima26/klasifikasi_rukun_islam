import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../models/ayat.dart';

class PreviewCard extends StatelessWidget {
  const PreviewCard({
    super.key,
    required this.ayat,
  });

  final Ayat ayat;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Preview', style: AppTextStyles.titleLarge.copyWith(color: AppColors.primary)),
          const SizedBox(height: 16),
          Text(ayat.surahName, style: AppTextStyles.labelLarge.copyWith(color: AppColors.textPrimary)),
          const SizedBox(height: 8),
          Text(
            ayat.arabicText,
            style: AppTextStyles.arabicDisplay,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 12),
          Text(
            ayat.translation,
            style: AppTextStyles.bodyLarge.copyWith(color: AppColors.textSecondary),
          ),
          const SizedBox(height: 14),
          Text('Kategori: ${ayat.category}', style: AppTextStyles.bodyMedium.copyWith(color: AppColors.primary)),
        ],
      ),
    );
  }
}
