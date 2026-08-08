class ClassificationResult {
  const ClassificationResult({
    required this.label,
    required this.status,
    required this.confidence,
    required this.surahName,
    required this.verseNumber,
    required this.arabicText,
    required this.translation,
    required this.explanation,
  });

  final String label;
  final String status;
  final int confidence;
  final String surahName;
  final int verseNumber;
  final String arabicText;
  final String translation;
  final String explanation;
}
