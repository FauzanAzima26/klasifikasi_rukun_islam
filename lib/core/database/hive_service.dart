import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  static const String boxName = 'classification_history';

  static Box get box => Hive.box(boxName);

  static Future<void> saveClassification({
    required String label,
    required double confidence,
    required String status,
    required String surahName,
    required dynamic verseNumber,
    required String arabicText,
    required String translation,
    required String explanation,
  }) async {
    print('>>> SAVE HIVE DIPANGGIL');

    await box.add({
      'label': label,
      'confidence': confidence,
      'status': status,
      'surahName': surahName,
      'verseNumber': verseNumber,
      'arabicText': arabicText,
      'translation': translation,
      'explanation': explanation,
      'createdAt': DateTime.now().toIso8601String(),
    });

    print('>>> DATA BERHASIL MASUK HIVE');
    print('>>> JUMLAH DATA: ${box.length}');
  }

  static List<Map<String, dynamic>> getHistory() {
    return box.values
        .map((item) => Map<String, dynamic>.from(item))
        .toList()
        .reversed
        .toList();
  }

  static Future<void> deleteHistory(int index) async {
    final keys = box.keys.toList().reversed.toList();

    if (index < 0 || index >= keys.length) {
      return;
    }

    await box.delete(keys[index]);
  }

  static Future<void> clearHistory() async {
    await box.clear();
  }
}
