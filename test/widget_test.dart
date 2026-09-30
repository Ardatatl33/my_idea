// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:dplan_progress/main.dart';

void main() {
  testWidgets('İlerleme göreve göre güncellenir', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const DPlanApp());

    expect(find.text('%60'), findsOneWidget);
    expect(find.text('5 görevden 3 tanesi tamamlandı'), findsOneWidget);
    expect(find.text('Sıradaki: Sunum taslağını hazırla'), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('task-3')));
    await tester.pumpAndSettle();

    expect(find.text('%80'), findsOneWidget);
    expect(find.text('5 görevden 4 tanesi tamamlandı'), findsOneWidget);
    expect(find.text('Sıradaki: Günü değerlendir'), findsOneWidget);

    final lastTask = find.byKey(const ValueKey('task-4'));
    await tester.ensureVisible(lastTask);
    await tester.tap(lastTask);
    await tester.pumpAndSettle();

    expect(find.text('%100'), findsOneWidget);
    expect(find.text('Bugünkü 5 görevin tamamlandı!'), findsOneWidget);
    expect(find.text('Harika! Bugünün planı tamamlandı.'), findsOneWidget);
  });
}
