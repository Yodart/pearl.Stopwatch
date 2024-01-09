extension IntExtensions on int {
  /// Converts the given [int] value representing milliseconds to a formatted string representation.
  ///
  /// Returns a string in the format "mm:ss:ms".
  ///
  /// Example:
  /// ```dart
  /// int milliseconds = 123456;
  /// String formattedString = milliseconds.millisecondsToString;
  /// print(formattedString); // Output: "02:03:45"
  /// ```
  String get millisecondsToString {
    int minutes = (this / 60000).truncate();
    int seconds = ((this % 60000) / 1000).truncate();
    int ms = (this % 1000);

    String minutesStr = minutes.toString().padLeft(2, '0');
    String secondsStr = seconds.toString().padLeft(2, '0');
    String msStr = ms.toString().padLeft(2, '0').substring(0, 2);

    return '$minutesStr:$secondsStr:$msStr';
  }
}
