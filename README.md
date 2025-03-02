
[![pub package](https://img.shields.io/pub/v/story_flow.svg)](https://pub.dev/packages/story_flow)


# story_flow  🎬

## Overview  
The **story_flow** allows you to display stories similar to Instagram Stories using Flutter. It supports images, videos, and GIFs with customizable profile picture size. The package also includes a progress indicator for each story and interactive gestures for smooth navigation.  



![Story Flow Demo](https://github.com/user-attachments/assets/9fb7a20c-3bff-47cb-8190-d243fe65f3ee)


## Features  📿

- Display stories as **images**, **videos**, or **GIFs**.  
- **Progress indicator** to show story playback progress.   
- **Customizable sizes** for the profile picture.  
- Supports **portrait mode only** for story viewing.  
- **Swipe** navigation to switch between stories.  
- **viewed stories** for story indicators after watching (from green to gray).  



## Installation  📦

Add the following to your `pubspec.yaml` file:  

```dart

dependencies:
  story_flow: ^1.0.3 # Replace with the latest version

```

Run the following command in the terminal to fetch the package:
```dart
flutter pub get
```


## Usage 🛠️
#### Import the package.
```dart
import 'package:story_flow/story_flow.dart';
```
#### Displaying Profile Picture with Stories: `StoryProfile`
Use `StoryProfile` to display a tappable profile picture that opens the story viewer:

```dart

StoryProfile(
  size: 70, // Profile picture size
  profileImage: 'assets/profile.jpg', // Asset path or network URL
  isLottie: false, // Whether the profile image is a Lottie animation
  storyItems: [
    StoryImage(
    url: 'https://i.giphy.com/media/v1.Y2lkPTc5MGI3NjExYWJzZHcyOGs3cHlvMHRjZGd4MzduMjN3MmVxb2UzcGg1c2tocDNtaSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/gYWeVOiMmbg3kzCTq5/giphy.gif',
    duration: const Duration(seconds: 5),),
    StoryVideoAsset(assetPath: "assets/video.mov"), // Video
    StoryImage( assetPath: "assets/cat.webp",
    duration: const Duration(seconds: 1)),
    // Add more stories here... 
  ],
)

```
#### Displaying Stories: `StoryView`
Use `StoryView` to display the stories in a standalone interface:
```dart

StoryView(
  items: [
    StoryImage('assets/cat.jpg', Duration(seconds: 1)),  // Image
    StoryVideo('assets/dog.mp4'),  // Video
    // Add more stories here...
  ],
)

```

## Components 🧩

**StoryItem :** The base component for stories ( image, video, or gif ).
**StoryImage :** For displaying an image story ( supports both asset path and URL ).
**StoryVideoAsset :** For displaying a video story.
**StoryProgressIndicator :** Displays the progress of the current story.
**StoryCloseButton :** Button to close the story viewer.

---
## Time Settings ⏰

#### For Images 
Set the duration for how long the image is displayed:

```dart

StoryAsset("assets/cat.jpg", duration: const Duration(seconds: 3)), 
```

#### For Videos
Videos are displayed for their full duration automatically:

```dart

StoryAsset("assets/video.mp4"),  
```
You don’t need to set a `duration` for videos.



## Navigation Between Stories 🔄
 - Automatically moves to the next story after the current one finishes.
 - If it’s the last story, the viewer closes automatically.



## viewed stories 👁️
 - After watching a story, its indicator color changes from green to gray.
  


## Notes 📋
- Images: Supports both assets and network URLs.
- Videos: Must be included in assets and do not support direct URLs.
- Profile Picture:
    - Can be from assets or a network URL.
    - GIFs are supported for profile pictures.
