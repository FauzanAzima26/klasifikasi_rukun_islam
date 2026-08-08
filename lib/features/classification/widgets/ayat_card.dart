import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../models/ayat.dart';

class AyatCard extends StatelessWidget {
  const AyatCard({
    super.key,
    required this.ayat,
    required this.isSelected,
    required this.onTap,
  });

  final Ayat ayat;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isSelected ? AppColors.primarySoft : AppColors.surface,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          constraints: const BoxConstraints(minHeight: 112),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(ayat.surahName, style: AppTextStyles.labelLarge.copyWith(color: AppColors.primary)),
              const SizedBox(height: 8),
              Text(
                ayat.arabicText,
                style: AppTextStyles.arabicDisplay,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              Text(
                ayat.translation,
                style: AppTextStyles.bodyLarge.copyWith(color: AppColors.textSecondary),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const Spacer(),
              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  'Ayat ${ayat.verseNumber}',
                  style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
