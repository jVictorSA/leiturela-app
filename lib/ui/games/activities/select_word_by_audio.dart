import 'package:flutter/material.dart';
import '../../custom_widgets/custom_button.dart';
import '../../custom_widgets/end_activity_popup.dart';
import '../../custom_widgets/return_button.dart';
import 'custom_widgets/activity_background.dart';
import 'custom_widgets/audio_button.dart';
import 'custom_widgets/golden_text.dart';

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

  late final DateTime timeStartActivity; // Será utilizado para calcula tempo para o relatório.

  List<String> originalWord = ['Computador', 'Casa', 'Bolo', 'Macieira'];

  String audioWord = 'carro';

  late String letter = audioWord[0];

  @override
  Widget build(BuildContext context) {
    if (answerFound && !dialogShown) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Future.delayed(const Duration(milliseconds: 500), () {
          // To avoid multiple calls to showDialog, we set a flag
          setState(() {
            dialogShown = true; // Ensure the dialog is only shown once
            var activityDuration = DateTime.now().difference(timeStartActivity); // Mandar essa variável para o back do relatório.
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
                  soundFiles: ['$audioWord.mp3'],
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
                          label: originalWord[0],
                          onPressed: () {
                            setState(() {
                              if (originalWord[0][0]
                                  .toLowerCase()
                                  == (letter.toLowerCase())) {
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
                          label: originalWord[1],
                          onPressed: () {
                            setState(() {
                              if (originalWord[1][0]
                                  .toLowerCase()
                                   == (letter.toLowerCase())) {
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
                          label: originalWord[2],
                          onPressed: () {
                            setState(() {
                              if (originalWord[2][0]
                                  .toLowerCase()
                                  == (letter.toLowerCase())) {
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
                          label: originalWord[3],
                          onPressed: () {
                            setState(() {
                              if (originalWord[3][0]
                                  .toLowerCase()
                                  ==(letter.toLowerCase())) {
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
