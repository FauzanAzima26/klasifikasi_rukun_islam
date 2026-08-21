import 'package:flutter/material.dart';

import '../models/result.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final result =
        ModalRoute.of(context)?.settings.arguments as ClassificationResult?;

    if (result == null) {
      return const Scaffold(
        body: Center(
          child: Text(
            'Data hasil klasifikasi tidak tersedia.',
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: Text(
          'Hasil Klasifikasi',
          style: AppTextStyles.titleLarge.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,

            children: [
              Text(
                'Hasil Klasifikasi',
                style: AppTextStyles.titleLarge,
              ),

              const SizedBox(height: 24),

              Text(
                'Label',
                style: AppTextStyles.bodyMedium,
              ),

              const SizedBox(height: 8),

              Text(
                result.label,
                style: AppTextStyles.titleLarge.copyWith(
                  color: AppColors.primary,
                ),
              ),

              const SizedBox(height: 24),

              Text(
                'Confidence',
                style: AppTextStyles.bodyMedium,
              ),

              const SizedBox(height: 8),

              Text(
                '${result.confidence}%',
                style: AppTextStyles.titleLarge,
              ),

              const SizedBox(height: 24),

              Text(
                'Status',
                style: AppTextStyles.bodyMedium,
              ),

              const SizedBox(height: 8),

              Text(
                result.status,
                style: AppTextStyles.bodyLarge,
              ),

              const SizedBox(height: 24),

              Text(
                'Surah',
                style: AppTextStyles.bodyMedium,
              ),

              Text(
                result.surahName,
                style: AppTextStyles.bodyLarge,
              ),

              const SizedBox(height: 16),

              Text(
                'Ayat ${result.verseNumber}',
                style: AppTextStyles.bodyLarge,
              ),

              const SizedBox(height: 24),

              Text(
                'Penjelasan',
                style: AppTextStyles.bodyMedium,
              ),

              const SizedBox(height: 8),

              Text(
                result.explanation,
                style: AppTextStyles.bodyLarge,
              ),
            ],
          ),
        ),
      ),
    );
  }
}