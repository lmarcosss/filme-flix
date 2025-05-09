import 'package:flutter/material.dart';

class WorkingProgress extends StatefulWidget {
  const WorkingProgress({super.key});

  @override
  State<WorkingProgress> createState() => _WorkingProgressState();
}

class _WorkingProgressState extends State<WorkingProgress>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RotationTransition(
            turns: _controller,
            child: Icon(
              Icons.hourglass_top,
              size: 60,
              color: colorScheme.primary,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            "Working Progress",
            style: TextStyle(
              color: colorScheme.primary,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
