import 'package:flutter_test/flutter_test.dart';
import 'package:stopwatch/extensions/int_extensions.dart';

void main() {
  group('IntExtensions', () {
    test('millisecondsToString should convert milliseconds to formatted string', () {
      expect(60000.millisecondsToString, '01:00:00');
      expect(120000.millisecondsToString, '02:00:00');
      expect(12345.millisecondsToString, '00:12:34');
    });
  });
}
