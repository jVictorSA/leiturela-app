import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';

import '../../custom_widgets/custom_button.dart';
import '../../custom_widgets/end_activity_popup.dart';
import '../../custom_widgets/return_button.dart';
import 'custom_widgets/activity_background.dart';
import 'custom_widgets/audio_button.dart';
import 'custom_widgets/golden_text.dart';
import 'custom_widgets/letter.dart';
import 'custom_widgets/letter_space.dart';
import 'custom_widgets/word_box.dart';

class SelectWordAudio extends StatefulWidget {
  String storyId;
  int subStoryId;

  SelectWordAudio({super.key, required this.subStoryId, required this.storyId});

  @override
  _SelectWordAudioState createState() => _SelectWordAudioState();
}

class _SelectWordAudioState extends State<SelectWordAudio> {
  bool answerFound = false;
  bool dialogShown = false; // Add a flag to check if the dialog has been shown

  final String wordOne = 'Montanha';
  final String wordTwo = 'Papagaio';
  final String wordThree = 'Bota';
  final String wordFour = 'Cobra';

  final String letter = 'c';

  @override
  Widget build(BuildContext context) {
    if (answerFound && !dialogShown) {
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
                  currentScreen: SelectWordAudio(
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
                Spacer(),
                const GoldenText(
                  text:
                      'Escolha a palavra com a mesma primeira letra que o áudio.',
                ),
                const Spacer(
                  flex: 2,
                ),
                AudioButton(
                  soundFiles: ['cabelo.wav'],
                ),
                const Spacer(
                  flex: 2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(
                      flex: 2,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CustomButton(
                          label: wordOne,
                          onPressed: () {
                            setState(() {
                              if (wordOne
                                  .toLowerCase()
                                  .contains(letter.toLowerCase())) {
                                answerFound = true;
                              }
                            });
                          },
                          width: 160,
                          height: 56,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        CustomButton(
                          label: wordTwo,
                          onPressed: () {
                            setState(() {
                              if (wordTwo
                                  .toLowerCase()
                                  .contains(letter.toLowerCase())) {
                                answerFound = true;
                              }
                            });
                          },
                          width: 160,
                          height: 56,
                        ),
                      ],
                    ),
                    const Spacer(
                      flex: 1,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CustomButton(
                          label: wordThree,
                          onPressed: () {
                            setState(() {
                              if (wordThree
                                  .toLowerCase()
                                  .contains(letter.toLowerCase())) {
                                answerFound = true;
                              }
                            });
                          },
                          width: 160,
                          height: 56,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        CustomButton(
                          label: wordFour,
                          onPressed: () {
                            setState(() {
                              if (wordFour
                                  .toLowerCase()
                                  .contains(letter.toLowerCase())) {
                                answerFound = true;
                              }
                            });
                          },
                          width: 160,
                          height: 56,
                        )
                      ],
                    ),
                    const Spacer(
                      flex: 2,
                    ),
                  ],
                ),
                const Spacer(
                  flex: 2,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
