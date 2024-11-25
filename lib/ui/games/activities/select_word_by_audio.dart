import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../custom_widgets/custom_button.dart';
import '../../custom_widgets/end_activity_popup.dart';
import '../../custom_widgets/return_button.dart';
import 'custom_widgets/activity_background.dart';
import 'custom_widgets/audio_button.dart';
import 'custom_widgets/golden_text.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import "package:demo_app/services/services.dart";

class SelectWordAudio extends StatefulWidget {
  String storyId;
  int subStoryId;
  String activityId;
  String nextActivityId;

  SelectWordAudio({super.key,
                  required this.subStoryId,
                  required this.storyId,
                  this.activityId = "",
                  this.nextActivityId = ""
                  });

  @override
  _SelectWordAudioState createState() => _SelectWordAudioState();
}

class _SelectWordAudioState extends State<SelectWordAudio> {
  bool answerFound = false;
  bool dialogShown = false; // Add a flag to check if the dialog has been shown
  bool nextActivityLoaded = false;
  bool isLoaded = false;

  late final DateTime timeStartActivity; // Será utilizado para calcula tempo para o relatório.

  List<String> originalWord = ['Computador', 'Casa', 'Bolo', 'Macieira'];

  String audioWord = 'carro';

  late String letter = audioWord[0];

  @override
  void initState() {
    super.initState();
    timeStartActivity = DateTime.now();

    if (widget.storyId != ""){
      fetchNextActivity(widget.storyId, widget.subStoryId).then((response) => {
        setState(() {        
          widget.nextActivityId = response;        
          nextActivityLoaded = true;
          var activityDuration = DateTime.now().difference(timeStartActivity); // Mandar essa variável para o back do relatório.

          nextActivityLoaded = true;
        })
      });      

    }else{}

    fetchActivity(http.Client(), widget.activityId).then((response) => {
      setState(() {
        String entireObject;        
        entireObject = response;
        Map activity = json.decode(entireObject);

        print(activity);

        originalWord = activity["body"]["words"].cast<String>();
        audioWord = activity["body"]["word"];

        isLoaded = true;
      })
    });

  }

  void _playSounds(String sound) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    int? volumePref = _prefs.getInt('efeitos');
    double volume = (volumePref ?? 5).toDouble() / 10; // Default to 5 if null

    final AudioPlayer soundPlayer = AudioPlayer();

    try {
      await soundPlayer.setVolume(volume);
      await soundPlayer.play(AssetSource('audio/sound_effects/$sound')); // Play each sound
      await soundPlayer.onPlayerComplete.first; // Wait until the current sound finishes
    } finally {
      soundPlayer.dispose(); // Dispose of the player after sound finishes
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoaded && answerFound && !dialogShown) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _playSounds("act_end_sound.wav");
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
                  nextActivityId: widget.nextActivityId,
                  ctx: context);
            },
            barrierDismissible: false,
          );
        });
      });
    }

    return Scaffold(
      body: ActivityBackground(
        child: isLoaded ? Stack(
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
                  soundFiles: ['word_sounds/$audioWord.mp3'],
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
                              } else {
                                _playSounds("wrong_sound.wav");
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
                              } else {
                                _playSounds("wrong_sound.wav");
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
                              } else {
                                _playSounds("wrong_sound.wav");
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
                              } else{
                                _playSounds("wrong_sound.wav");
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
        )
        : const Column(mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [Center(child: CircularProgressIndicator(),)]
              ),
      ),
    );
  }
}
