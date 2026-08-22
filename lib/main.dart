import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  print('========== APLIKASI DIMULAI ==========');

  await Hive.initFlutter();

  await Hive.openBox('classification_history');

  print('========== HIVE BERHASIL DIBUKA ==========');

  runApp(const App());
}