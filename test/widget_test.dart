import 'package:flutter_test/flutter_test.dart';

import 'package:klasifikasi_rukun_islam/app.dart';

void main() {
  testWidgets('shows onboarding content on first launch', (tester) async {
    await tester.pumpWidget(const App());

    expect(find.text('Kenali Kandungan Ayat Al-Qur\'an'), findsOneWidget);
    expect(find.text('Temukan ayat Al-Qur\'an yang berkaitan dengan Rukun Islam melalui teknologi klasifikasi yang mudah dipahami.'), findsOneWidget);
    expect(find.text('Skip'), findsOneWidget);
  });
}
