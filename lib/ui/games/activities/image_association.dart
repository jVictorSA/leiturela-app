import 'package:demo_app/ui/games/activities/custom_widgets/golden_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../custom_widgets/end_activity_popup.dart';
import 'custom_widgets/activity_background.dart';
import 'custom_widgets/golden_text_special_case.dart';
import 'custom_widgets/letter.dart';
import 'custom_widgets/letter_space.dart';
import 'custom_widgets/word_box.dart';
import 'custom_widgets/audio_button.dart';
import '../../custom_widgets/return_button.dart';
import 'dart:math';

class ImageAssociation extends StatefulWidget {
  String storyId;
  int subStoryId;

  ImageAssociation(
      {super.key, required this.storyId, required this.subStoryId});

  @override
  _ImageAssociationState createState() => _ImageAssociationState();
}

class _ImageAssociationState extends State<ImageAssociation> {
  List<String> get questionText => [
        "Escolha a imagem que começa com",
        letter,
      ];

  static const String letter = 'B';

  String imageOne = 'assets/imgs/house_atv.svg';
  String imageTwo = 'assets/imgs/balloon_atv.svg';
  String imageThree = 'assets/imgs/cat_atv.svg';
  String imageFour = 'assets/imgs/castle_atv.svg';

  int correctImage = 2;
  bool dialogShown = false;  // Add a flag to check if the dialog has been shown

  Color borderColorOne = Colors.white60;
  Color borderColorTwo = Colors.white60;
  Color borderColorThree = Colors.white60;
  Color borderColorFour = Colors.white60;

  static const Color correctColor = Color(0xFF3AAB28);
  static const Color incorrectColor = Color(0xFFA90C0C);

  bool answerFound = false;

  @override
  Widget build(BuildContext context) {

    if (answerFound && !dialogShown) {
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
                  currentScreen: ImageAssociation(
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
      ],
    );

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
                RichText(
                  text: printedText,
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
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          if (correctImage == 1) {
                            borderColorOne = correctColor;
                            answerFound = true;
                          } else {
                            borderColorOne = incorrectColor;
                          }
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: borderColorOne,
                        // Background color
                        padding: const EdgeInsets.all(12),
                        // Padding around the content
                        shape: RoundedRectangleBorder(
                          // Rounded edges
                          borderRadius: BorderRadius.circular(16),
                          // Adjust as needed
                        ),
                      ),
                      child: SvgPicture.asset(
                        'assets/imgs/house_atv.svg',
                        width: 100,
                        height: 100,
                      ),
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          if (correctImage == 2) {
                            borderColorTwo = correctColor;
                            answerFound = true;
                          } else {
                            borderColorTwo = incorrectColor;
                          }
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: borderColorTwo,
                        // Background color
                        padding: const EdgeInsets.all(12),
                        // Padding around the content
                        shape: RoundedRectangleBorder(
                          // Rounded edges
                          borderRadius: BorderRadius.circular(16),
                          // Adjust as needed
                        ),
                      ),
                      child: SvgPicture.asset(
                        'assets/imgs/balloon_atv.svg',
                        width: 100,
                        height: 100,
                      ),
                    ),
                    const Spacer(
                      flex: 2,
                    ),
                  ],
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(
                      flex: 2,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          if (correctImage == 3) {
                            borderColorThree = correctColor;
                            answerFound = true;
                          } else {
                            borderColorThree = incorrectColor;
                          }
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: borderColorThree,
                        // Background color
                        padding: const EdgeInsets.all(12),
                        // Padding around the content
                        shape: RoundedRectangleBorder(
                          // Rounded edges
                          borderRadius: BorderRadius.circular(16),
                          // Adjust as needed
                        ),
                      ),
                      child: SvgPicture.asset(
                        'assets/imgs/cat_atv.svg',
                        width: 100,
                        height: 100,
                      ),
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          if (correctImage == 4) {
                            borderColorFour = correctColor;
                            answerFound = true;
                          } else {
                            borderColorFour = incorrectColor;
                          }
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: borderColorFour,
                        // Background color
                        padding: const EdgeInsets.all(12),
                        // Padding around the content
                        shape: RoundedRectangleBorder(
                          // Rounded edges
                          borderRadius: BorderRadius.circular(16),
                          // Adjust as needed
                        ),
                      ),
                      child: SvgPicture.asset(
                        'assets/imgs/castle_atv.svg',
                        width: 100,
                        height: 100,
                      ),
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
