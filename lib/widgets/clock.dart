import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:stopwatch/extensions/int_extensions.dart';

/// A widget that displays a circular clock with the elapsed time.
///
/// The [Clock] widget takes an [elapsed] parameter, which represents the elapsed time in milliseconds.
/// It displays the elapsed time in the center of the clock as text.
/// The clock has a fixed size of 250x250 pixels and is styled based on the current theme.
class Clock extends StatelessWidget {
  const Clock({super.key, required this.elapsed});

  final int elapsed;

  @override
  Widget build(BuildContext context) {
    const double size = 250;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
        border: Border.all(color: Theme.of(context).colorScheme.primary, width: 2),
        boxShadow: [
          BoxShadow(color: Theme.of(context).colorScheme.primary.withOpacity(0.4), blurRadius: 16, spreadRadius: 4),
        ],
      ),
      alignment: Alignment.center,
      child: Text(
        elapsed.millisecondsToString,
        style: Theme.of(context).textTheme.displayMedium?.copyWith(
          color: Theme.of(context).colorScheme.onPrimary,
          fontFeatures: [const FontFeature.tabularFigures()],
        ),
      ),
    );
  }
}
