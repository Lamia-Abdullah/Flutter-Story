import 'package:flutter/material.dart';

class StoryProgressIndicator extends StatelessWidget {
  final AnimationController controller;

  StoryProgressIndicator({required this.controller});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return LinearProgressIndicator(
          value: controller.value,
          backgroundColor: Colors.grey,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        );
      },
    );
  }
}
