import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stopwatch/views/stopwatch_view.dart';
import 'package:stopwatch/widgets/lap_tile.dart';

void main() {
  group('StopwatchView', () {
    testWidgets('should show start button when stopwatch is not running', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: StopwatchView(),
        ),
      );

      final startButtonFinder = find.text('Start');
      expect(startButtonFinder, findsOneWidget);
    });

    testWidgets('should show stop button when stopwatch is running', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: StopwatchView(),
        ),
      );

      final startButtonFinder = find.text('Start');
      expect(startButtonFinder, findsOneWidget);

      await tester.tap(startButtonFinder);
      await tester.pump();

      final stopButtonFinder = find.text('Stop');
      expect(stopButtonFinder, findsOneWidget);
    });

    testWidgets('should show lap button when stopwatch is not running', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: StopwatchView(),
        ),
      );

      final lapButtonFinder = find.text('Lap');
      expect(lapButtonFinder, findsOneWidget);
    });

    testWidgets('should add lap when lap button is tapped', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: StopwatchView(),
        ),
      );

      final startButtonFinder = find.text('Start');
      expect(startButtonFinder, findsOneWidget);

      await tester.tap(startButtonFinder);
      await tester.pump();

      final lapButtonFinder = find.text('Lap');
      expect(lapButtonFinder, findsOneWidget);

      await tester.tap(lapButtonFinder);
      await tester.pump();

      final lapTileFinder = find.byType(LapTile);
      expect(lapTileFinder, findsOneWidget);
    });
  });
}
