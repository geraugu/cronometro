import 'package:flutter/material.dart';

class StopwatchDisplay extends StatelessWidget {
  final int milliseconds;

  const StopwatchDisplay({
    super.key,
    required this.milliseconds,
  });

  @override
  Widget build(BuildContext context) {
    final seconds = (milliseconds / 1000).floor();
    final minutes = (seconds / 60).floor();

    final displayMinutes = minutes.toString().padLeft(2, '0');
    final displaySeconds = (seconds % 60).toString().padLeft(2, '0');
    final displayMilliseconds = ((milliseconds % 1000) ~/ 100).toString();

    return Text(
      '$displayMinutes:$displaySeconds.$displayMilliseconds',
      style: const TextStyle(
        fontSize: 60,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
