import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stopwatch/extensions/int_extensions.dart';
import 'package:stopwatch/widgets/clock.dart';

void main() {
  group('Clock', () {
    testWidgets('should display elapsed time', (WidgetTester tester) async {
      const int elapsed = 5000;
      await tester.pumpWidget(
        const MaterialApp(
          home: Clock(elapsed: elapsed),
        ),
      );

      final textFinder = find.text(elapsed.millisecondsToString);
      expect(textFinder, findsOneWidget);
    });

    testWidgets('should have correct decoration', (WidgetTester tester) async {
      const int elapsed = 5000;
      await tester.pumpWidget(
        const MaterialApp(
          home: Clock(elapsed: elapsed),
        ),
      );

      final containerFinder = find.byType(Container);
      final containerWidget = tester.widget<Container>(containerFinder);
      expect(
          containerWidget.decoration,
          BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.blue.withOpacity(0.3),
            border: Border.all(color: Colors.blue, width: 2),
            boxShadow: [
              BoxShadow(color: Colors.blue.withOpacity(0.4), blurRadius: 16, spreadRadius: 4),
            ],
          ));
    });

    testWidgets('should have correct text style', (WidgetTester tester) async {
      const int elapsed = 5000;
      await tester.pumpWidget(
        const MaterialApp(
          home: Clock(elapsed: elapsed),
        ),
      );

      final textFinder = find.text(elapsed.millisecondsToString);
      final textWidget = tester.widget<Text>(textFinder);
      expect(textWidget.style?.color, Colors.white);
    });
  });
}
