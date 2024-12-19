import 'dart:async';
import 'package:flutter/material.dart';
import 'stopwatch_display.dart';

class StopwatchScreen extends StatefulWidget {
  final Function() onThemeToggle;
  final bool isDarkMode;

  const StopwatchScreen({
    super.key,
    required this.onThemeToggle,
    required this.isDarkMode,
  });

  @override
  State<StopwatchScreen> createState() => _StopwatchScreenState();
}

class _StopwatchScreenState extends State<StopwatchScreen> {
  bool isRunning = false;
  int milliseconds = 0;
  Timer? timer;
  List<int> lapTimes = [];

  void _startStop() {
    if (isRunning) {
      timer?.cancel();
    } else {
      timer = Timer.periodic(const Duration(milliseconds: 100), _onTick);
    }
    setState(() {
      isRunning = !isRunning;
    });
  }

  void _onTick(Timer timer) {
    setState(() {
      milliseconds += 100;
    });
  }

  void _reset() {
    timer?.cancel();
    setState(() {
      milliseconds = 0;
      isRunning = false;
      lapTimes.clear();
    });
  }

  void _addLap() {
    if (isRunning) {
      setState(() {
        lapTimes.insert(0, milliseconds);
      });
    }
  }

  String _formatLapTime(int index) {
    if (index == lapTimes.length - 1) {
      // First lap
      return _formatDuration(lapTimes[index]);
    } else {
      // Calculate time difference between current and next lap
      final currentLapTime = lapTimes[index];
      final nextLapTime = lapTimes[index + 1];
      return _formatDuration(currentLapTime - nextLapTime);
    }
  }

  String _formatDuration(int ms) {
    final minutes = ((ms / 1000) / 60).floor().toString().padLeft(2, '0');
    final seconds = ((ms / 1000) % 60).floor().toString().padLeft(2, '0');
    final centiseconds = ((ms % 1000) / 10).floor().toString().padLeft(2, '0');
    return '$minutes:$seconds.$centiseconds';
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cronômetro'),
        actions: [
          IconButton(
            icon: Icon(widget.isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: widget.onThemeToggle,
            tooltip: widget.isDarkMode ? 'Switch to Light Mode' : 'Switch to Dark Mode',
          ),
        ],
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  StopwatchDisplay(milliseconds: milliseconds),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: _startStop,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                        ),
                        child: Text(
                          isRunning ? 'Parar' : 'Iniciar',
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                      const SizedBox(width: 20),
                      ElevatedButton(
                        onPressed: isRunning ? _addLap : null,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                        ),
                        child: const Text(
                          'Volta',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      const SizedBox(width: 20),
                      ElevatedButton(
                        onPressed: _reset,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                        ),
                        child: const Text(
                          'Zerar',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: lapTimes.isEmpty
                ? const Center(
                    child: Text(
                      'Nenhuma volta registrada',
                      style: TextStyle(fontSize: 16),
                    ),
                  )
                : ListView.builder(
                    itemCount: lapTimes.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Text(
                          'Volta ${lapTimes.length - index}',
                          style: const TextStyle(fontSize: 16),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              _formatLapTime(index),
                              style: const TextStyle(
                                fontSize: 16,
                                fontFamily: 'monospace',
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '(Total: ${_formatDuration(lapTimes[index])})',
                              style: TextStyle(
                                fontSize: 14,
                                color: Theme.of(context).textTheme.bodySmall?.color,
                                fontFamily: 'monospace',
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
