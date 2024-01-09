import 'package:flutter_test/flutter_test.dart';
import 'package:stopwatch/widgets/stopwatch.dart';

void main() {
  group('PearlStopwatch', () {
    late PearlStopwatch stopwatch;

    setUp(() {
      stopwatch = PearlStopwatch(frequency: 100);
    });

    test('start should start the stopwatch', () {
      stopwatch.start();
      expect(stopwatch.isRunning, true);
    });

    test('stop should stop the stopwatch', () {
      stopwatch.start();
      stopwatch.stop();
      expect(stopwatch.isRunning, false);
    });

    test('reset should reset the stopwatch', () {
      stopwatch.start();
      stopwatch.reset();
      expect(stopwatch.elapsed, 0);
      expect(stopwatch.laps, []);
      expect(stopwatch.isRunning, false);
    });

    test('addLap should add a lap to the stopwatch', () {
      stopwatch.start();
      stopwatch.addLap();
      expect(stopwatch.laps.length, 1);
    });

    test('dispose should cancel the timer', () {
      stopwatch.dispose();
      expect(stopwatch.isRunning, false);
    });
  });
}
