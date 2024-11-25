import 'package:audioplayers/audioplayers.dart';
import 'package:demo_app/ui/games/activities/custom_widgets/pressable_letters.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../custom_widgets/end_activity_popup.dart';
import '../../custom_widgets/return_button.dart';
import 'custom_widgets/activity_background.dart';
import 'custom_widgets/golden_text_special_case.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import "package:demo_app/services/services.dart";

class PressSyllable extends StatefulWidget {
  String storyId;
  int subStoryId;
  String syllable;
  String activityId;
  String nextActivityId;

  PressSyllable(
      {super.key,
      required this.storyId,
      required this.subStoryId,
      this.syllable = "",
      this.activityId = "",
      this.nextActivityId = ""});

  @override
  _PressSyllableState createState() => _PressSyllableState();
}

class _PressSyllableState extends State<PressSyllable> {
  bool dialogShown = false;
  bool nextActivityLoaded = false;
  bool isLoaded = false;

  // String nextActivityId = "";
  var result;

  late final DateTime
      timeStartActivity; // Será utilizado para calcula tempo para o relatório.

  List<String> wordList = ["Bolo", "Bobagem", "Lista", "Marte"];

  Color defaultColor = Colors.black;
  Color correctColor = const Color(0xFF21D304);
  Color incorrectColor = const Color(0xFFA90C0C);

  int numbersFound = 999;

  // Função que verifica se a palavra contém ou começa com a sílaba/letra
  bool checkSyllable(String word, String syllable) {
    return word.toLowerCase().contains(syllable.toLowerCase());
  }

  // int numbersFound = 0;

  @override
  void initState() {
    super.initState();

    timeStartActivity = DateTime.now();

    if (widget.storyId != "") {
      fetchNextActivity(widget.storyId, widget.subStoryId).then((response) => {
            setState(() {
              widget.nextActivityId = response;
              nextActivityLoaded = true;
            })
          });
    } else {
      nextActivityLoaded = true;
    }

    fetchActivity(http.Client(), widget.activityId).then((response) => {
          setState(() {
            String entireObject;
            String silaba;
            List<String> palavras = [];
            entireObject = response;
            Map activity = json.decode(entireObject);

            palavras = activity['body']['palavras'].cast<String>();

            wordList = palavras;
            silaba = activity['body']['silaba'].toString();
            widget.syllable = silaba;

            result = wordList.map((word) {
              return {'word': word, 'isCorrect': false, 'isAnswered': false};
            }).toList();

            result = wordList.map((word) {
              bool isCorrect = checkSyllable(word, widget.syllable);
              return {
                'word': word,
                'isCorrect': isCorrect,
                'isAnswered': false
              };
            }).toList();

            numbersFound = result
                .where((map) =>
                    map['isCorrect'] == true && map['isAnswered'] == false)
                .length;
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
      await soundPlayer
          .play(AssetSource('audio/sound_effects/$sound')); // Play each sound
      await soundPlayer
          .onPlayerComplete.first; // Wait until the current sound finishes
    } finally {
      soundPlayer.dispose(); // Dispose of the player after sound finishes
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: ActivityBackground(
        child: isLoaded
            ? Stack(children: [
                Column(
                  children: [
                    Row(
                      children: [
                        ReturnButton(parentContext: context),
                      ],
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          WidgetSpan(
                            child: GoldenTextSpecial(
                              text:
                                  "Escolha as palavras que contêm a sílaba '${widget.syllable}'",
                              textSize: 25,
                              borderColor: 0xFF012480,
                              borderWidth: 3,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: result.map<Widget>((map) {
                          String word = map['word'] as String;
                          bool isCorrect = map['isCorrect'] as bool;
                          bool isAnswered = map['isAnswered'] as bool;

                          return PressableLetters(
                            letterText: word,
                            isAnswer: isCorrect,
                            onTap: () {
                              if (!isAnswered) {
                                setState(() {
                                  if (isCorrect) {
                                    // Marque como respondida
                                    map['isAnswered'] = true;
                                    _playSounds("correct_sound.wav");
                                    numbersFound -= 1;
                                  }
                                  // Verifica se todas as palavras corretas foram encontradas
                                  if (numbersFound <= 0 && !dialogShown) {
                                    _playSounds("act_end_sound.wav");
                                    WidgetsBinding.instance
                                        .addPostFrameCallback((_) {
                                      Future.delayed(
                                          const Duration(milliseconds: 500),
                                          () {
                                        setState(() {
                                          dialogShown =
                                              true; // Evite que o diálogo seja mostrado várias vezes
                                        });
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return EndActivityPopup(
                                                currentScreen: PressSyllable(
                                                    subStoryId:
                                                        widget.subStoryId,
                                                    storyId: widget.storyId,
                                                    syllable: widget.syllable),
                                                story: widget.subStoryId != 0
                                                    ? true
                                                    : false,
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
                                });
                              }
                            },
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                  ],
                ),
              ])
            : const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                    Center(
                      child: CircularProgressIndicator(),
                    )
                  ]),
      ),
    );
  }
}
