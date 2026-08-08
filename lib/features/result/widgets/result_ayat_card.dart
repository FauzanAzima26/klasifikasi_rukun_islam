import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../models/result.dart';

class ResultAyatCard extends StatelessWidget {
  const ResultAyatCard({
    super.key,
    required this.result,
  });

  final ClassificationResult result;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(result.surahName, style: AppTextStyles.titleLarge.copyWith(color: AppColors.textPrimary)),
              Text('Ayat ${result.verseNumber}', style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary)),
            ],
          ),
          const SizedBox(height: 18),
          Text(
            result.arabicText,
            textAlign: TextAlign.center,
            style: AppTextStyles.arabicDisplay.copyWith(fontSize: 30, height: 2.0),
          ),
          const SizedBox(height: 18),
          Text(
            result.translation,
            textAlign: TextAlign.justify,
            style: AppTextStyles.bodyLarge.copyWith(color: AppColors.textSecondary),
          ),
          const SizedBox(height: 18),
          Align(
            alignment: Alignment.centerRight,
            child: Text('Surah ${result.surahName}', style: AppTextStyles.bodyMedium.copyWith(color: AppColors.primary)),
          ),
        ],
      ),
    );
  }
}
