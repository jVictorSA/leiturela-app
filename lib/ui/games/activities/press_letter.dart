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

class PressLetter extends StatefulWidget {
  String storyId;
  int subStoryId;
  String activityId;
  String nextActivityId;

  PressLetter({super.key,
               required this.storyId,
               required this.subStoryId,
               this.activityId = "",
               this.nextActivityId = ""
              });

  @override
  _PressLetterState createState() => _PressLetterState();
}

class _PressLetterState extends State<PressLetter> {

  bool dialogShown = false;  // Add a flag to check if the dialog has been shown
  bool nextActivityLoaded = false;
  bool isLoaded = false;

  late final DateTime timeStartActivity; // Será utilizado para calcula tempo para o relatório.

  String letter = 'H';

  List<String> wordList = ["Ventania", "Luz", "Caminho", "Sonho"];

  Color defaultColor = Colors.black;
  Color correctColor = const Color(0xFF21D304);
  Color incorrectColor = const Color(0xFFA90C0C);


  List<List<Map<String, bool>>> result = [];
  List<String> questionText = [];
  int numbersFound = 999;
  int _foundCount = 999;  // Mutable state to track the count
  TextSpan printedText = TextSpan();

  List<List<Map<String, bool>>> getResult(List<String> words){
    List<List<Map<String, bool>>> result = words.map((word) {
        return word.split('').map((char) {
          return {
            char: char.toUpperCase() == letter || char.toLowerCase() == letter
          };
        }).toList();
      }).toList();    

    return result;
  }

  void _decrementNumbersFound() {
    setState(() {
      if (_foundCount > 0) {
        _playSounds("correct_sound.wav");
        _foundCount -= 1;  // Decrement the count directly
        print(_foundCount);
      }
    });
  }
  @override
  void initState() {

    timeStartActivity = DateTime.now();

    super.initState();
    if (widget.storyId != ""){
      fetchNextActivity(widget.storyId, widget.subStoryId).then((response) => {
        setState(() {        
          widget.nextActivityId = response;        
          nextActivityLoaded = true;
          var activityDuration = DateTime.now().difference(timeStartActivity); // Mandar essa variável para o back do relatório.
        })
      });

    }else{}

    fetchActivity(http.Client(), widget.activityId).then((response) => {
      setState(() {
        String entireObject;        
        entireObject = response;
        Map activity = json.decode(entireObject);

        print(activity);

        letter = activity['body']['letra'];
        wordList = activity['body']['silabas'].cast<String>();
        
        result = getResult(wordList);

        questionText.add("Escolha a letra ");
        questionText.add(letter);
        questionText.add(" ou ");
        questionText.add(letter.toUpperCase());
          
        numbersFound = result
                      .expand((wordMaps) => wordMaps)
                      .where((map) => map.values.first)
                      .length;        

        printedText = TextSpan(
          children: [
            WidgetSpan(
              child: GoldenTextSpecial(
                text: questionText[0],
                textSize: 25,
                // Adjust as needed
                borderColor: 0xFF012480,
                // Adjust as needed
                borderWidth: 3,
                fontWeight: FontWeight.w500,
              ),
            ),
            const WidgetSpan(
              child: SizedBox(width: 8), // Adjust the width for desired spacing
            ),
            TextSpan(
              text: questionText[1],
              style: const TextStyle(
                color: Colors.black,
                fontSize: 30,
                fontFamily: 'Playpen-Sans', // Fixed font family
                fontWeight: FontWeight.bold,
              ), // Style for normal text
            ),
            WidgetSpan(
              child: GoldenTextSpecial(
                text: questionText[2],
                textSize: 25,
                // Adjust as needed
                borderColor: 0xFF012480,
                // Adjust as needed
                borderWidth: 3,
                fontWeight: FontWeight.w500,
              ),
            ),
            TextSpan(
              text: questionText[3],
              style: const TextStyle(
                color: Colors.black,
                fontSize: 30,
                fontFamily: 'Playpen-Sans', // Fixed font family
                fontWeight: FontWeight.bold,
              ), // Style for normal text
            ),
          ],
        );

        print(numbersFound);
        _foundCount = numbersFound - 1;

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

    if (isLoaded && _foundCount <= 0 && !dialogShown) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _playSounds("act_end_sound.wav");
        Future.delayed(const Duration(milliseconds: 30), () {
          // To avoid multiple calls to showDialog, we set a flag
          setState(() {
            dialogShown = true; // Ensure the dialog is only shown once
          });

          showDialog(
            context: context,
            builder: (BuildContext context) {
              return EndActivityPopup(
                  currentScreen: PressLetter(
                      subStoryId: widget.subStoryId, storyId: widget.storyId),
                  story: widget.subStoryId != 0 ? true : false,
                  storyId: widget.storyId,
                  subStoryId: widget.subStoryId,
                  ctx: context
              );
            },
            barrierDismissible: false,
          );
        });
      });
    }

    return Scaffold(
      body: ActivityBackground(
        child: isLoaded ? Stack(children: [
          Column(
            children: [
              Row(
                children: [
                  ReturnButton(parentContext: context),
                ],
              ),
              RichText(
                text: printedText,
              ),
              const SizedBox(
                height: 32,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(
                      flex: 2,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: wordList[0].split('').map((char) {
                            // Find the map for the first word (wordList[0]) in 'result'
                            // Use result[0] because we want to get the map for the first word
                            // The map in result[0] has each character as the key and a boolean as the value
                            bool isAnswer = result[0].firstWhere(
                                    (map) => map.containsKey(char),
                                    orElse: () => {char: false})[char] ??
                                false;

                            return PressableLetters(
                              letterText: char,
                              isAnswer: isAnswer,
                              onTap: _decrementNumbersFound,
                            );
                          }).toList(),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: wordList[1].split('').map((char) {
                            // Find the map for the first word (wordList[0]) in 'result'
                            // Use result[0] because we want to get the map for the first word
                            // The map in result[0] has each character as the key and a boolean as the value
                            bool isAnswer = result[1].firstWhere(
                                    (map) => map.containsKey(char),
                                orElse: () => {char: false})[char] ??
                                false;

                            return PressableLetters(
                              letterText: char,
                              isAnswer: isAnswer,
                              onTap: _decrementNumbersFound,
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                    Spacer(),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          // list string: ['casa' , 'amor',...]
                          children: wordList[2].split('').map((char) {
                            // Find the map for the first word (wordList[0]) in 'result'
                            // Use result[0] because we want to get the map for the first word
                            // The map in result[0] has each character as the key and a boolean as the value
                            bool isAnswer = result[2].firstWhere(
                                    (map) => map.containsKey(char),
                                orElse: () => {char: false})[char] ??
                                false;

                            return PressableLetters(
                              onTap: _decrementNumbersFound,
                              letterText: char,
                              isAnswer: isAnswer,
                            );
                          }).toList(),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: wordList[3].split('').map((char) {
                            bool isAnswer = result[3].firstWhere(
                                    (map) => map.containsKey(char),
                                orElse: () => {char: false})[char] ??
                                false;
                            return PressableLetters(
                              onTap: _decrementNumbersFound,
                              letterText: char,
                              isAnswer: isAnswer,
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                    const Spacer(
                      flex: 2,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 32,
              ),
            ],
          ),
        ])
        : const Column(mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [Center(child: CircularProgressIndicator(),)]
              ),
      ),
    );
  }
}
