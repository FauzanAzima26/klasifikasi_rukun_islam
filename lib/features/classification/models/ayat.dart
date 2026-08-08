class Ayat {
  const Ayat({
    required this.surahName,
    required this.verseNumber,
    required this.arabicText,
    required this.translation,
    required this.category,
  });

  final String surahName;
  final int verseNumber;
  final String arabicText;
  final String translation;
  final String category;
}
