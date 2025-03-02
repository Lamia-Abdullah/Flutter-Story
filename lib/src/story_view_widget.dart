import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:video_player/video_player.dart';
import 'story_item.dart';
import 'story_progress_indicator.dart';
import 'story_close_button.dart';
import 'video_player_widget.dart';

class StoryView extends StatefulWidget {
  final List<StoryItem> items;

  const StoryView({super.key, required this.items});

  @override
  _StoryViewState createState() => _StoryViewState();
}

class _StoryViewState extends State<StoryView> with TickerProviderStateMixin {
  late PageController
      _pageController; // Controller for navigating between stories
  List<AnimationController>?
      _controllers; // List of animation controllers for each story
  int _lastReadIndex = 0; // The index of the last read story
  bool isAllStoriesViewed = false; // To check if all stories have been viewed

  @override
  void initState() {
    super.initState();
    // Restrict the orientation to portrait only
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    _pageController = PageController(
        initialPage: _lastReadIndex); // Initialize the page controller
    _initializeControllers(); // Initialize animation controllers
  }

  Future<void> _initializeControllers() async {
    _controllers = await Future.wait(
      widget.items.map((item) async {
        Duration duration;
        if (item is StoryVideoAsset) {
          final videoController = VideoPlayerController.asset(item.assetPath);
          await videoController.initialize();
          duration = videoController.value.duration;
        } else {
          duration = item.duration;
        }
        return AnimationController(vsync: this, duration: duration)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _onNextStory();
            }
          });
      }).toList(),
    );
    if (_controllers != null && _controllers!.isNotEmpty) {
      _controllers!.first.forward();
      setState(() {});
    }
  }

  // Method to move to the next story
  void _onNextStory() {
    if (_pageController.hasClients && _controllers != null) {
      int currentIndex =
          _pageController.page!.toInt(); // Get the current story index
      int nextIndex = currentIndex + 1; // Move to the next story
      if (nextIndex < widget.items.length) {
        _pageController.animateToPage(
          nextIndex,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
        _controllers![nextIndex]
            .forward(); // Start animation for the next story
      } else {
        setState(() {
          isAllStoriesViewed = true; // All stories have been viewed
        });
        Navigator.of(context).pop(true); // Go back when all stories are viewed
      }
    }
  }

  @override
  void dispose() {
    // Restore the default orientation when leaving the page
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    _pageController.dispose(); // Dispose of the page controller
    if (_controllers != null) {
      for (var controller in _controllers!) {
        controller.dispose(); // Dispose of all animation controllers
      }
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_controllers == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light, // Set the system UI overlay style
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            PageView.builder(
              controller: _pageController,
              itemCount: widget.items.length,
              physics: const ClampingScrollPhysics(), // Set the scroll physics
              onPageChanged: (index) {
                _handlePageChange(index); // Handle page change
              },
              itemBuilder: (context, index) {
                return _buildStoryItem(
                    widget.items[index], _controllers![index]);
              },
            ),
            // Close button to go back
            StoryCloseButton(onPressed: () => Navigator.of(context).pop()),
            
            // Progress bar for stories
            Positioned(
              top: 50,
              left: 20,
              right: 20,
              child: Row(
                children: List.generate(
                  widget.items.length,
                  (index) => Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2.0),
                      child: StoryProgressIndicator(
                          controller: _controllers![index]),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Method to handle page changes when transitioning between stories
  void _handlePageChange(int index) {
    if (_controllers == null) return;

    // Stop all animations
    for (var controller in _controllers!) {
      controller.stop();
    }

    if (index > _lastReadIndex) {
      if (_lastReadIndex < widget.items.length) {
        _controllers![_lastReadIndex].value =
            1.0; // Complete the animation for the previous story
      }
      _controllers![index]
          .forward(from: 0.0); // Start animation for the new story
    } else if (index < _lastReadIndex) {
      _controllers![_lastReadIndex].value =
          0.0; // Reset animation if moving backwards
      _controllers![index]
          .forward(from: 0.0); // Start animation for the new story
    }

    setState(() {
      _lastReadIndex = index; // Update the index for the current story
    });
  }

  Widget _buildStoryItem(StoryItem item, AnimationController controller) {
    if (item is StoryImage) {
      if (item.url != null) {
        // If it's a URL, use CachedNetworkImage
        return CachedNetworkImage(imageUrl: item.url!);
      } else if (item.assetPath != null) {
        if (item.assetPath!.endsWith('.json')) {
          // If it's a Lottie file
          return Lottie.asset(
            item.assetPath!,
            controller: controller,
            onLoaded: (composition) {
              controller.duration =
                  composition.duration; // Set animation duration
              controller.forward(); // Start animation
            },
          );
        } else {
          return Image.asset(
            item.assetPath!,
          );
        }
      }
    } else if (item is StoryVideoAsset) {
      // If it's a video, use the VideoPlayerWidget
      return VideoPlayerWidget(assetPath: item.assetPath);
    }
    return Container();
  }
}
