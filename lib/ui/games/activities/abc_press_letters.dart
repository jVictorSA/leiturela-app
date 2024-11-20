import 'package:demo_app/ui/games/activities/custom_widgets/pressable_letters.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';
import '../../custom_widgets/custom_button.dart';
import '../../custom_widgets/end_activity_popup.dart';
import '../../custom_widgets/return_button.dart';
import 'custom_widgets/activity_background.dart';
import 'custom_widgets/golden_text_special_case.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import "package:demo_app/services/services.dart";

class ABCPressLetter extends StatefulWidget {
  String storyId;
  int subStoryId;
  String activityId;
  String nextActivityId;

  ABCPressLetter({super.key,
                  required this.storyId,
                  required this.subStoryId,
                  this.activityId = "",
                  this.nextActivityId = ""
                 });

  @override
  _ABCPressLetterState createState() => _ABCPressLetterState();
}

class _ABCPressLetterState extends State<ABCPressLetter> {
  bool dialogShown = false; // Add a flag to check if the dialog has been shown
  bool isLoaded = false;
  bool nextActivityLoaded = false;
  Random random = Random();

  late int letterAnswer;

  List<String> allLetters = [
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'K',
    'L',
    'M',
    'N',
    'O',
    'P',
    'Q',
    'R',
    'S',
    'T',
    'U',
    'V',
    'W',
    'X',
    'Y',
    'Z'
  ];
  List<String> activityLetters = [];
  List<String> chosenLetters = [];
  TextSpan printedText = const TextSpan();

  // Store the current color of each button
  Map<String, List<Color>> buttonColors = {};

  List<Color> defaultColor = [const Color(0xFFFBB631), const Color(0xFFF7FB31)];
  List<Color> correctColor = [const Color(0xFF03A603), const Color(0xFF45FF2D)];
  List<Color> incorrectColor = [const Color(0xFF991C1C), const Color(0xFFFF2F2F)];

  List<String>  questionText = [];
  // List<String> get questionTexts => [
  //         "Escolha as letras ",
  //         chosenLetters[0],
  //         chosenLetters[1],
  //         chosenLetters[2],
  //       ];

  @override
  void initState() {
    super.initState();

    if (widget.storyId != ""){
      fetchNextActivity(widget.storyId, widget.subStoryId).then((response) => {
        setState(() {        
          widget.nextActivityId = response;        
          nextActivityLoaded = true;
        })
      });

    }else{}

    fetchActivity(http.Client(), widget.activityId).then((response) => {
      setState(() {
        String entireObject;        
        entireObject = response;
        Map activity = json.decode(entireObject);

        print("ACTIVIDADY: $activity");

        activityLetters = activity['body']['activity_letters'].cast<String>();
        // print(activityLettersFetch);
        // activityLetters = activityLettersFetch;
        chosenLetters = activity['body']['chosen_letters'].cast<String>();
        print(activityLetters);

        buttonColors = {
          for (var letter in activityLetters) letter: defaultColor,
        };

        letterAnswer = chosenLetters.length;

        questionText.add("Escolha as letras ");
        questionText.add(chosenLetters[0]);
        questionText.add(chosenLetters[1]);
        questionText.add(chosenLetters[2]);
          
          
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
            const WidgetSpan(
              child: SizedBox(width: 8), // Adjust the width for desired spacing
            ),
            TextSpan(
              text: questionText[2],
              style: const TextStyle(
                color: Colors.black,
                fontSize: 30,
                fontFamily: 'Playpen-Sans', // Fixed font family
                fontWeight: FontWeight.bold,
              ), // Style for normal text
            ),
            const WidgetSpan(
              child: SizedBox(width: 8), // Adjust the width for desired spacing
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

        isLoaded = true;
      })
    });

    // _initializeLetters();
  }

  void _initializeLetters() {
    // Choose 6 unique random letters for activityLetters
    activityLetters = (allLetters..shuffle(random)).take(6).toList();

    // From those, pick 3 unique random letters for chosenLetters
    chosenLetters = (activityLetters..shuffle(random)).take(3).toList();

    // Randomly convert some letters to lowercase
    activityLetters = activityLetters.map((letter) {
      return random.nextBool() ? letter.toLowerCase() : letter;
    }).toList();

    // Randomly convert some letters to lowercase
    chosenLetters = chosenLetters.map((letter) {
      return random.nextBool() ? letter.toLowerCase() : letter;
    }).toList();

    // Shuffle activityLetters to randomize their order
    activityLetters.shuffle(random);

    buttonColors = {
      for (var letter in activityLetters) letter: defaultColor,
    };

    letterAnswer = chosenLetters.length;
    isLoaded = true;
  }

  void _handleButtonPress(String letter) {
    setState(() {
      if (chosenLetters.contains(letter.toUpperCase()) || chosenLetters.contains(letter.toLowerCase())) {
        // Correct letter: green gradient
        buttonColors[letter] = [correctColor[0], correctColor[1]];
        letterAnswer -= 1;
      } else {
        // Incorrect letter: red gradient
        buttonColors[letter] = [incorrectColor[0], incorrectColor[1]];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoaded && letterAnswer <= 0 && !dialogShown) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Future.delayed(const Duration(milliseconds: 20), () {
          // To avoid multiple calls to showDialog, we set a flag
          setState(() {
            dialogShown = true;  // Ensure the dialog is only shown once
          });

          showDialog(
            context: context,
            builder: (BuildContext context) {
              return EndActivityPopup(
                  currentScreen: ABCPressLetter(subStoryId: widget.subStoryId, storyId: widget.storyId),
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
                const SizedBox(
                  height: 32,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: activityLetters.take(3).map((letter) {
                          return CustomButton(
                            label: letter,
                            onPressed: () => _handleButtonPress(letter),
                            colorEnd: buttonColors[letter]![0],
                            colorStart: buttonColors[letter]![1],
                            letterColor: Colors.black,
                            hasStroke: true,
                            strokeColor: Colors.black,
                          );
                        }).toList(),
                      ),
                      const Spacer(flex: 2), // Space between rows
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: activityLetters.skip(3).take(3).map((letter) {
                          return CustomButton(
                            label: letter,
                            onPressed: () => _handleButtonPress(letter),
                            colorEnd: buttonColors[letter]![0],
                            colorStart: buttonColors[letter]![1],
                            letterColor: Colors.black,
                            hasStroke: true,
                            strokeColor: Colors.black,
                          );
                        }).toList(),
                      ),
                      const Spacer(),
                    ],
                  ),
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
