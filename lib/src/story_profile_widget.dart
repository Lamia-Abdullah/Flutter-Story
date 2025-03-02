import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:story_flow/story_flow.dart';

class StoryProfile extends StatefulWidget {
  final String profileImage;
  final List<StoryItem> storyItems;
  final bool isLottie; 
  final double size; 

  StoryProfile({
    required this.profileImage,
    required this.storyItems,
    this.isLottie = false,
    this.size = 60.0, // Default size
  });

  @override
  _StoryProfileState createState() => _StoryProfileState();
}

class _StoryProfileState extends State<StoryProfile> {
  bool isAllStoriesViewed =
      false; 

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final result = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => StoryView(
              items: widget.storyItems,
            ),
          ),
        );
        if (result == true) {
          // Update the state after all stories are viewed
          setState(() {
            isAllStoriesViewed = true;
          });
        }
      },
      child: Container(
        width: widget.size, // Set the width
        height: widget.size, // Set the height
        decoration: BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // CircleAvatar for the profile picture and background color
            CircleAvatar(
              radius:
                  widget.size / 2, // Half the size to control the internal size
              backgroundColor: isAllStoriesViewed
                  ? Colors.grey
                      .withOpacity(0.9) // Grey if all stories are viewed
                  : Colors.green, // Green if not all stories are viewed
              child: CircleAvatar(
                radius:
                    widget.size / 2 - 2, // Controls the size of the inner image
                backgroundImage: widget.isLottie
                    ? null
                    : AssetImage(widget.profileImage), // Use the image directly
                child: widget.isLottie
                    ? Lottie.asset(widget.profileImage, fit: BoxFit.cover)
                    : null,
              ),
            ),
            // Add a transparent grey overlay if all stories are viewed
            if (isAllStoriesViewed)
              Container(
                decoration: BoxDecoration(
                  color:
                      Colors.grey.withOpacity(0.4), 
                  shape: BoxShape.circle,
                ),
                width: widget.size,
                height: widget.size,
              ),
          ],
        ),
      ),
    );
  }
}
