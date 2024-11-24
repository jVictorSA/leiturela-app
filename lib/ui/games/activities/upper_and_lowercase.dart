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

  UpperLower({super.key,
              required this.storyId,
              required this.subStoryId,
              this.activityId = "",
              this.nextActivityId = ""
             });
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
  List<int> shuffledIndexes = [0,1,2,3]; 
  int majorSelected = 999;
  int minorSelected = 999;
  List<bool> minorSolved = [false, false, false, false];
  List<bool> majorSolved = [false, false, false, false];
  List<String> get questionText => ["Selecione os pares de palavras maiúsculas e minúsculas"];

  List<Map<int, int>> matches = []; 
  late final DateTime timeStartActivity; // Será utilizado para calcula tempo para o relatório.

  static const List<Color> defaultMinorColor = [Color(0xFFE1E6F1),
                                                Color(0xFF3156FB), 
                                                Color(0xFF3199FB)];

  static const List<Color> minorSelectedColor = [Color(0xFFE1E6F1),
                                                 Color(0xFF31FB4C), 
                                                 Color(0xFF67B867)];

  static const List<Color> defaultMajorColor = [Color(0xFFFFF3B8),
                                                Color(0xFFF7FB31),
                                                Color(0xFFFBB631)];

  static const List<Color> majorSelectedColor = [Color(0xFFE1E6F1),
                                                 Color(0xFFFB8231), 
                                                 Color(0xFFB87E67)];  
  Color boxShadowColor = const Color(0xFF31E3FB);

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

        minusculas = activity['body']['minusculas'].cast<String>();
        maiusculas =  minusculas.map((str) => str.toUpperCase()).toList();
        
        
        for (int i = 0; i < minusculas.length; i++){
          minors.add({i: minusculas[i]});
        }

        shuffledIndexes..shuffle();
        print(shuffledIndexes);
        print(maiusculas[1] + " " + minors[shuffledIndexes[1]].toString());

        print(minors);
        
        
        print(maiusculas);
        print(minusculas);
        var activityDuration = DateTime.now().difference(timeStartActivity); // Mandar essa variável para o back do relatório.
        print(matches);

        isLoaded = true;
      })
    });


  }

  bool checkAnswer(){
    
      print((maiusculas[majorSelected].toLowerCase() + " | " + minusculas[shuffledIndexes[minorSelected]]));
      if (maiusculas[majorSelected].toLowerCase() == minusculas[shuffledIndexes[minorSelected]]){
        toSolve -= 1;
        print("OKKKKKK");
        minorSolved[minorSelected] = true;
        majorSolved[majorSelected] = true;
        _playSounds("correct_sound.wav");
        if (toSolve <= 0){
          isSolved = true;
          print("resolveu");
        }
        return true;
      
    }else{
        _playSounds("wrong_sound.wav");
      return false;
    }
  }

  Color getColor(int index, String type){
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
    if (isLoaded && isSolved && !dialogShown) {
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
        child: isLoaded ? Stack(
          children: [
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
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Spacer(
                      flex: 2,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          majorSelected = majorSelected != 0 ? 0 : 999;
                          print(majorSelected);
                          if (!majorSolved[0] && majorSelected != 999 && minorSelected != 999){
                            checkAnswer();
                          }
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(0),
                        backgroundColor: getColor(0, "major")
                      ),
                      child: StaticLetterBox(text: maiusculas[0],
                                       borderRadius: 1.0,
                                       width: width,
                                      //  boxShadowColor: boxShadowColor
                                       )
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          minorSelected = minorSelected != 0 ? 0 : 999;                        
                          print(minorSelected);
                          if (!minorSolved[0] && majorSelected != 999 && minorSelected != 999){
                            checkAnswer();
                          }
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(0),
                        backgroundColor: getColor(0, "minor")
                        // (minorSelected == 0 || minorSolved[0]) ? defaultMajorColor[1] : defaultMinorColor[1]
                      ),                      
                      child: StaticLetterBox(text: minusculas[shuffledIndexes[0]].toString(),
                                       borderRadius: 1.0,
                                       width: width,
                                      //  colors: const [Color.fromARGB(255, 15, 15, 15), Color.fromARGB(255, 49, 86, 251), Color.fromARGB(255, 49, 153, 251)],
                                      //  boxShadowColor: boxShadowColor
                                      )
     
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
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          majorSelected = majorSelected != 1 ? 1 : 999;
                          print(majorSelected);
                          if (!majorSolved[1] && majorSelected != 999 && minorSelected != 999){
                            checkAnswer();
                          }
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(0),
                        backgroundColor: getColor(1, "major")
                        // (majorSelected == 1 || majorSolved[1]) ? defaultMajorColor[1] : defaultMinorColor[1],
                      ),
                      child: StaticLetterBox(text: maiusculas[1], borderRadius: 1.0, width: width, 
                      // boxShadowColor: boxShadowColor
                      )
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () {        
                        setState(() {
                          minorSelected = minorSelected != 1 ? 1 : 999;
                          print(minorSelected);
                          if (!minorSolved[1] && majorSelected != 999 && minorSelected != 999){
                            checkAnswer();
                          }
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(0),
                        backgroundColor: getColor(1, "minor")
                        // (minorSelected == 1 || minorSolved[1]) ? defaultMajorColor[1] : defaultMinorColor[1]
                      ),
                      child: StaticLetterBox(text: minusculas[shuffledIndexes[1]].toString(),
                                       borderRadius: 1.0,
                                       width: width,
                                      //  colors: const [Color.fromARGB(255, 15, 15, 15), Color.fromARGB(255, 49, 86, 251), Color.fromARGB(255, 49, 153, 251)],
                                      //  boxShadowColor: boxShadowColor
                                      )
     
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
                    ElevatedButton(                    
                      onPressed: () {                  
                        // majorSelected = majorSelected != 2 ? 2 : 999;                        
                        setState(() {
                          majorSelected = majorSelected != 2 ? 2 : 999;                        
                          print(majorSelected);
                          if (!majorSolved[2] && majorSelected != 999 && minorSelected != 999){
                            checkAnswer();
                          }
                        });      
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(0),
                        backgroundColor: getColor(2, "major")
                        // (majorSelected == 2 || majorSolved[2]) ? defaultMajorColor[1] : defaultMinorColor[1],
                      ),
                      child: StaticLetterBox(text: maiusculas[2], borderRadius: 1.0, width: width, 
                      // boxShadowColor: boxShadowColor
                      )
                    ),
                    const Spacer(),
                    // {return ElevatedButton(onPressed: onPressed, child: child)},
                    ElevatedButton(
                      style: 
                      ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(0),
                        // primary:minorSelected == 2 ? defaultMinorColor[1] : minorSelectedColor[1],
                        backgroundColor: getColor(2, "minor")
                        // (minorSelected == 2 || minorSolved[2]) ? defaultMajorColor[1] : defaultMinorColor[1]
                      ),
                      onPressed: () {
                        setState(() {
                          minorSelected = minorSelected != 2 ? 2 : 999;                          
                          print(minorSelected);
                          if (!minorSolved[2] && majorSelected != 999 && minorSelected != 999){
                            checkAnswer();
                          }
                        });                        
                      },
                      child: 
                      // (minorSelected == 2) ? Text(minusculas[shuffledIndexes[2]].toString()) : Text("99999999")
                      StaticLetterBox(text: minusculas[shuffledIndexes[2]].toString(),
                                       borderRadius: 1.0,
                                       width: width,
                                      //  colors: minorSelected == 2 ? minorSelectedColor : defaultMinorColor,
                                      //  boxShadowColor: boxShadowColor 
                                      )
     
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
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          majorSelected = majorSelected != 3 ? 3 : 999;
                          print(majorSelected);
                          if (!majorSolved[3] && majorSelected != 999 && minorSelected != 999){
                            checkAnswer();
                          }
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(0),
                        backgroundColor: getColor(3, "major")
                        // (majorSelected == 3 || majorSolved[3]) ? defaultMajorColor[1] : defaultMinorColor[1],
                      ),
                      child: StaticLetterBox(text: maiusculas[3], borderRadius: 1.0, width: width, 
                      // boxShadowColor: boxShadowColor
                      )
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          minorSelected = minorSelected != 3 ? 3 : 999;                        
                          print(minorSelected);
                          if (!minorSolved[3] && majorSelected != 999 && minorSelected != 999){
                            checkAnswer();
                          }
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(0),
                        backgroundColor: getColor(3, "minor")
                        // (minorSelected == 3 || minorSolved[3]) ? defaultMajorColor[1] : defaultMinorColor[1]
                      ),
                      child: StaticLetterBox(text: minusculas[shuffledIndexes[3]].toString(),
                                       borderRadius: 1.0,
                                       width: width,
                                      //  colors: const [Color.fromARGB(255, 15, 15, 15), Color.fromARGB(255, 49, 86, 251), Color.fromARGB(255, 49, 153, 251)],
                                      //  boxShadowColor: boxShadowColor
                                      )
     
                    ),
                    const Spacer(
                      flex: 2,
                    ),
                  ],
                ),
                const Spacer(),
              ]
            )
          ]
        )
        : const Column(mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [Center(child: CircularProgressIndicator(),)]
                ),
      )
    );
  }
}