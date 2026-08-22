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
  final double confidence;
  final String surahName;
  final int verseNumber;
  final String arabicText;
  final String translation;
  final String explanation;

  factory ClassificationResult.fromJson(
    Map<String, dynamic> json,
  ) {
    return ClassificationResult(
      label: json['label'] ?? 'Tidak diketahui',

      status: json['status'] ?? '',

      confidence: (json['confidence'] ?? 0) as double,

      surahName: json['surahName'] ?? '',

      verseNumber: (json['verseNumber'] ?? 0) as int,

      arabicText: json['arabicText'] ?? '',

      translation: json['translation'] ?? '',

      explanation: json['explanation'] ?? '',
    );
  }
}