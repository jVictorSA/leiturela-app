import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';

import '../../custom_widgets/end_activity_popup.dart';
import '../../custom_widgets/return_button.dart';
import 'custom_widgets/activity_background.dart';
import 'custom_widgets/audio_button.dart';
import 'custom_widgets/golden_text.dart';
import 'custom_widgets/letter.dart';
import 'custom_widgets/letter_space.dart';
import 'custom_widgets/word_box.dart';

class BuildWord extends StatefulWidget {
  int storyId;
  int subStoryId;

  BuildWord({super.key, required this.subStoryId, required this.storyId});

  @override
  _BuildWordState createState() => _BuildWordState();
}

class _BuildWordState extends State<BuildWord> {
  final Set<int> invisibleIndices = {}; // Track syllables to hide
  int lastAddedId = 0; // Track the last added ID

  List<String> stringSyllables = ['In', 'com', 'pre', 'en', 'sí', 'vel'];

  List<Map<String, dynamic>> syllables = [];

  List<Map<String, dynamic>> shuffledSyllables = [];

  @override
  void initState() {
    super.initState();
    createSyllables();  // Create syllables from the list of strings
    shuffleSyllables(); // Shuffle the syllables
  }

  // Create the syllables list from the list of strings
  void createSyllables() {
    syllables = List.generate(stringSyllables.length, (index) {
      return {'id': index + 1, 'text': stringSyllables[index]};
    });
  }


  // Shuffle the syllables' text into a new list
  void shuffleSyllables() {
    shuffledSyllables =
        List.from(syllables); // Make a copy of the original list
    shuffledSyllables.shuffle(Random()); // Shuffle the copy
  }

  // Function to check if all syllables are invisible
  bool checkAllInvisible() {
    if (invisibleIndices.length == syllables.length) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    if (checkAllInvisible()){
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Future.delayed(const Duration(milliseconds: 500), () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return EndActivityPopup(
                  currentScreen: BuildWord(subStoryId: widget.subStoryId, storyId: widget.storyId),
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




    return Scaffold(
      body: ActivityBackground(
        child: Stack(
          children: [
            Column(
              children: [
                Row(
                  children: [
                    ReturnButton(parentContext: context),
                  ],
                ),
                const GoldenText(
                  text: 'Forme a palavra usando os botões',
                ),
                const Spacer(),
                AudioButton(
                  expectedSound: 'cabelo.wav',
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ...syllables.asMap().entries.map((entry) {
                      int index = entry.key;
                      String letter = entry.value['text'];
                      int id = entry.value['id'];

                      final isSolved = invisibleIndices.contains(id);

                      return Row(
                        children: [
                          isSolved
                              ? StaticLetterBox(
                                  text: letter,
                                )
                              : LetterSpace(
                                  expectedLetter: letter,
                                  correctLetterFound: (correct) {
                                    // Your logic for correct letter found
                                    return false; // Modify as needed
                                  },
                                ),
                          // Add a SizedBox except for the last letter
                          if (index < syllables.length - 1)
                            const SizedBox(
                              width: 16,
                            ),
                        ],
                      );
                    }).toList(),
                  ],
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: shuffledSyllables.map((syllable) {
                    final id = syllable['id'];
                    final text = syllable['text'];
                    final isInvisible = invisibleIndices.contains(id);
                    return isInvisible
                        ? const SizedBox(
                            width:
                                91, // Set the width to match your StaticLetterBox
                            height:
                                58, // Set the height to match your StaticLetterBox
                          )
                        : TextButton(
                            onPressed: () {
                              if (id == lastAddedId + 1) {
                                setState(() {
                                  invisibleIndices.add(
                                      id); // Add this specific ID to invisible set
                                  lastAddedId = id; // Update the last added ID
                                });
                              }
                            },
                            child: StaticLetterBox(
                              text: text,
                            ),
                          );
                  }).toList(),
                ),
                const Spacer(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
