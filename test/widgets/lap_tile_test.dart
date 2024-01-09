import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stopwatch/extensions/int_extensions.dart';
import 'package:stopwatch/widgets/lap_tile.dart';

void main() {
  group('LapTile', () {
    testWidgets('should display the title and duration correctly', (WidgetTester tester) async {
      const title = 'Lap 1';
      const duration = Duration(seconds: 10);

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: LapTile(title: title, duration: duration),
          ),
        ),
      );

      final titleFinder = find.text(title);
      final durationFinder = find.text('+ ${duration.inMilliseconds.millisecondsToString}');

      expect(titleFinder, findsOneWidget);
      expect(durationFinder, findsOneWidget);
    });

    testWidgets('should have the correct shape and style', (WidgetTester tester) async {
      const title = 'Lap 1';
      const duration = Duration(seconds: 10);

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: LapTile(title: title, duration: duration),
          ),
        ),
      );

      final listTileFinder = find.byType(ListTile);
      final textFinder = find.byType(Text);

      expect(listTileFinder, findsOneWidget);
      expect(textFinder, findsNWidgets(2));

      final listTileWidget = tester.widget<ListTile>(listTileFinder);
      final textWidgets = tester.widgetList<Text>(textFinder);

      expect(
          listTileWidget.shape,
          RoundedRectangleBorder(
            side: BorderSide(color: Colors.black.withOpacity(0.25), width: 1),
            borderRadius: BorderRadius.circular(8),
          ));

      expect(textWidgets.toList()[0].data, title);
      expect(textWidgets.toList()[0].style, Theme.of(tester.element(find.byType(LapTile))).textTheme.titleMedium);

      expect(textWidgets.toList()[1].data, '+ ${duration.inMilliseconds.millisecondsToString}');
      expect(textWidgets.toList()[1].style, Theme.of(tester.element(find.byType(LapTile))).textTheme.bodyMedium);
    });
  });
}
