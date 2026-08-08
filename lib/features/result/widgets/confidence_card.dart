import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../models/result.dart';

class ConfidenceCard extends StatelessWidget {
  const ConfidenceCard({
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
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Confidence', style: AppTextStyles.titleLarge.copyWith(color: AppColors.textPrimary)),
          const SizedBox(height: 14),
          LinearProgressIndicator(
            value: result.confidence / 100,
            color: AppColors.primary,
            backgroundColor: AppColors.border,
            minHeight: 10,
          ),
          const SizedBox(height: 12),
          Text('${result.confidence}%', style: AppTextStyles.bodyLarge.copyWith(color: AppColors.textPrimary)),
        ],
      ),
    );
  }
}
