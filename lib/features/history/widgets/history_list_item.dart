import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../models/history_item.dart';

class HistoryListItem extends StatelessWidget {
  const HistoryListItem({
    super.key,
    required this.item,
    required this.onTap,
    required this.onDelete,
  });

  final HistoryItem item;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  Color get _badgeColor {
    switch (item.label) {
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
    final monthNames = [
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember'
    ];
    final d = item.date.toLocal();
    final dateText = '${d.day.toString().padLeft(2, '0')} ${monthNames[d.month - 1]} ${d.year}';

    return Dismissible(
      key: ValueKey(item.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        color: AppColors.error,
        child: const Icon(Icons.delete_forever, color: Colors.white),
      ),
      confirmDismiss: (_) async {
        // Show confirmation handled by parent via onDelete
        onDelete();
        return false; // Parent handles deletion; keep in list for dummy behavior
      },
      child: Material(
        color: AppColors.surface,
        child: InkWell(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('${item.surahName} : ${item.verseNumber}', style: AppTextStyles.titleLarge.copyWith(color: AppColors.textPrimary)),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: _badgeColor.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(item.label, style: AppTextStyles.bodyMedium.copyWith(color: _badgeColor)),
                        ),
                        const SizedBox(height: 6),
                        Text('${item.confidence.toStringAsFixed(2)}%', style: AppTextStyles.bodyLarge.copyWith(color: AppColors.textPrimary)),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(item.translation, style: AppTextStyles.bodyLarge.copyWith(color: AppColors.textSecondary)),
                const SizedBox(height: 8),
                Text(dateText, style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
