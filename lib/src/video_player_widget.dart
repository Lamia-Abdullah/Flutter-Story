import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

// A widget for playing video from an asset file.
class VideoPlayerWidget extends StatelessWidget {
  final String assetPath;

  const VideoPlayerWidget({super.key, required this.assetPath});

  @override
  Widget build(BuildContext context) {
    final videoController = VideoPlayerController.asset(assetPath);

    return FutureBuilder(
      future: videoController.initialize(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          videoController.play();
          return AspectRatio(
            aspectRatio: videoController.value.aspectRatio,
            child: VideoPlayer(videoController),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
