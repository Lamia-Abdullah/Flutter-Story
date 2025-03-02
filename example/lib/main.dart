import 'package:flutter/material.dart';
import 'package:story_flow/story_flow.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text(" flutter Story ")),
        body: Center(
          child: StoryProfile(
            size: 70,
            profileImage: 'assets/Animation.json', // gif or image
            isLottie: true,
            storyItems: [
              // video , gif , image (url or asset)
              StoryImage(
                url:
                    'https://i.giphy.com/media/v1.Y2lkPTc5MGI3NjExYWJzZHcyOGs3cHlvMHRjZGd4MzduMjN3MmVxb2UzcGg1c2tocDNtaSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/gYWeVOiMmbg3kzCTq5/giphy.gif',
                duration: const Duration(seconds: 5),
              ),
              StoryVideoAsset(assetPath: "assets/video.mov"),
              StoryImage(
                  assetPath: "assets/cat.webp",
                  duration: const Duration(seconds: 1)),
            ],
          ),
        ),
      ),
    );
  }
}
