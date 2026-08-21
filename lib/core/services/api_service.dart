import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // Untuk HP fisik:
  // gunakan IPv4 komputer yang satu jaringan dengan HP
  static const String baseUrl = 'http://127.0.0.1:5000';

  Future<Map<String, dynamic>> classify({
    required String surahName,
    required int verseNumber,
    required String arabicText,
    required String terjemahan,
    required String tafsir,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/classify'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'surahName': surahName,
        'verseNumber': verseNumber,
        'arabicText': arabicText,
        'terjemahan': terjemahan,
        'tafsir': tafsir,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('API error ${response.statusCode}: ${response.body}');
    }

    final data = jsonDecode(response.body) as Map<String, dynamic>;

    if (data['success'] != true) {
      throw Exception(data['message'] ?? 'Klasifikasi gagal');
    }

    return data;
  }
}
