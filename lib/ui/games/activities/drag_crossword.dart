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

import 'package:http/http.dart' as http;
import 'dart:convert';
import "package:demo_app/services/services.dart";

// Map<String, Map<String, List<String>>> activity = {
//   "body": {
//     "silabas": ['lo', 'bo', 'to', 'mia']
//   }
// };

class DragSyllables extends StatefulWidget {
  String storyId;
  int subStoryId;
  String activityId;
  String nextActivityId;

  DragSyllables({super.key,
                 required this.subStoryId,
                 required this.storyId,
                 this.activityId = "",
                 this.nextActivityId = ""
                });

  @override
  _DragSyllablesState createState() => _DragSyllablesState();
}

class _DragSyllablesState extends State<DragSyllables> {
  Map<String, Offset> letterBoxPositions = {};
  final double boxWidth = 67; // Width of LetterBox
  final double boxHeight = 43; // Height of LetterBox
  final double minDistance = 10; // Minimum distance between boxes (padding)

  String originalWord = 'computador';
  List<String> letterSpaceKeys = ['com', 'pu', 'ta', 'dor'];

  // List of LetterBox widgets with unique keys
  late List<Map<String, dynamic>> letterBoxList;

  bool dialogShown = false; // Add a flag to check if the dialog has been shown
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();

    if (widget.storyId != ""){
      fetchNextActivity(widget.storyId, widget.subStoryId).then((response) => {
        setState(() {        
          widget.nextActivityId = response;        
          
        })
      });

    }else{}

    fetchActivity(http.Client(), widget.activityId).then((response) => {
      setState(() {
        String entireObject;
        List<dynamic> ordenado;
        List<dynamic> desordenado;
        entireObject = response;        
        Map activity = json.decode(entireObject);

        letterSpaceKeys = activity["body"]["silabas"].cast<String>();

        letterBoxList = letterSpaceKeys.map((key) {
          return {
            'key': key,
            'widget': LetterBox(text: key, borderRadius: 15.0, width: 67),
          };
        }).toList();
        WidgetsBinding.instance
            .addPostFrameCallback((_) => generateRandomPositions());

        isLoaded = true;

      })
    
    
    });

    
  }

  void generateRandomPositions() {
    final random = Random();

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    const minX = 0;
    final maxX = screenWidth * 0.80 -
        boxWidth; // Ensure that box width doesn't exceed boundary

    // Y-axis limits with 5% on top and 5% on bottom
    final minY = screenHeight * 0.3;
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
      print(correct.toString() + "-----" + key);
      if (correct) {
        setState(() {
          // Remove the LetterBox with the matching key
          letterBoxList.removeWhere((item) => item['key'] == key);
        });
      }
    }

    if (isLoaded && letterBoxList.isEmpty && !dialogShown) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Future.delayed(const Duration(milliseconds: 500), () {
          // To avoid multiple calls to showDialog, we set a flag
          setState(() {
            dialogShown = true; // Ensure the dialog is only shown once
          });

          showDialog(
            context: context,
            builder: (BuildContext context) {
              return EndActivityPopup(
                  currentScreen: DragSyllables(
                      subStoryId: widget.subStoryId, storyId: widget.storyId),
                  story: widget.subStoryId != 0 ? true : false,
                  storyId: widget.storyId,
                  subStoryId: widget.subStoryId,
                  ctx: context);
            },
            barrierDismissible: false,
          );
        });
      });
    }
    if (isLoaded && letterBoxList.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Future.delayed(const Duration(milliseconds: 500), () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return EndActivityPopup(
                  currentScreen: DragSyllables(
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
    // Create the LetterSpace list (this should not be removed)
    List<LetterSpace> letterSpaceList = letterSpaceKeys.map((key) {
      return LetterSpace(
        expectedLetter: key,
        correctLetterFound: (correct) => onCorrectLetterFound(
            correct, key), // Pass the key with the callback
      );
    }).toList();

    return Scaffold(
      body: ActivityBackground(
          child: isLoaded ? Stack(
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
                          soundFiles: ['$originalWord.mp3'],
                        ),
                      ],
                    )
                  ],
                ),
                const Spacer(
                  flex: 2,
                ),
                const Spacer(
                  flex: 5,
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
                left: position?.dx ?? 0,
                // Default to (0,0) if position is null
                top: position?.dy ?? 0,
                child: item['widget'] as Widget,
              );
            }),
        ],
      )
      : const Column(mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [Center(child: CircularProgressIndicator(),)]
              ),
      )
    );
  }
}
