import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class VerseCard extends StatelessWidget {
  const VerseCard({
    super.key,
    required this.surahNumber,
    required this.surahName,
    required this.verseText,
  });

  final String surahNumber;
  final String surahName;
  final String verseText;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: AppColors.primarySoft,
                child: Text(
                  surahNumber,
                  style: AppTextStyles.bodyLarge.copyWith(color: AppColors.primary),
                ),
              ),
              const SizedBox(width: 12),
              Text(surahName, style: AppTextStyles.titleLarge),
              const Spacer(),
              TextButton(
                onPressed: () {},
                child: const Text('Baca Selengkapnya'),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            verseText,
            style: AppTextStyles.bodyLarge,
          ),
        ],
      ),
    );
  }
}
