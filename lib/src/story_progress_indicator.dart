import 'package:flutter/material.dart';

// A progress indicator for story playback
class StoryProgressIndicator extends StatelessWidget {
  final AnimationController controller;

  const StoryProgressIndicator({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return LinearProgressIndicator(
          value: controller.value,
          backgroundColor: Colors.grey,
          valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
        );
      },
    );
  }
}
