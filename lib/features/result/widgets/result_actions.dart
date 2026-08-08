import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/app_primary_button.dart';

class ResultActions extends StatelessWidget {
  const ResultActions({
    super.key,
    required this.onAnalyzeAgain,
    required this.onSaveHistory,
    required this.onShare,
  });

  final VoidCallback onAnalyzeAgain;
  final VoidCallback onSaveHistory;
  final VoidCallback onShare;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppPrimaryButton(
          label: 'Analisis Lagi',
          onPressed: onAnalyzeAgain,
          isExpanded: true,
        ),
        const SizedBox(height: 12),
        OutlinedButton(
          onPressed: onShare,
          style: OutlinedButton.styleFrom(
            minimumSize: const Size.fromHeight(52),
            side: const BorderSide(color: AppColors.primary),
          ),
          child: const Text('Bagikan'),
        ),
        const SizedBox(height: 12),
        TextButton(
          onPressed: onSaveHistory,
          style: TextButton.styleFrom(
            minimumSize: const Size.fromHeight(52),
          ),
          child: const Text('Simpan Riwayat'),
        ),
      ],
    );
  }
}
