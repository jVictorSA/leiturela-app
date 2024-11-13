import 'package:demo_app/ui/games/activities/custom_widgets/golden_text.dart';
import 'package:flutter/material.dart';
import '../../custom_widgets/end_activity_popup.dart';
import 'custom_widgets/activity_background.dart';
import 'custom_widgets/letter.dart';
import 'custom_widgets/letter_space.dart';
import 'custom_widgets/word_box.dart';
import 'custom_widgets/audio_button.dart';
import '../../custom_widgets/return_button.dart';
import 'dart:math';

class CompleteWord extends StatefulWidget {
  int storyId;
  int subStoryId;

  CompleteWord({super.key, required this.subStoryId, required this.storyId});

  @override
  _CompleteWordState createState() => _CompleteWordState();
}

class _CompleteWordState extends State<CompleteWord> {
  Map<String, Offset> letterBoxPositions = {};
  final double boxWidth = 67; // Width of LetterBox
  final double boxHeight = 43; // Height of LetterBox
  final double minDistance = 10; // Minimum distance between boxes (padding)

  // The list for LetterSpace stays intact; it doesn't get removed
  final List<String> letterSpaceKeys = ['ca', 'be', 'lo'];
  final List<String> randomSyllablesList = ['ma', 'pe', 'lo'];

  bool dialogShown = false; // Add a flag to check if the dialog has been shown

// Combine otherEntries with the original letterBoxList
  late List<Map<String, dynamic>> combinedList;

  // List of LetterBox widgets with unique keys
  late List<Map<String, dynamic>> letterBoxList;
  late List<Widget> letterSpaceList;

  // Define the callback function for when a correct letter is found
  void onCorrectLetterFound(bool correct, String key) {
    if (correct) {
      setState(() {
        // Remove the LetterBox with the matching key
        letterBoxList.removeWhere((item) => item['key'] == key);
        combinedList.removeWhere((item) => item['key'] == key);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    final randomIndex =
        Random().nextInt(letterSpaceKeys.length); // Pick a random index
    final randomKey = letterSpaceKeys[randomIndex];

    letterBoxList = [
      {
        'key': randomKey,
        'widget': LetterBox(text: randomKey),
      }
    ];
    List<Map<String, dynamic>> randomSyllables =
        randomSyllablesList.map((random_key) {
      return {
        'key': random_key,
        'widget': LetterBox(text: random_key),
      };
    }).toList();

    final filteredSyllables =
        randomSyllables.where((item) => item['key'] != randomKey).toList();
    combinedList = [...filteredSyllables, ...letterBoxList];

    // Create the LetterSpace list (this should not be removed)
    letterSpaceList = letterSpaceKeys.map((key) {
      if (key == randomKey) {
        return LetterSpace(
          expectedLetter: key,
          correctLetterFound: (correct) => onCorrectLetterFound(correct, key),
        );
      } else {
        return StaticLetterBox(text: key);
      }
    }).toList();

    WidgetsBinding.instance
        .addPostFrameCallback((_) => generateRandomPositions());
  }

  void generateRandomPositions() {
    final random = Random();

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // X-axis limits with 10% on both sides
    const minX = 0;
    final maxX = screenWidth * 0.80 -
        boxWidth; // Ensure that box width doesn't exceed boundary

    // Y-axis limits with 5% on top and 5% on bottom
    final minY = screenHeight * 0.3;
    final maxY = screenHeight * 0.80 -
        boxHeight; // Ensure that box height doesn't exceed boundary

    setState(() {
      for (var item in combinedList) {
        final key = item['key'] as String;

        if (!letterBoxPositions.containsKey(key)) {
          Offset newPosition;

          do {
            // Generate a random position within defined bounds
            newPosition = Offset(
              minX + random.nextDouble() * (maxX - minX), // X within bounds
              minY + random.nextDouble() * (maxY - minY), // Y within bounds
            );
          } while (isOverlapping(newPosition));

          letterBoxPositions[key] = newPosition;
        }
      }
    });
  }

  // Check if the new position overlaps with any existing positions
  bool isOverlapping(Offset newPosition) {
    for (var existingPosition in letterBoxPositions.values) {
      if (_isColliding(existingPosition, newPosition)) {
        return true; // Collision found
      }
    }

    return false; // No collision
  }

  // Check if two boxes collide based on their positions and dimensions
  bool _isColliding(Offset pos1, Offset pos2) {
    return (pos1.dx < pos2.dx + boxWidth + minDistance &&
        pos1.dx + boxWidth + minDistance > pos2.dx &&
        pos1.dy < pos2.dy + boxHeight + minDistance &&
        pos1.dy + boxHeight + minDistance > pos2.dy);
  }

  @override
  Widget build(BuildContext context) {
    if (letterBoxList.isEmpty && !dialogShown) {
      setState(() {
        dialogShown = true;
      });
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Future.delayed(const Duration(milliseconds: 500), () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return EndActivityPopup(
                  currentScreen: CompleteWord(
                      subStoryId: widget.subStoryId, storyId: widget.storyId),
                  story: widget.subStoryId != 0 ? true : false,
                  storyId: widget.storyId,
                  subStoryId: widget.subStoryId,
                  ctx: context); // Call your custom popup
            },
            barrierDismissible: false,
          );
        });
      });
    }
    return Scaffold(
      body: ActivityBackground(
          child: Stack(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(top: 10, right: 20, bottom: 20, left: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ReturnButton(
                              parentContext: context,
                            ),
                            const Spacer(flex: 3),
                            const Column(
                              children: [
                                GoldenText(
                                    text: "Monte a palavra usando as sílabas"),
                              ],
                            ),
                            const Spacer(
                              flex: 6,
                            ),
                          ],
                        ),
                        AudioButton(
                          soundFiles: ['cabelo.wav'],
                        ),
                      ],
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Wrap(
                      spacing: 20.0, // Space between items
                      alignment: WrapAlignment.center, // Center the items
                      children: letterSpaceList, // LetterSpace list
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Stack containing randomly positioned LetterBox widgets
          if (letterBoxPositions.isNotEmpty)
            ...combinedList.map((item) {
              final key = item['key'] as String;
              final position = letterBoxPositions[key];

              return Positioned(
                left: position?.dx ?? 0,
                // Default to (0,0) if position is null
                top: position?.dy ?? 0,
                child: item['widget'] as Widget,
              );
            }),
        ],
      )),
    );
  }
}
