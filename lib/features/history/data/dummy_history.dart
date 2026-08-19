import '../models/history_item.dart';

final List<HistoryItem> dummyHistory = [
  HistoryItem(
    id: 'h1',
    label: 'Shalat',
    confidence: 94,
    surahName: 'Al-Baqarah',
    verseNumber: 43,
    arabicText: 'وَأَقِيمُوا الصَّلَاةَ',
    translation: 'Dan laksanakanlah salat.',
    date: DateTime(2026, 7, 6),
  ),
  HistoryItem(
    id: 'h2',
    label: 'Zakat',
    confidence: 88,
    surahName: 'At-Tawbah',
    verseNumber: 103,
    arabicText: 'خُذْ مِنْ أَمْوَالِهِمْ',
    translation: 'Ambillah zakat dari sebagian harta mereka.',
    date: DateTime(2026, 6, 20),
  ),
  HistoryItem(
    id: 'h3',
    label: 'Puasa',
    confidence: 76,
    surahName: 'Al-Baqarah',
    verseNumber: 183,
    arabicText: 'كُتِبَ عَلَيْكُمُ الصِّيَامُ',
    translation: 'Diwajibkan atas kamu berpuasa.',
    date: DateTime(2026, 5, 12),
  ),
];
