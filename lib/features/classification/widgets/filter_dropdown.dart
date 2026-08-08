import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class FilterDropdown extends StatelessWidget {
  const FilterDropdown({
    super.key,
    required this.selectedValue,
    required this.options,
    required this.onChanged,
  });

  final String selectedValue;
  final List<String> options;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedValue,
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.textSecondary),
          items: options
              .map((option) => DropdownMenuItem(
                    value: option,
                    child: Text(option, style: AppTextStyles.bodyLarge.copyWith(color: AppColors.textPrimary)),
                  ))
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
