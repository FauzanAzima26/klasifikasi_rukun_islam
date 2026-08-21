import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../features/classification/models/ayat.dart';
import '../../features/result/models/result.dart';

class ApiService {
  // Untuk HP fisik:
  // gunakan IPv4 komputer yang satu jaringan dengan HP
  static const String baseUrl = 'http://127.0.0.1:5000';

  Future<ClassificationResult> classify({
    required Ayat ayat,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/classify'),

      headers: {
        'Content-Type': 'application/json',
      },

      body: jsonEncode({
        // Identitas ayat
        'surahName': ayat.surahName,
        'verseNumber': ayat.verseNumber,
        'arabicText': ayat.arabicText,
        'translation': ayat.translation,

        // Data yang digunakan backend untuk klasifikasi
        'terjemahan': ayat.translation,
        'tafsir': ayat.tafsir,
      }),
    );

    // ==========================================
    // DEBUG
    // ==========================================

    print('========== RESPONSE API ==========');
    print('Status: ${response.statusCode}');
    print('Body: ${response.body}');
    print('==================================');

    // ==========================================
    // CEK HTTP
    // ==========================================

    if (response.statusCode != 200) {
      throw Exception(
        'API error ${response.statusCode}: ${response.body}',
      );
    }

    // ==========================================
    // PARSE JSON
    // ==========================================

    final data =
        jsonDecode(response.body) as Map<String, dynamic>;

    // ==========================================
    // CEK SUCCESS
    // ==========================================

    if (data['success'] != true) {
      throw Exception(
        data['message'] ?? 'Klasifikasi gagal',
      );
    }

    // ==========================================
    // UBAH RESPONSE MENJADI OBJECT
    // ==========================================

    return ClassificationResult.fromJson(data);
  }
}