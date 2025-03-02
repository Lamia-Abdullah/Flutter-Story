
import 'package:flutter_test/flutter_test.dart';
import 'package:story_flow/story_flow.dart';


void main() {
  test('Test StoryProfile widget', () {
    final storyProfile = StoryProfile(
      size: 70, 
      profileImage: 'assets/Animation.json', 
      isLottie: false,
      storyItems: [
        StoryImage(
          assetPath: "assets/cat.webp", 
          duration: const Duration(seconds: 2)
        ),
        StoryVideoAsset(assetPath: "assets/video.mov"),
      ],
    );
    expect(storyProfile, isNotNull);
    expect(storyProfile.storyItems.length, greaterThan(0));
  });
}
