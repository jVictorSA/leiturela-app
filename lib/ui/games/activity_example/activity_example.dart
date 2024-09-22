import 'package:flutter/material.dart';
import 'custom_widgets/letter.dart'; // Import your LetterBox widget
import 'custom_widgets/letter_space.dart';
import 'custom_widgets/word_box.dart';
import 'custom_widgets/audio_button.dart';
import '../../custom_widgets/return_button.dart';
import 'dart:math';

class ActivityExampleApp extends StatefulWidget {
  const ActivityExampleApp({super.key});

  @override
  _ActivityExampleAppState createState() => _ActivityExampleAppState();
}

class _ActivityExampleAppState extends State<ActivityExampleApp> {
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
    final maxX = MediaQuery.of(context).size.width -
        boxWidth -
        160; // 160 away from the right
    final maxY = MediaQuery.of(context).size.height -
        boxHeight -
        75; // 75 away from the top

    setState(() {
      letterBoxList.forEach((item) {
        final key = item['key'] as String;

        if (!letterBoxPositions.containsKey(key)) {
          Offset newPosition;

          do {
            // Generate a random position
            newPosition = Offset(
              random.nextDouble() * maxX,
              random.nextDouble() * maxY,
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

    // Create the LetterSpace list (this should not be removed)
    List<LetterSpace> letterSpaceList = letterSpaceKeys.map((key) {
      return LetterSpace(
        expectedLetter: key,
        correctLetterFound: (correct) => onCorrectLetterFound(
            correct, key), // Pass the key with the callback
      );
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFAAE0F1),
      body: Stack(
        children: [
          // Main UI and other elements
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const SizedBox(width: 25),
                      ReturnButton(
                        parentContext: context,
                      ), // Left button
                    ],
                  ),
                  AudioButton(), // Center button
                  const SizedBox(width: 80), // Placeholder for spacing
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  WordBox(
                      text: const ['cabelo'],
                      correctText: [letterBoxList.isEmpty]),
                  // The word being spelled
                  const SizedBox(width: 25),
                ],
              ),
              const SizedBox(height: 50),
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
              const SizedBox(height: 50),
            ],
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
            }).toList(),
        ],
      ),
    );
  }
}
