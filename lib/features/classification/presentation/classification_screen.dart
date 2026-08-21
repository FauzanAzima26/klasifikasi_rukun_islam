import 'package:flutter/material.dart';

import '../../../core/services/quran_service.dart';
import '../models/ayat.dart';
import '../widgets/ayat_card.dart';
import '../widgets/loading_overlay.dart';
// import '../widgets/error_dialog.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/app_primary_button.dart';
import '../../../core/services/api_service.dart';

class ClassificationScreen extends StatefulWidget {
  const ClassificationScreen({super.key});

  @override
  State<ClassificationScreen> createState() => _ClassificationScreenState();
}

class _ClassificationScreenState extends State<ClassificationScreen>
    with SingleTickerProviderStateMixin {
  final QuranService _quranService = QuranService();
  final ApiService _apiService = ApiService();
  List<Ayat> _quranData = [];
  bool _isQuranLoading = true;
  String? _quranError;

  String? _selectedSurah;
  Ayat? _selectedAyat;
  bool _isLoading = false;
  // bool _showDialog = false;

  late final AnimationController _animationController;
  late final Animation<Offset> _slideAnimation;
  late final Animation<double> _fadeAnimation;

  // 1. FITUR PILIH SURAH: Mengambil daftar nama surah unik secara otomatis dari data dummy
  List<String> get _surahList {
    return _quranData.map((ayat) => ayat.surahName).toSet().toList();
  }

  // 2. FILTER DROPDOWN AYAT: Menyaring daftar ayat berdasarkan surah yang dipilih
  List<Ayat> get _availableAyatList {
    if (_selectedSurah == null) return [];
    return _quranData
        .where((ayat) => ayat.surahName == _selectedSurah)
        .toList();
  }

  @override
  void initState() {
    super.initState();

    _loadQuran();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.1), end: Offset.zero).animate(
          CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
        );

    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    );

    _animationController.forward();
  }

  Future<void> _loadQuran() async {
    try {
      final data = await _quranService.loadQuran();

      if (!mounted) return;

      setState(() {
        _quranData = data;
        _isQuranLoading = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _isQuranLoading = false;
        _quranError = e.toString();
      });

      debugPrint('Gagal memuat quran.json: $e');
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // LOGIKA UTAMA: MEMICU PROSES ANALISIS & BERPINDAH KE HALAMAN HASIL
  Future<void> _handleAnalyze() async {
    if (_selectedAyat == null) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      print('========== MULAI KLASIFIKASI ==========');

      print(
        'Ayat: ${_selectedAyat!.surahName} '
        '${_selectedAyat!.verseNumber}',
      );

      print('Terjemahan:');
      print(_selectedAyat!.translation);

      print('Tafsir:');
      print(_selectedAyat!.tafsir);

      // Kirim ayat ke backend
      final result = await _apiService.classify(ayat: _selectedAyat!);

      print('========== HASIL API ==========');
      print('Label: ${result.label}');
      print('Confidence: ${result.confidence}');
      print('================================');

      if (!mounted) return;

      setState(() {
        _isLoading = false;
      });

      // Kirim ClassificationResult ke ResultScreen
      Navigator.pushNamed(context, '/result', arguments: result);
    } catch (e) {
      print('========== ERROR KLASIFIKASI ==========');
      print(e);
      print('=======================================');

      if (!mounted) return;

      setState(() {
        _isLoading = false;
      });

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Klasifikasi gagal: $e')));
    }
  }

  // void _showErrorDialog() {
  //   if (!mounted) return;
  //   showDialog<void>(
  //     context: context,
  //     builder: (_) => ErrorDialog(
  //       message: 'Silakan coba beberapa saat lagi.',
  //       onClose: () {
  //         if (!mounted) return;
  //         setState(() {
  //           _showDialog = false;
  //         });
  //         Navigator.of(context).pop();
  //       },
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    if (_isQuranLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (_quranError != null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Klasifikasi Ayat')),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Text(
              'Gagal memuat data Al-Qur’an.\n\n$_quranError',
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    }

    final surahs = _surahList;
    final dynamicAyatList = _availableAyatList;
    final isAnalyzeEnabled = _selectedAyat != null;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: AppColors.textPrimary,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Klasifikasi Ayat',
          style: AppTextStyles.titleLarge.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // ==========================================
                      // DROPDOWN SURAH
                      // ==========================================
                      DropdownButtonFormField<String>(
                        initialValue: _selectedSurah,

                        hint: Text(
                          'Pilih Surah',
                          style: AppTextStyles.bodyMedium,
                        ),

                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),

                        items: surahs.map((surah) {
                          return DropdownMenuItem<String>(
                            value: surah,
                            child: Text(surah, style: AppTextStyles.bodyLarge),
                          );
                        }).toList(),

                        onChanged: (value) {
                          setState(() {
                            _selectedSurah = value;
                            _selectedAyat = null;
                          });

                          debugPrint('Surah dipilih: $_selectedSurah');

                          debugPrint(
                            'Jumlah ayat tersedia: ${_availableAyatList.length}',
                          );
                        },
                      ),

                      const SizedBox(height: 16),

                      // ==========================================
                      // DROPDOWN AYAT
                      // ==========================================
                      DropdownButtonFormField<Ayat>(
                        initialValue: _selectedAyat,

                        hint: Text(
                          _selectedSurah == null
                              ? 'Pilih surah terlebih dahulu'
                              : 'Pilih Nomor Ayat',
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: _selectedSurah == null
                                ? AppColors.textSecondary
                                : null,
                          ),
                        ),

                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          filled: true,
                          fillColor: _selectedSurah == null
                              ? Colors.grey[200]
                              : Colors.white,
                        ),

                        items: _selectedSurah == null
                            ? null
                            : dynamicAyatList.map((ayat) {
                                return DropdownMenuItem<Ayat>(
                                  value: ayat,
                                  child: Text(
                                    'Ayat ${ayat.verseNumber}',
                                    style: AppTextStyles.bodyLarge,
                                  ),
                                );
                              }).toList(),

                        onChanged: _selectedSurah == null
                            ? null
                            : (Ayat? value) {
                                if (value == null) return;

                                setState(() {
                                  _selectedAyat = value;
                                });

                                debugPrint(
                                  'Ayat dipilih: '
                                  '${value.surahName} ${value.verseNumber}',
                                );
                              },
                      ),

                      const SizedBox(height: 24),

                      if (_selectedAyat != null) ...[
                        AyatCard(
                          ayat: _selectedAyat!,
                          isSelected: true,
                          onTap: () {},
                        ),

                        const SizedBox(height: 20),
                      ] else ...[
                        SizedBox(
                          height: 180,
                          child: Center(
                            child: Text(
                              'Silakan tentukan surah dan ayat '
                              'untuk dianalisis.',
                              textAlign: TextAlign.center,
                              style: AppTextStyles.bodyLarge.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),
                      ],

                      // ==========================================
                      // TOMBOL ANALISIS
                      // ==========================================
                      AppPrimaryButton(
                        label: 'Analisis Ayat',
                        onPressed: isAnalyzeEnabled ? _handleAnalyze : null,
                        isExpanded: true,
                      ),

                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ),

            // ==========================================
            // LOADING
            // ==========================================
            if (_isLoading) const LoadingOverlay(),

            // if (_showDialog) _showErrorDialogWrapper(),
          ],
        ),
      ),
    );
  }

  // Widget _showErrorDialogWrapper() {
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     if (_showDialog) {
  //       _showErrorDialog();
  //     }
  //   });
  //   return const SizedBox.shrink();
  // }
}
