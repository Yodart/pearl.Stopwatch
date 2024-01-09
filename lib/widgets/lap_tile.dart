import 'package:flutter/material.dart';
import 'package:stopwatch/extensions/int_extensions.dart';

/// A widget that represents a single lap in a lap list.
///
/// This widget displays the title and duration of a lap in a [ListTile].
/// The [title] parameter is used to display the title of the lap.
/// The [duration] parameter is used to display the duration of the lap.
class LapTile extends StatelessWidget {
  final String title;
  final Duration duration;

  const LapTile({super.key, required this.title, required this.duration});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.black.withOpacity(0.25), width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      title: Text(title, style: Theme.of(context).textTheme.titleMedium),
      trailing:
          Text('+ ${duration.inMilliseconds.millisecondsToString}', style: Theme.of(context).textTheme.bodyMedium),
    );
  }
}
