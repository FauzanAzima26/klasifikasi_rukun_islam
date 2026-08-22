class HistoryItem {
  final dynamic id;
  final String label;
  final double confidence;
  final String status;
  final String surahName;
  final int verseNumber;
  final String arabicText;
  final String translation;
  final String explanation;
  final DateTime createdAt;
  DateTime get date => createdAt;

  const HistoryItem({
    required this.id,
    required this.label,
    required this.confidence,
    required this.status,
    required this.surahName,
    required this.verseNumber,
    required this.arabicText,
    required this.translation,
    required this.explanation,
    required this.createdAt,
  });

  factory HistoryItem.fromHive(
    dynamic id,
    Map<String, dynamic> data,
  ) {
    return HistoryItem(
      id: id,
      label: data['label'] as String? ?? '-',
      confidence: (data['confidence'] as num?)?.toDouble() ?? 0,
      status: data['status'] as String? ?? '-',
      surahName: data['surahName'] as String? ?? '-',
      verseNumber: (data['verseNumber'] as num?)?.toInt() ?? 0,
      arabicText: data['arabicText'] as String? ?? '',
      translation: data['translation'] as String? ?? '',
      explanation: data['explanation'] as String? ?? '',
      createdAt: DateTime.tryParse(
            data['createdAt'] as String? ?? '',
          ) ??
          DateTime.now(),
    );
  }
}