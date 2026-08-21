import 'dart:convert';

import 'package:flutter/services.dart';

import '../../features/classification/models/ayat.dart';

class QuranService {
  static const String _assetPath = 'assets/data/quran.json';

  Future<List<Ayat>> loadQuran() async {
    final jsonString = await rootBundle.loadString(_assetPath);

    final List<dynamic> jsonData = jsonDecode(jsonString);

    return jsonData
        .map((item) => Ayat.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}