import 'package:flutter/material.dart';
import '../../custom_widgets/end_activity_popup.dart';
import 'custom_widgets/letter.dart';
import 'custom_widgets/letter_space.dart';
import 'custom_widgets/word_box.dart';
import 'custom_widgets/audio_button.dart';
import '../../custom_widgets/return_button.dart';
import 'dart:math';

class DragSyllables extends StatefulWidget {  
  int storyId;
  int subStoryId;
  DragSyllables({super.key, required this.subStoryId, required this.storyId});

  @override
  _DragSyllablesState createState() => _DragSyllablesState();
}

class _DragSyllablesState extends State<DragSyllables> {
  // List of LetterBox widgets with unique keys
  List<Map<String, dynamic>> letterBoxList = [
    {'key': 'ca', 'widget': const LetterBox(text: 'ca')},
    {'key': 'be', 'widget': const LetterBox(text: 'be')},
    {'key': 'lo', 'widget': const LetterBox(text: 'lo')},
  ];

  Map<String, Offset> letterBoxPositions = {};
  final double boxWidth = 67; // Width of LetterBox
  final double boxHeight = 43; // Height of LetterBox
  final double minDistance = 10; // Minimum distance between boxes (padding)

  // The list for LetterSpace stays intact; it doesn't get removed
  final List<String> letterSpaceKeys = ['ca', 'be', 'lo'];

  @override
  void initState() {
    super.initState();
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
    final minY = screenHeight * 0.20;
    final maxY = screenHeight * 0.80 -
        boxHeight; // Ensure that box height doesn't exceed boundary

    setState(() {
      letterBoxList.forEach((item) {
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
      });
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
    // Define the callback function for when a correct letter is found
    void onCorrectLetterFound(bool correct, String key) {
      if (correct) {
        setState(() {
          // Remove the LetterBox with the matching key
          letterBoxList.removeWhere((item) => item['key'] == key);
        });
      }
    }

    if (letterBoxList.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Future.delayed(const Duration(milliseconds: 500), () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return EndActivityPopup(
                currentScreen: DragSyllables(subStoryId: widget.subStoryId, storyId: widget.storyId),
                story: widget.subStoryId != 0 ? true : false,
                storyId: widget.storyId,
                subStoryId: widget.subStoryId ,
                ctx: context               
              ); // Call your custom popup
            },
            barrierDismissible: false,
          );
        });
      });
    }
    // Create the LetterSpace list (this should not be removed)
    List<LetterSpace> letterSpaceList = letterSpaceKeys.map((key) {
      return LetterSpace(
        expectedLetter: key,
        correctLetterFound: (correct) => onCorrectLetterFound(
            correct, key), // Pass the key with the callback
      );
    }).toList();

    return Scaffold(
      body: Stack(
        children: [
          // Main UI and other elements
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        ReturnButton(
                          parentContext: context,
                        ), // Left button
                      ],
                    ),
                    AudioButton(), // Center button
                    const SizedBox(
                      width: 120,
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    WordBox(
                        text: const ['cabelo'],
                        correctText: [letterBoxList.isEmpty]),
                    // The word being spelled
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
            ...letterBoxList.map((item) {
              final key = item['key'] as String;
              final position = letterBoxPositions[key];

              return Positioned(
                left: position?.dx ?? 0, // Default to (0,0) if position is null
                top: position?.dy ?? 0,
                child: item['widget'] as Widget,
              );
            }),
        ],
      ),
    );
  }
}
