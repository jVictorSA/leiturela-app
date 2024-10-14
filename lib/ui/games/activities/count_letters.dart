import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import '../../custom_widgets/return_button.dart';
import 'dart:math';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const CountLetters(),
    );
  }
}

class CountLetters extends StatefulWidget {
  const CountLetters({super.key});

  @override
  _CountLettersState createState() => _CountLettersState();
}

class _CountLettersState extends State<CountLetters> {
  TextEditingController controller = TextEditingController();

  static const textSize = 25.0;
  static const int textColor = 0xFF03BFE7;
  static const int borderColor = 0xFF012480;

  static const String questionText = "Conte quantos 'n' tem no seguinte texto";

  int letterCount = 13;

  bool solvedActivity = false;

  void checkAnswer() {
    String userAnswer = controller.text;

    if (userAnswer.isEmpty) {
      print('Please enter an answer');
    } else {
      // Tenta converter a entrada do usuário para um inteiro
      int? answerAsInt = int.tryParse(userAnswer);

      if (answerAsInt == null) {
        print('Please enter a valid number');
      } else if (answerAsInt == letterCount) {
        setState(() {
          solvedActivity = true; // Atualiza o estado para verdadeiro
        });
      } else {
        print('Incorrect answer');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: SvgPicture.asset(
              "assets/imgs/background.svg", // Update with your SVG path
              fit: BoxFit.cover, // Same as the fit you used for PNG
            ),
          ),
          Column(
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
                    const Stack(
                      children: [
                        // This is the stroke text
                        Text(
                          questionText,
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            fontSize: textSize,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Playpen-Sans',
                            color: Color(borderColor),
                            // Stroke color
                            shadows: [
                              Shadow(
                                color: Color(borderColor), // Stroke color
                                offset: Offset(1.0, 1.0), // Stroke offset
                                blurRadius: 0,
                              ),
                              Shadow(
                                color: Color(borderColor), // Stroke color
                                offset: Offset(-1.0, -1.0), // Stroke offset
                                blurRadius: 0,
                              ),
                              Shadow(
                                color: Color(borderColor), // Stroke color
                                offset: Offset(1.0, -1.0), // Stroke offset
                                blurRadius: 0,
                              ),
                              Shadow(
                                color: Color(borderColor), // Stroke color
                                offset: Offset(-1.0, 1.0), // Stroke offset
                                blurRadius: 0,
                              ),
                            ],
                          ),
                        ),
                        // This is the main text
                        Text(
                          questionText,
                          style: TextStyle(
                              fontSize: textSize,
                              fontFamily: 'Playpen-Sans',
                              fontWeight: FontWeight.w500,
                              color: Color(textColor)),
                          textAlign: TextAlign.justify,
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 500, // Defina a largura desejada
                      child: ColorfulText(
                        'Nina nadou na piscina enquanto o amigo cantava uma canção calma.',
                        fontSize: 24.0,
                        specialLetter: 'n',
                        solved: solvedActivity,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextField(
                          controller: controller,
                          decoration: const InputDecoration(
                            constraints: BoxConstraints(
                              maxHeight: 150,
                              maxWidth: 150,
                              minHeight: 10,
                              minWidth: 10,
                            ),
                            labelText: 'Número de Letras',
                          ),
                          keyboardType: TextInputType.number,
                          // Altera o teclado para numérico
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly,
                            // Permite apenas dígitos
                          ],
                        ),
                        const SizedBox(
                          width: 36,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            checkAnswer(); // Handle answer checking when the button is pressed
                          },
                          child: const Text('Submit'),
                        ),
                      ],
                    ),
                    SizedBox(),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
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
                  ? Color(0xFF3AAB28)
                  : Colors.black // Special letter color
              : Colors.black, // Default color
          fontSize: fontSize,
          fontFamily: 'Playpen-Sans', // Fixed font family
          fontWeight: FontWeight.w500,
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
