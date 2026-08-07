import 'package:flutter/material.dart';

import '../models/rukun_item.dart';
import '../../../core/theme/app_text_styles.dart';

class RukunCard extends StatelessWidget {
  const RukunCard({super.key, required this.item});

  final RukunItem item;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: item.color.withValues(alpha: 0.16),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(item.icon, color: item.color),
              ),
              const Spacer(),
              Flexible(
                child: Text(
                  item.title,
                  style: AppTextStyles.bodyLarge,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.bottomRight,
                child: Icon(Icons.arrow_forward_rounded, color: item.color),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
