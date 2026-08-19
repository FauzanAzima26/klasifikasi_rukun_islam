class HistoryItem {
  const HistoryItem({
    required this.id,
    required this.label,
    required this.confidence,
    required this.surahName,
    required this.verseNumber,
    required this.arabicText,
    required this.translation,
    required this.date,
  });

  final String id;
  final String label;
  final int confidence;
  final String surahName;
  final int verseNumber;
  final String arabicText;
  final String translation;
  final DateTime date;
}
