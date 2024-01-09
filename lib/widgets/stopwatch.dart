import 'dart:async';

import 'package:flutter/material.dart';

/// A stopwatch class that can be used to measure elapsed time.
///
/// This class extends [ChangeNotifier] to allow for easy integration with
/// Flutter's state management system.
class PearlStopwatch extends ChangeNotifier {
  /// A stopwatch widget that measures time with a specified frequency.
  ///
  /// The [frequency] parameter determines how often the stopwatch updates its time.
  /// It should be a positive integer representing the number of times the stopwatch
  /// updates per second.
  ///
  /// Example usage:
  /// ```dart
  /// PearlStopwatch stopwatch = PearlStopwatch(frequency: 10);
  /// ```
  @protected
  final int frequency;

  PearlStopwatch({required this.frequency});

  Timer? _timer;

  /// Indicates whether the stopwatch is currently running.
  bool isRunning = false;

  /// The elapsed time in milliseconds.
  int elapsed = 0;

  /// A list of recorded lap durations.
  List<Duration> laps = <Duration>[];

  /// Updates the elapsed time with the given [newValue].
  /// If the stopwatch is not running, cancels the timer.
  /// Notifies listeners of the updated elapsed time.
  void _updateElapsed(int newValue) {
    if (!isRunning) {
      _timer?.cancel();
      return;
    }
    elapsed = newValue;
    notifyListeners();
  }

  /// Starts the stopwatch.
  ///
  /// Sets the [isRunning] flag to true and cancels any existing timer.
  /// Then, it creates a new timer using the [frequency] value and updates the elapsed time
  /// every time the timer ticks.
  ///
  /// The [frequency] parameter specifies the duration between each tick of the timer,
  /// measured in milliseconds.
  void start() {
    isRunning = true;
    _timer?.cancel();
    _timer = Timer.periodic(Duration(milliseconds: frequency), (Timer t) => _updateElapsed(t.tick * frequency));
  }

  /// Stops the stopwatch.
  ///
  /// Cancels the timer and sets the [isRunning] flag to false.
  /// Notifies the listeners that the stopwatch has stopped.
  void stop() {
    _timer?.cancel();
    isRunning = false;
    notifyListeners();
  }

  /// Resets the stopwatch by canceling the timer, setting the elapsed time to 0,
  /// clearing the laps list, and setting the isRunning flag to false.
  /// Notifies the listeners after the reset.
  void reset() {
    _timer?.cancel();
    elapsed = 0;
    laps = [];
    isRunning = false;
    notifyListeners();
  }

  /// Adds a lap to the stopwatch.
  ///
  /// Calculates the duration of the current lap by subtracting the total duration of previous laps from the current elapsed time.
  /// Appends the calculated lap duration to the list of laps.
  /// Notifies listeners that the state has changed.
  void addLap() {
    final Duration totalLapsDuration = laps.isEmpty ? Duration.zero : laps.reduce((a, b) => a + b);
    laps = [...laps, Duration(milliseconds: elapsed) - totalLapsDuration];
    notifyListeners();
  }

  /// Disposes the resources used by the stopwatch.
  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
