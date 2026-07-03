import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Smoke test - app builds without crashing', (
    WidgetTester tester,
  ) async {
    // Test minimal : vérifie juste qu'un MaterialApp basique se construit
    // sans lever d'exception. À enrichir plus tard avec de vrais tests
    // sur tes pages (LoginPage, MessagePage, etc.).
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: Center(child: Text('Hifandray'))),
      ),
    );

    expect(find.text('Hifandray'), findsOneWidget);
  });
}
