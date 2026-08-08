import 'package:flutter/material.dart';

import '../data/dummy_result.dart';
import '../models/result.dart';
import '../widgets/result_card.dart';
import '../widgets/confidence_card.dart';
import '../widgets/result_ayat_card.dart';
import '../widgets/explanation_card.dart';
import '../widgets/result_actions.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ClassificationResult result = dummyResult;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: Text('Hasil Klasifikasi', style: AppTextStyles.titleLarge.copyWith(color: AppColors.textPrimary)),
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              sliver: SliverList(
                delegate: SliverChildListDelegate(
                  [
                    ResultCard(result: result),
                    const SizedBox(height: 20),
                    ConfidenceCard(result: result),
                    const SizedBox(height: 20),
                    ResultAyatCard(result: result),
                    const SizedBox(height: 20),
                    ExplanationCard(result: result),
                    const SizedBox(height: 24),
                    ResultActions(
                      onAnalyzeAgain: () {
                        Navigator.pushNamed(context, '/classification');
                      },
                      onSaveHistory: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Simpan Riwayat dummy.')),
                        );
                      },
                      onShare: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Bagikan dummy.')),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
