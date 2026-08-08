import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class LoadingOverlay extends StatelessWidget {
  const LoadingOverlay({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.textPrimary.withValues(alpha: 0.12),
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
