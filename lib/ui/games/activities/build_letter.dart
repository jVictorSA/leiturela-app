import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../custom_widgets/end_activity_popup.dart';
import '../../custom_widgets/return_button.dart';
import 'custom_widgets/activity_background.dart';
import 'custom_widgets/audio_button.dart';
import 'custom_widgets/golden_text.dart';
import 'custom_widgets/letter.dart';
import 'custom_widgets/letter_space.dart';

import 'custom_widgets/word_box.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import "package:demo_app/services/services.dart";

class BuildWord extends StatefulWidget {
  String storyId;
  int subStoryId;
  String activityId;

  BuildWord({super.key,
             required this.subStoryId,
             required this.storyId,
             this.activityId = ""
            });

  @override
  _BuildWordState createState() => _BuildWordState();
}

class _BuildWordState extends State<BuildWord> {
  String nextActivityId = "";
  bool isLoaded = false;

  late final DateTime timeStartActivity; // Será utilizado para calcula tempo para o relatório.

  final Set<int> invisibleIndices = {}; // Track syllables to hide
  int lastAddedId = 0; // Track the last added ID

  late String originalWord;

  List<String> stringSyllables = [];

  List<Map<String, dynamic>> syllables = [];

  List<Map<String, dynamic>> shuffledSyllables = [];

  bool dialogShown = false;  // Add a flag to check if the dialog has been shown

  @override
  void initState() {
    super.initState();

    timeStartActivity = DateTime.now();

    if (widget.storyId != ""){
      fetchNextActivity(widget.storyId, widget.subStoryId).then((response) => {
        setState(() {
          nextActivityId = response;

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
        // print("fetch activity id: " + widget.activityId);

        // print("atividade:\n" + activity.toString());

        ordenado = activity["answer"]["ordenado"];

        originalWord = ordenado.join();

        desordenado = activity["body"]["desordenado"];
        stringSyllables = ordenado.cast<String>();

        // Para pegar o áudio eu preciso da palavra completa
        originalWord = stringSyllables.join("");

        //ESSES DOIS FOR SÓ EXISTEM PORQUE AS SÍLABAS NÃO ESTÃO PADRONIZADAS NO BANCO!!!!!!!!!!!!!!!!!!
        for(int i = 0; i < stringSyllables.length; i++){
          stringSyllables[i] = removerAcentos(stringSyllables[i]);
        }
        for(int i = 0; i < desordenado.length; i++){
          desordenado[i] = removerAcentos(desordenado[i]);
        }

        createSyllables();  // Create syllables from the list of strings
        shuffleSyllables(desordenado); // Shuffle the syllables

        isLoaded = true;
      })
    });

    // fetchNextActivity(widget.storyId, widget.subStoryId).then((response) => {
    //   setState(() {
    //     nextActivityId = response;
    //   })
    // });
  }

  // Remove quaisquer acentos existentes numa string
  String removerAcentos(String str) {

    var comAcento = 'ÀÁÂÃÄÅàáâãäåÒÓÔÕÕÖØòóôõöøÈÉÊËèéêëðÇçÐÌÍÎÏìíîïÙÚÛÜùúûüÑñŠšŸÿýŽž';
    var semAcento = 'AAAAAAaaaaaaOOOOOOOooooooEEEEeeeeeCcDIIIIiiiiUUUUuuuuNnSsYyyZz';

    for (int i = 0; i < comAcento.length; i++) {
      str = str.replaceAll(comAcento[i], semAcento[i]);
    }

    return str;
  }

  // Create the syllables list from the list of strings
  void createSyllables() {
    syllables = List.generate(stringSyllables.length, (index) {
      return {'id': index + 1, 'text': stringSyllables[index]};
    });
  }

  // Shuffle the syllables' text into a new list
  void shuffleSyllables(unorderedSylllables) {
    unorderedSylllables.forEach((value) {
      syllables.forEach((value1) {
        if(value == value1['text']){
          shuffledSyllables.add(value1);
        }
        });
    });
  }

  // Function to check if all syllables are invisible
  bool checkAllInvisible() {
    if (invisibleIndices.length == syllables.length) {
      return true;
    }
    return false;
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
    if (checkAllInvisible() && !dialogShown && isLoaded){
      setState(() {
        dialogShown = true;
        var activityDuration = DateTime.now().difference(timeStartActivity); // Mandar essa variável para o back do relatório.
      });
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _playSounds("act_end_sound.wav");
        Future.delayed(const Duration(milliseconds: 500), () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return EndActivityPopup(
                  currentScreen: BuildWord(subStoryId: widget.subStoryId, storyId: widget.storyId),
                  story: widget.subStoryId != 0 ? true : false,
                  storyId: widget.storyId,
                  subStoryId: widget.subStoryId,
                  nextActivityId: nextActivityId,
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
        child: isLoaded ? Stack(
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
                  soundFiles: ["word_sounds/$originalWord.mp3"],
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
                                    return false;
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
                                _playSounds("correct_sound.wav");
                                setState(() {
                                  invisibleIndices.add(
                                      id); // Add this specific ID to invisible set
                                  lastAddedId = id; // Update the last added ID
                                });
                              } else{
                                _playSounds("wrong_sound.wav");
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
        )
        : const Column(mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [Center(child: CircularProgressIndicator(),)]
                ),
      ),
    );
  }
}
