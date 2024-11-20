import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../custom_widgets/custom_button.dart';
import '../../custom_widgets/end_activity_popup.dart';
import '../../custom_widgets/return_button.dart';
import 'custom_widgets/activity_background.dart';
import 'custom_widgets/golden_text_special_case.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import "package:demo_app/services/services.dart";

class CountLetters extends StatefulWidget {
  String storyId;
  int subStoryId;
  int answer;
  String letter;
  String text;
  String activityId;
  // String nextActivityId;

  CountLetters({super.key,
                required this.subStoryId,
                required this.storyId,
                this.activityId = "ERRADO",
                this.answer = 9,
                this.letter = "E",
                this.text = "ERRADO"
              });


  @override
  _CountLettersState createState() => _CountLettersState();
}

class _CountLettersState extends State<CountLetters> {
  TextEditingController controller = TextEditingController();

  String nextActivityId = "";
  bool dialogShown = false; // Add a flag to check if the dialog has been shown
  bool isAnswerIncorrect = false;

  List<String> get questionText => [
        "Conte quantos ",
        widget.letter,
        " ou ",
        widget.letter.toUpperCase(),
        " têm no seguinte texto."
      ];

  bool solvedActivity = false;

  @override
  void initState() {
    super.initState();

    if (widget.storyId != ""){
      fetchNextActivity(widget.storyId, widget.subStoryId).then((response) => {
        setState(() {        
          nextActivityId = response;        
          
        })
      });

    }else{}

    // fetchNextActivity(widget.storyId, widget.subStoryId).then((response) => {
    //   setState(() {        
    //     nextActivityId = response;
    //   })
    // });

    fetchActivity(http.Client(), widget.activityId).then((response) => {
      setState(() {
        String entireObject;
        entireObject = response;        
        Map activity = json.decode(entireObject);
        print("fetch activity id: " + widget.activityId);
        print("atividade:\n" + activity.toString());

        widget.answer = activity["answer"]["num"];
        widget.letter = activity["body"]["letra"];
        widget.text = activity["body"]["frase"];        
      })
    });    
  }

  void checkAnswer() {
    print("nextActivityId: $nextActivityId");
    String userAnswer = controller.text;

    if (userAnswer.isEmpty) {
      print('Please enter an answer');
    } else {
      int? answerAsInt = int.tryParse(userAnswer);

      if (answerAsInt == null) {
        print('Please enter a valid number');
      } else if (answerAsInt == widget.answer) {
        setState(() {
          solvedActivity = true;
          isAnswerIncorrect = false;
          dialogShown = true;  // Ensure the dialog is only shown once
        });
        Future.delayed(const Duration(milliseconds: 50), () {
          // Replace with your navigation logic          
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return EndActivityPopup(
                currentScreen: CountLetters(subStoryId: widget.subStoryId,
                                             storyId: widget.storyId
                                           ),
                story: widget.subStoryId != 0 ? true : false,
                storyId: widget.storyId,
                subStoryId: widget.subStoryId,
                nextActivityId: nextActivityId,
                ctx: context,
              ); // Call your custom popup
            },
            barrierDismissible: false,
          );
        });
      } else {
        setState(() {
          isAnswerIncorrect = true; // Answer is incorrect, flash red
        });
        Future.delayed(const Duration(milliseconds: 50), () {
          setState(() {
            isAnswerIncorrect = false; // Reset red flash
          });
        });
      }
    }
  }

  int countLetter(String text, String letter) {
    return text
        .toLowerCase()
        .split('')
        .where((char) => char == letter.toLowerCase())
        .length;
  }

  @override
  Widget build(BuildContext context) {
    TextSpan printedText = TextSpan(
      children: [
        WidgetSpan(
          child: GoldenTextSpecial(
            text: questionText[0],
            textSize: 20,
            // Adjust as needed
            borderColor: 0xFF012480,
            // Adjust as needed
            borderWidth: 3,
            fontWeight: FontWeight.w500,
          ),
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
            textSize: 20,
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
        WidgetSpan(
          child: GoldenTextSpecial(
            text: questionText[4],
            textSize: 20,
            // Adjust as needed
            borderColor: 0xFF012480,
            // Adjust as needed
            borderWidth: 3,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );

    return Scaffold(
      body: ActivityBackground(
          child: Column(
        children: [
          Row(
            children: [
              ReturnButton(parentContext: context),
            ],
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RichText(
                  text: printedText,
                ),
                SizedBox(
                  width: 500,
                  child: ColorfulText(
                    widget.text,
                    fontSize: 24.0,
                    specialLetter: widget.letter,
                    solved: solvedActivity,
                  ),
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            height: 56.0,
                            width: 120.0,
                            decoration: BoxDecoration(
                              color: const Color(0xFFD1E9F6),
                              border: Border.all(
                                  color: isAnswerIncorrect
                                      ? const Color(0xFFA90C0C)
                                      : solvedActivity
                                          ? const Color(0xFF3AAB28)
                                          : const Color(0xFF03BFE7)),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: TextField(
                              controller: controller,
                              textAlign: TextAlign.center,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 16.0),
                              ),
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                            )),
                        const SizedBox(
                          width: 36,
                        ),
                        CustomButton(
                          label: 'Enviar',
                          onPressed: () {
                            checkAnswer();
                          },
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          solvedActivity
                              ? 'Resposta Correta!'
                              : isAnswerIncorrect
                                  ? 'Resposta Incorreta'
                                  : '',
                          style: TextStyle(
                            color: solvedActivity
                                ? const Color(0xFF3AAB28)
                                : const Color(0xFFA90C0C),
                            // You can customize the color or other styles as needed
                            fontFamily: 'Playpen-Sans',
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          width: 156.0,
                        )
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      )),
    );
  }
}

class ColorfulText extends StatelessWidget {
  final String text;
  final double fontSize;
  final String specialLetter;
  final bool solved;

  ColorfulText(this.text,
      {required this.fontSize,
      required this.specialLetter,
      required this.solved});

  List<TextSpan> _generateTextSpans(String text) {
    return text.split('').map((letter) {
      return TextSpan(
        text: letter,
        style: TextStyle(
          color: letter.toLowerCase() == specialLetter.toLowerCase()
              ? solved
                  ? const Color(0xFF3AAB28)
                  : Colors.black
              : Colors.black, // Default color
          fontSize: fontSize,
          fontFamily: 'Playpen-Sans', // Fixed font family
          fontWeight: FontWeight.bold,
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: _generateTextSpans(text),
      ),
      textAlign: TextAlign.center,
    );
  }
}
