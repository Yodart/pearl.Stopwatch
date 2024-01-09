import 'package:flutter/material.dart';
import 'package:stopwatch/extensions/int_extensions.dart';
import 'package:stopwatch/widgets/button.dart';
import 'package:stopwatch/widgets/clock.dart';
import 'package:stopwatch/widgets/lap_tile.dart';
import 'package:stopwatch/widgets/stopwatch.dart';

/// StopwatchView is a StatefulWidget that displays a stopwatch with lap functionality.
/// It includes buttons for start, stop, reset, and lap, as well as a clock widget
/// to show the elapsed time. The laps are displayed in a list view with lap tiles.
class StopwatchView extends StatefulWidget {
  const StopwatchView({super.key});

  @override
  State<StopwatchView> createState() => _StopwatchViewState();
}

class _StopwatchViewState extends State<StopwatchView> {
  final PearlStopwatch stopwatch = PearlStopwatch(frequency: 10);

  @override
  void dispose() {
    super.dispose();
    stopwatch.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool showStart = !stopwatch.isRunning;
    final bool showReset = !stopwatch.isRunning && stopwatch.elapsed > 0;
    final List<Duration> reversedLaps = stopwatch.laps.reversed.toList();
    final int avgLapTime =
        reversedLaps.isNotEmpty ? reversedLaps.reduce((a, b) => a + b).inMilliseconds ~/ reversedLaps.length : 0;

    return Scaffold(
      body: Center(
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          constraints: const BoxConstraints(maxWidth: 700),
          child: Column(
            children: [
              IntrinsicHeight(
                child: Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).padding.top + 16),
                      _StopwatchClock(stopwatch: stopwatch),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (showReset)
                            Button(
                              color: Theme.of(context).colorScheme.onBackground,
                              text: 'Reset',
                              onTap: () {
                                stopwatch.reset();
                                setState(() {});
                              },
                            )
                          else
                            Button(
                              color: Theme.of(context).colorScheme.onBackground,
                              text: 'Lap',
                              isDisabled: showStart,
                              onTap: () {
                                stopwatch.addLap();
                                setState(() {});
                              },
                            ),
                          if (showStart)
                            Button(
                              color: Theme.of(context).colorScheme.primary,
                              text: 'Start',
                              onTap: () {
                                stopwatch.start();
                                setState(() {});
                              },
                            )
                          else
                            Button(
                              color: Theme.of(context).colorScheme.error,
                              text: 'Stop',
                              onTap: () {
                                stopwatch.stop();
                                setState(() {});
                              },
                            ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      if (reversedLaps.isNotEmpty)
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.onBackground.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            '${reversedLaps.length} Laps - Avg: ${avgLapTime.millisecondsToString}',
                          ),
                        ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  physics: const BouncingScrollPhysics(),
                  children: [
                    for (int i = 0; i < reversedLaps.length; i++)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: LapTile(
                          title: 'Lap ${reversedLaps.length - i}',
                          duration: reversedLaps[i],
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// A widget that encapsulates the stopwatch clock for the view.
///
/// This widget is used to scope the stopwatch clock into a separate widget,
/// so that the view doesn't rebuild every time the stopwatch fires.
class _StopwatchClock extends StatefulWidget {
  final PearlStopwatch stopwatch;

  const _StopwatchClock({required this.stopwatch});

  @override
  State<_StopwatchClock> createState() => __StopwatchClockState();
}

class __StopwatchClockState extends State<_StopwatchClock> {
  void _stopwatchListener() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    widget.stopwatch.addListener(_stopwatchListener);
  }

  @override
  void dispose() {
    super.dispose();
    widget.stopwatch.removeListener(_stopwatchListener);
  }

  @override
  Widget build(BuildContext context) {
    return Clock(elapsed: widget.stopwatch.elapsed);
  }
}
