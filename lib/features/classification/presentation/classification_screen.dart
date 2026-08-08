import 'package:flutter/material.dart';

import '../data/dummy_ayat.dart';
import '../models/ayat.dart';
import '../widgets/ayat_card.dart';
import '../widgets/preview_card.dart';
import '../widgets/loading_overlay.dart';
import '../widgets/error_dialog.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/app_primary_button.dart';

class ClassificationScreen extends StatefulWidget {
  const ClassificationScreen({super.key});

  @override
  State<ClassificationScreen> createState() => _ClassificationScreenState();
}

class _ClassificationScreenState extends State<ClassificationScreen>
    with SingleTickerProviderStateMixin {
  // Menyimpan data pilihan navigasi dropdown
  String? _selectedSurah;
  Ayat? _selectedAyat;
  bool _isLoading = false;
  bool _showDialog = false;

  late final AnimationController _animationController;
  late final Animation<Offset> _slideAnimation;
  late final Animation<double> _fadeAnimation;

  // 1. FITUR PILIH SURAH: Mengambil daftar nama surah unik secara otomatis dari data dummy
  List<String> get _surahList {
    return dummyAyat.map((ayat) => ayat.surahName).toSet().toList();
  }

  // 2. FILTER DROPDOWN AYAT: Menyaring daftar ayat berdasarkan surah yang dipilih
  List<Ayat> get _availableAyatList {
    if (_selectedSurah == null) return [];
    return dummyAyat.where((ayat) => ayat.surahName == _selectedSurah).toList();
  }

  @override
  void initState() {
    super.initState();

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

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // LOGIKA UTAMA: MEMICU PROSES ANALISIS & BERPINDAH KE HALAMAN HASIL
  Future<void> _handleAnalyze() async {
    setState(() {
      _isLoading = true;
    });

    // Simulasi waktu pemrosesan model kecerdasan buatan (AI) selama 500 milidetik
    await Future<void>.delayed(const Duration(milliseconds: 500));
    if (!mounted) return;

    if (_selectedAyat == null) {
      setState(() {
        _showDialog = true;
        _isLoading = false;
      });
      return;
    }

    setState(() {
      _isLoading = false;
    });
    if (!mounted) return;

    // INTEGRASI NAVIGASI: Otomatis masuk ke halaman hasil klasifikasi setelah loading selesai
    Navigator.pushNamed(context, '/result').then((_) {
      if (mounted) {
        setState(() {
          _selectedSurah = null;
          _selectedAyat = null;
        });
      }
    });
  }

  void _showErrorDialog() {
    if (!mounted) return;
    showDialog<void>(
      context: context,
      builder: (_) => ErrorDialog(
        message: 'Silakan coba beberapa saat lagi.',
        onClose: () {
          if (!mounted) return;
          setState(() {
            _showDialog = false;
          });
          Navigator.of(context).pop();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final surahs = _surahList;
    final dynamicAyatList = _availableAyatList;
    final isAnalyzeEnabled = _selectedAyat != null;

    // Untuk preview card default, jika belum memilih, ambil data dummy pertama agar tidak eror
    final previewAyat = _selectedAyat ?? dummyAyat.first;

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
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // DROPDOWN 1: PILIHAN SURAH
                      DropdownButtonFormField<String>(
                        key: ValueKey(_selectedSurah),
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
                            _selectedAyat =
                                null; // Reset pilihan ayat saat ganti surah
                          });
                        },
                      ),
                      const SizedBox(height: 16),

                      // DROPDOWN 2: PILIHAN NOMOR AYAT
                      DropdownButtonFormField<Ayat>(
                        key: ValueKey(_selectedAyat),
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
                            : (value) {
                                setState(() {
                                  _selectedAyat = value;
                                });
                              },
                      ),
                      const SizedBox(height: 24),

                      // TAMPILAN UTAMA KARTU AYAT YANG DIPILIH
                      Expanded(
                        child: _selectedAyat == null
                            ? Center(
                                child: Text(
                                  'Silakan tentukan surah and ayat untuk dianalisis.',
                                  textAlign: TextAlign.center,
                                  style: AppTextStyles.bodyLarge.copyWith(
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              )
                            : SingleChildScrollView(
                                child: AyatCard(
                                  ayat: _selectedAyat!,
                                  isSelected: true,
                                  onTap: () {},
                                ),
                              ),
                      ),
                      const SizedBox(height: 16),

                      // KARTU PRATINJAU (PREVIEW CARD)
                      PreviewCard(ayat: previewAyat),
                      const SizedBox(height: 16),

                      // TOMBOL EKSEKUSI KLASIFIKASI AI
                      AppPrimaryButton(
                        label: 'Analisis Ayat',
                        onPressed: isAnalyzeEnabled ? _handleAnalyze : null,
                        isExpanded: true,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (_isLoading) const LoadingOverlay(),
            if (_showDialog) _showErrorDialogWrapper(),
          ],
        ),
      ),
    );
  }

  Widget _showErrorDialogWrapper() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_showDialog) {
        _showErrorDialog();
      }
    });
    return const SizedBox.shrink();
  }
}
