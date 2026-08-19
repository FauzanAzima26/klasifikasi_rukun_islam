import '../data/surah_names.dart';

class Ayat {
  const Ayat({
    required this.surahNumber,
    required this.verseNumber,
    required this.arabicText,
    required this.translation,
    required this.tafsir,
  });

  final int surahNumber;
  final int verseNumber;
  final String arabicText;
  final String translation;
  final String tafsir;

  String get surahName {
    return surahNames[surahNumber] ?? 'Surah $surahNumber';
  }

  factory Ayat.fromJson(Map<String, dynamic> json) {
    return Ayat(
      surahNumber: json['surah'] as int,
      verseNumber: json['ayat'] as int,
      arabicText: json['arab'] as String,
      translation: json['terjemahan'] as String,
      tafsir: json['tafsir_short'] as String,
    );
  }
}