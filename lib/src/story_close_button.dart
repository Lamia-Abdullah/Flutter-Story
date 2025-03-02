import 'package:flutter/material.dart';

class StoryCloseButton extends StatelessWidget {
  final VoidCallback onPressed;

  const StoryCloseButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 65,
      right: 20,
      child: Container(
        width: 35,
        height: 35,
        decoration: BoxDecoration(
          color: Colors.grey[600],
          shape: BoxShape.circle,
        ),
        child: Center(
          child: IconButton(
            icon: const Icon(
              Icons.close,
              color: Colors.white,
              size: 20,
            ),
            onPressed: onPressed,
          ),
        ),
      ),
    );
  }
}
