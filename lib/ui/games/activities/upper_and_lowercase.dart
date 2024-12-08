import 'package:demo_app/ui/custom_widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'custom_widgets/activity_background.dart';
import 'custom_widgets/letter.dart';
import '../../custom_widgets/return_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:audioplayers/audioplayers.dart';
import '../../custom_widgets/end_activity_popup.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import "package:demo_app/services/services.dart";
import 'custom_widgets/golden_text_special_case.dart';

class UpperLower extends StatefulWidget {
  String storyId;
  int subStoryId;
  String activityId;
  String nextActivityId;

  UpperLower(
      {super.key,
      required this.storyId,
      required this.subStoryId,
      this.activityId = "",
      this.nextActivityId = ""});

  @override
  _UpperLowerState createState() => _UpperLowerState();
}

class _UpperLowerState extends State<UpperLower> {
  bool nextActivityLoaded = false;
  bool isLoaded = false;
  bool isSolved = false;
  bool dialogShown = false;
  int toSolve = 4;

  double width = 250.0;
  List<String> minusculas = ["furacão", "batata", "pequeno", "roupa"];
  late List<String> maiusculas = [];
  List<Map<int, String>> minors = [];
  List<int> shuffledIndexes = [0, 1, 2, 3];
  int majorSelected = 999;
  int minorSelected = 999;
  List<bool> minorSolved = [false, false, false, false];
  List<bool> majorSolved = [false, false, false, false];



  List<String> get questionText =>
      ["Selecione os pares de palavras maiúsculas e minúsculas"];

  List<Map<int, int>> matches = [];
  late final DateTime
      timeStartActivity; // Será utilizado para calcula tempo para o relatório.

  static const List<Color> defaultMinorColor = [
    Color(0xFFE1E6F1),
    Color(0xFF3156FB),
    Color(0xFF3199FB)
  ];

  static const List<Color> minorSelectedColor = [
    Color(0xFFE1E6F1),
    Color(0xFF31FB4C),
    Color(0xFF67B867)
  ];

  static const List<Color> defaultMajorColor = [
    Color(0xFFFFF3B8),
    Color(0xFFF7FB31),
    Color(0xFFFBB631)
  ];

  Color boxShadowColor = const Color(0xFF31E3FB);

  @override
  void initState() {
    super.initState();
    timeStartActivity = DateTime.now();

    if (widget.storyId != "") {
      fetchNextActivity(widget.storyId, widget.subStoryId).then((response) => {
            setState(() {
              widget.nextActivityId = response;
              nextActivityLoaded = true;
              var activityDuration = DateTime.now().difference(
                  timeStartActivity); // Mandar essa variável para o back do relatório.

              nextActivityLoaded = true;
            })
          });
    } else {}

    fetchActivity(http.Client(), widget.activityId).then((response) => {
          setState(() {
            String entireObject;
            entireObject = response;
            Map activity = json.decode(entireObject);            

            minusculas = activity['body']['minusculas'].cast<String>();
            maiusculas = minusculas.map((str) => str.toUpperCase()).toList();

            for (int i = 0; i < minusculas.length; i++) {
              minors.add({i: minusculas[i]});
            }

            shuffledIndexes..shuffle();
            
            var activityDuration = DateTime.now().difference(
                timeStartActivity); // Mandar essa variável para o back do relatório.            

            isLoaded = true;
          })
        });
  }

  bool checkAnswer() {
    if (maiusculas[majorSelected].toLowerCase() ==
        minusculas[shuffledIndexes[minorSelected]]) {
      toSolve -= 1;
      
      minorSolved[minorSelected] = true;
      majorSolved[majorSelected] = true;
      _playSounds("correct_sound.wav");
      if (toSolve <= 0) {
        isSolved = true;    
      }
      return true;
    } else {
      return false;
    }
  }


