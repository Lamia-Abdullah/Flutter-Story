abstract class StoryItem {
  bool isViewed; // flag to track if the story is viewed
  Duration duration; // Duration of the story

  StoryItem({this.isViewed = false, required this.duration});
}


class StoryImage extends StoryItem {
  final String? url; 
  final String? assetPath; 

  // A constructor that accepts either an asset path or a URL
  StoryImage({
    this.url,
    this.assetPath,
    required Duration duration,
  })  : assert(
            (url != null && assetPath == null) ||
                (assetPath != null && url == null),
            'Either assetPath or url must be provided, not both'),
        super(duration: duration);
}

class StoryVideoAsset extends StoryItem {
  final String assetPath; 

  StoryVideoAsset({
    required this.assetPath,
  }) : super(duration: Duration.zero); // The video duration will be determined automatically
}
