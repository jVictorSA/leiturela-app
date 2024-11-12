import 'package:demo_app/ui/games/activities/custom_widgets/pressable_letters.dart';
import 'package:flutter/material.dart';

import '../../custom_widgets/end_activity_popup.dart';
import '../../custom_widgets/return_button.dart';
import 'custom_widgets/activity_background.dart';
import 'custom_widgets/golden_text_special_case.dart';

class PressLetter extends StatefulWidget {
  int storyId;
  int subStoryId;

  PressLetter({super.key, required this.storyId, required this.subStoryId});

  @override
  _PressLetterState createState() => _PressLetterState();
}

class _PressLetterState extends State<PressLetter> {

  bool dialogShown = false;  // Add a flag to check if the dialog has been shown

  static const String letter = 'B';

  static List<String> wordList = ["Bolo", "Bobagem", "Lista", "Marte"]; // Não ta atualizando certo resolver dps.

  Color defaultColor = Colors.black;
  Color correctColor = const Color(0xFF21D304);
  Color incorrectColor = const Color(0xFFA90C0C);

  // Create the map that associates each word with a list of maps for each letter
  static var result = wordList.map((word) {
    return word.split('').map((char) {
      // Create a map for each letter, where the value is true if it's 'B' or 'b'
      return {
        char: char.toUpperCase() == letter || char.toLowerCase() == letter
      };
    }).toList();
  }).toList();

  static List<String> get questionText => [
        "Escolha a letra ",
        letter,
        " ou ",
        letter.toLowerCase(),
      ];

  int numbersFound = result
      .expand((wordMaps) => wordMaps)  // Flatten the list of lists of maps
      .where((map) => map.values.first)  // Check if the value is true
      .length;  // Get the count of trues

  TextSpan printedText = TextSpan(
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

  void _decrementNumbersFound() {
    setState(() {
      numbersFound -= 1;
    });
  }

  @override
  Widget build(BuildContext context) {

    if (numbersFound <= 0 && !dialogShown) {
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
        child: Stack(children: [
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
                            // Find the map for the first word (wordList[0]) in 'result'
                            // Use result[0] because we want to get the map for the first word
                            // The map in result[0] has each character as the key and a boolean as the value
                            bool isAnswer = result[3].firstWhere(
                                    (map) => map.containsKey(char),
                                orElse: () => {char: false})[char] ??
                                false;
                            if (isAnswer){
                              numbersFound =- 1;
                            }
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
        ]),
      ),
    );
  }
}
