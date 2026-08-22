import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl =
      'https://fauzn.pythonanywhere.com';

  Future<Map<String, dynamic>> classify({
    required String terjemahan,
    required String tafsir,
    required String surahName,
    required int verseNumber,
    required String arabicText,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/classify'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'terjemahan': terjemahan,
        'tafsir': tafsir,
        'surahName': surahName,
        'verseNumber': verseNumber,
        'arabicText': arabicText,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception(
        'API error ${response.statusCode}: ${response.body}',
      );
    }

    final data =
        jsonDecode(response.body) as Map<String, dynamic>;

    if (data['success'] != true) {
      throw Exception(
        data['message'] ?? 'Klasifikasi gagal',
      );
    }

    return data;
  }
}