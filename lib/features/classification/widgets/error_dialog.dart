import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class ErrorDialog extends StatelessWidget {
  const ErrorDialog({
    super.key,
    required this.message,
    required this.onClose,
  });

  final String message;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Terjadi Kesalahan', style: AppTextStyles.titleLarge.copyWith(color: AppColors.textPrimary)),
      content: Text(message, style: AppTextStyles.bodyLarge.copyWith(color: AppColors.textSecondary)),
      actions: [
        TextButton(
          onPressed: onClose,
          child: const Text('Tutup'),
        ),
      ],
    );
  }
}
