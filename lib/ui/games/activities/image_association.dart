import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../custom_widgets/end_activity_popup.dart';
import 'custom_widgets/activity_background.dart';
import 'custom_widgets/golden_text_special_case.dart';
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
  Random random = Random();

  List<String> get questionText => [
        "Escolha a imagem que começa com",
        letter,
      ];

  late String letter;

  List<String> atvImages = [
    'assets/imgs/atv_imgs/balao.svg',
    'assets/imgs/atv_imgs/bolo.svg',
    'assets/imgs/atv_imgs/brasil.svg',
    'assets/imgs/atv_imgs/cachorro.svg',
    'assets/imgs/atv_imgs/carro.svg',
    'assets/imgs/atv_imgs/casa.svg',
    'assets/imgs/atv_imgs/castelo.svg',
    'assets/imgs/atv_imgs/dado.svg',
    'assets/imgs/atv_imgs/dinheiro.svg',
    'assets/imgs/atv_imgs/flor.svg',
    'assets/imgs/atv_imgs/formiga.svg',
    'assets/imgs/atv_imgs/galinha.svg',
    'assets/imgs/atv_imgs/gato.svg',
    'assets/imgs/atv_imgs/laranja.svg',
    'assets/imgs/atv_imgs/lua.svg',
    'assets/imgs/atv_imgs/passaro.svg',
    'assets/imgs/atv_imgs/peixe.svg',
    'assets/imgs/atv_imgs/porta.svg',
    'assets/imgs/atv_imgs/praia.svg',
    'assets/imgs/atv_imgs/pao.svg',
    'assets/imgs/atv_imgs/queijo.svg',
    'assets/imgs/atv_imgs/vaca.svg',
    'assets/imgs/atv_imgs/arvore.svg'
  ];

  bool dialogShown = false; // Add a flag to check if the dialog has been shown

  late List<String> usedImages;

  late List<String> cleanImagesString;

  List<bool> clicked = [false,false,false,false];

  Color borderColorOne = Colors.white60;
  Color borderColorTwo = Colors.white60;
  Color borderColorThree = Colors.white60;
  Color borderColorFour = Colors.white60;

  static const Color correctColor = Color(0xFF3AAB28);
  static const Color incorrectColor = Color(0xFFA90C0C);

  int numAnswer = 999;

  @override
  void initState() {
    super.initState();
    _initializeImages();
  }

  _initializeImages() {
    usedImages = (atvImages..shuffle(random)).take(4).toList();

    cleanImagesString = usedImages
        .map((str) => str.replaceAll('assets/imgs/atv_imgs/', ''))
        .toList();

    letter = cleanImagesString[random.nextInt(cleanImagesString.length)][0];

    numAnswer = cleanImagesString.where((word) => word.startsWith(letter)).length;
  }

  @override
  Widget build(BuildContext context) {
    if (numAnswer <= 0 && !dialogShown) {
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
                  ctx: context);
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
                        clicked[0] == false ? setState(() {
                          if (cleanImagesString[0][0] == letter) {
                            borderColorOne = correctColor;
                            numAnswer -= 1;
                            clicked[0] == true;
                          } else {
                            borderColorOne = incorrectColor;
                          }
                        }) : null;
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
                      child: Container(
                        width: 105,
                        height: 105,
                        child: SvgPicture.asset(
                          usedImages[0],
                          width: 100,
                          height: 100,
                        ),
                      ),
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        clicked[1] == false ? setState(() {
                          if (cleanImagesString[1][0] == letter) {
                            borderColorTwo = correctColor;
                            numAnswer -= 1;
                            clicked[1] = true;
                          } else {
                            borderColorTwo = incorrectColor;
                          }
                        }) : null;
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
                      child: Container(
                        width: 105,
                        height: 105,
                        child: SvgPicture.asset(
                          usedImages[1],
                          width: 100,
                          height: 100,
                        ),
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
                        clicked[2] == false ? setState(() {
                           if (cleanImagesString[2][0] == letter) {
                            borderColorThree = correctColor;
                            numAnswer -= 1;
                            clicked[2] = true;
                          } else {
                            borderColorThree = incorrectColor;
                          }
                        }) : null;
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
                      child: Container(
                        width: 105,
                        height: 105,
                        child: SvgPicture.asset(
                          usedImages[2],
                          width: 100,
                          height: 100,
                        ),
                      ),
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        clicked[3] == false ? setState(() {
                          if (cleanImagesString[3][0] == letter) {
                            borderColorFour = correctColor;
                            numAnswer -= 1;
                            clicked[3] = true;
                          } else {
                            borderColorFour = incorrectColor;
                          }
                        }) : null;
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
                      child: Container(
                        width: 105,
                        height: 105,
                        child: SvgPicture.asset(
                          usedImages[3],
                          width: 100,
                          height: 100,
                        ),
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