  Color getStartColor(int index, String type){
    if (type == "major"){
      if(majorSolved[index]){
        return minorSelectedColor[1];
      }else if( majorSelected == index){
        return defaultMajorColor[1];
      }
    }else if(type == "minor"){
      if(minorSolved[index]){
        return minorSelectedColor[1];
      }else if(minorSelected == index){
        return defaultMajorColor[1];
      }
    }
    return defaultMinorColor[1];
  }

  Color getEndColor(int index, String type){
    if (type == "major"){
      if(majorSolved[index]){
        return minorSelectedColor[2];
      }else if( majorSelected == index){
        return defaultMajorColor[2];
      }
    }else if(type == "minor"){
      if(minorSolved[index]){
        return minorSelectedColor[2];
      }else if(minorSelected == index){
        return defaultMajorColor[2];
      }
    }
    return defaultMinorColor[2];
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
    if (isLoaded && isSolved && !dialogShown) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _playSounds("act_end_sound.wav");
        Future.delayed(const Duration(milliseconds: 500), () {
          // To avoid multiple calls to showDialog, we set a flag
          setState(() {
            dialogShown = true; // Ensure the dialog is only shown once
            var activityDuration = DateTime.now().difference(
                timeStartActivity); // Mandar essa variável para o back do relatório.
          });

          showDialog(
            context: context,
            builder: (BuildContext context) {
              return EndActivityPopup(
                  currentScreen: UpperLower(
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

    TextSpan printedText = TextSpan(children: [
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
    ]);

    return Scaffold(
        body: ActivityBackground(
      child: isLoaded
          ? Stack(children: [
              Column(children: [
                Row(
                  children: [
                    ReturnButton(parentContext: context),
                  ],
                ),
                RichText(
                  text: printedText,
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Spacer(
                      flex: 2,
                    ),
                    CustomButton(
                      label: maiusculas[0],
                      onPressed: () {
                        majorSolved[0] ? null : setState(() {
                          majorSelected = majorSelected != 0 ? 0 : 999;
                          if (!majorSolved[0] &&
                              majorSelected != 999 &&
                              minorSelected != 999) {
                            checkAnswer();
                          }
                          // majorColors = getColor(0, "major");
                          
                        });
                      },
                      hasStroke: true,
                      strokeColor: Colors.black,
                      width: 250,
                      colorStart: getStartColor(0, "major"),
                      colorEnd: getEndColor(0, "major"),
                      letterColor: Colors.black,
                    ),
                    const Spacer(),
                    CustomButton(
                      label: minusculas[shuffledIndexes[0]].toString(),
                      onPressed: () {
                        minorSolved[0] ? null : setState(() {
                          minorSelected = minorSelected != 0 ? 0 : 999;
                          if (!minorSolved[0] &&
                              majorSelected != 999 &&
                              minorSelected != 999) {
                            checkAnswer();
                          }
                          // minorColors = getColor(0, "minor");
                        });
                      },
                      hasStroke: true,
                      strokeColor: Colors.black,
                      width: 250,
                      colorStart: getStartColor(0, "minor"),
                      colorEnd: getEndColor(0, "minor"),
                      letterColor: Colors.black,
                    ),
                    const Spacer(
                      flex: 2,
                    ),
                  ],
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Spacer(
                      flex: 2,
                    ),
                    CustomButton(
                      label: maiusculas[1],
                      onPressed: () {
                        majorSolved[1] ? null :setState(() {
                          majorSelected = majorSelected != 1 ? 1 : 999;
                          if (!majorSolved[1] &&
                              majorSelected != 999 &&
                              minorSelected != 999) {
                            checkAnswer();
                          }
                          // majorColors = getColor(1, "major");
                        });
                      },
                      hasStroke: true,
                      strokeColor: Colors.black,
                      width: 250,
                      colorStart: getStartColor(1, "major"),
                      colorEnd: getEndColor(1, "major"),
                      letterColor: Colors.black,
                    ),
                    const Spacer(),
                    CustomButton(
                      label: minusculas[shuffledIndexes[1]].toString(),
                      onPressed: () {
                        minorSolved[1] ? null : setState(() {
                          minorSelected = minorSelected != 1 ? 1 : 999;
                          if (!minorSolved[1] &&
                              majorSelected != 999 &&
                              minorSelected != 999) {
                            checkAnswer();
                          }
                          // minorColors = getColor(1, "minor");
                        });
                      },
                      hasStroke: true,
                      strokeColor: Colors.black,
                      width: width,
                      colorStart: getStartColor(1, "minor"),
                      colorEnd: getEndColor(1, "minor"),
                      letterColor: Colors.black,
                    ),
                    const Spacer(
                      flex: 2,
                    ),
                  ],
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Spacer(
                      flex: 2,
                    ),
                    CustomButton(
                      label: maiusculas[2],
                      onPressed: () {
                        majorSolved[2] ? null : setState(() {
                          majorSelected = majorSelected != 2 ? 2 : 999;
                          if (!majorSolved[2] &&
                              majorSelected != 999 &&
                              minorSelected != 999) {
                            checkAnswer();
                          }
                          // majorColors = getColor(2, "major");
                        });
                      },
                      hasStroke: true,
                      strokeColor: Colors.black,
                      width: width,
                      colorStart: getStartColor(2, "major"),
                      colorEnd: getEndColor(2, "major"),
                      letterColor: Colors.black,
                    ),
                    const Spacer(),
                    CustomButton(
                      label: minusculas[shuffledIndexes[2]].toString(),
                      onPressed: () {
                        minorSolved[2] ? null : setState(() {
                          minorSelected = minorSelected != 2 ? 2 : 999;
                          if (!minorSolved[2] &&
                              majorSelected != 999 &&
                              minorSelected != 999) {
                            checkAnswer();
                          }
                          // minorColors = getColor(2, "minor");
                        });
                      },
                      hasStroke: true,
                      strokeColor: Colors.black,
                      width: width,
                      colorStart: getStartColor(2, "minor"),
                      colorEnd: getEndColor(2, "minor"),
                      letterColor: Colors.black,
                    ),
                    const Spacer(
                      flex: 2,
                    ),
                  ],
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Spacer(
                      flex: 2,
                    ),
                    CustomButton(
                      label: maiusculas[3],
                      onPressed: () {
                        majorSolved[3] ? null : setState(() {
                          majorSelected = majorSelected != 3 ? 3 : 999;
                          if (!majorSolved[3] &&
                              majorSelected != 999 &&
                              minorSelected != 999) {
                            checkAnswer();
                          }
                          // majorColors = getColor(3, "major");
                        });
                      },
                      hasStroke: true,
                      strokeColor: Colors.black,
                      width: width,
                      colorStart: getStartColor(3, "major"),
                      colorEnd: getEndColor(3, "major"),
                      letterColor: Colors.black,
                    ),
                    const Spacer(),
                    CustomButton(
                      label: minusculas[shuffledIndexes[3]].toString(),
                      onPressed: () {
                        minorSolved[3] ? null : setState(() {
                          minorSelected = minorSelected != 3 ? 3 : 999;
                          if (!minorSolved[3] &&
                              majorSelected != 999 &&
                              minorSelected != 999) {
                            checkAnswer();
                          }
                          // minorColors = getColor(3, "minor");
                        });
                      },
                      hasStroke: true,
                      strokeColor: Colors.black,
                      width: width,
                      colorStart: getStartColor(3, "minor"),
                      colorEnd: getEndColor(3, "minor"),
                      letterColor: Colors.black,
                    ),
                    const Spacer(
                      flex: 2,
                    ),
                  ],
                ),
                const Spacer(),
              ])
            ])
          : const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                  Center(
                    child: CircularProgressIndicator(),
                  )
                ]),
    ));
  }
}
