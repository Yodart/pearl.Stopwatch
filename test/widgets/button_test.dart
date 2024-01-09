import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stopwatch/widgets/button.dart';

void main() {
  group('Button', () {
    late Color color;
    late bool isDisabled;
    late String text;
    late VoidCallback onTap;
    late Button button;

    setUp(() {
      color = Colors.blue;
      isDisabled = false;
      text = 'Button';
      onTap = () {};
      button = Button(
        color: color,
        isDisabled: isDisabled,
        text: text,
        onTap: onTap,
      );
    });

    testWidgets('button should have correct color and text', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Material(
            child: button,
          ),
        ),
      );

      final containerFinder = find.byType(Container);
      final textFinder = find.text(text);

      expect(containerFinder, findsOneWidget);
      expect(textFinder, findsOneWidget);

      final containerWidget = tester.widget<Container>(containerFinder);
      final textWidget = tester.widget<Text>(textFinder);

      expect((containerWidget.decoration! as BoxDecoration).color, color.withOpacity(0.4));
      expect(textWidget.style!.color, color);
      expect(textWidget.style!.fontWeight, FontWeight.bold);
    });

    testWidgets('button should be disabled when isDisabled is true', (WidgetTester tester) async {
      isDisabled = true;
      button = Button(
        color: color,
        isDisabled: isDisabled,
        text: text,
        onTap: onTap,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Material(
            child: button,
          ),
        ),
      );

      final opacityFinder = find.byType(Opacity);

      expect(opacityFinder, findsOneWidget);

      final opacity = tester.widget<Opacity>(opacityFinder);

      expect(opacity.opacity, 0.6);
    });

    testWidgets('button should call onTap when tapped', (WidgetTester tester) async {
      bool onTapCalled = false;
      onTap = () {
        onTapCalled = true;
      };
      button = Button(
        color: color,
        isDisabled: isDisabled,
        text: text,
        onTap: onTap,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Material(
            child: button,
          ),
        ),
      );

      final gestureDetectorFinder = find.byType(GestureDetector);

      expect(gestureDetectorFinder, findsOneWidget);

      await tester.tap(gestureDetectorFinder);

      expect(onTapCalled, true);
    });

    testWidgets('button should not call onTap when isDisabled is true', (WidgetTester tester) async {
      bool onTapCalled = false;
      onTap = () {
        onTapCalled = true;
      };
      isDisabled = true;
      button = Button(
        color: color,
        isDisabled: isDisabled,
        text: text,
        onTap: onTap,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Material(
            child: button,
          ),
        ),
      );

      final gestureDetectorFinder = find.byType(GestureDetector);

      expect(gestureDetectorFinder, findsOneWidget);

      await tester.tap(gestureDetectorFinder);

      expect(onTapCalled, false);
    });
  });
}
