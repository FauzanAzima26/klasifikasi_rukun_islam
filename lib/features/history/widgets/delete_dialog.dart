import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class DeleteDialog extends StatelessWidget {
  const DeleteDialog({
    super.key,
    required this.title,
    required this.onConfirm,
  });

  final String title;
  final VoidCallback onConfirm;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Hapus riwayat', style: AppTextStyles.titleLarge.copyWith(color: AppColors.textPrimary)),
      content: Text(title, style: AppTextStyles.bodyLarge.copyWith(color: AppColors.textSecondary)),
      actions: [
        TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Batal')),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            onConfirm();
          },
          child: const Text('Hapus'),
        ),
      ],
    );
  }
}
