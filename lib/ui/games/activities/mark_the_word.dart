import 'package:demo_app/ui/games/activities/custom_widgets/pressable_letters.dart';
import 'package:flutter/material.dart';

import '../../custom_widgets/end_activity_popup.dart';
import '../../custom_widgets/return_button.dart';
import 'custom_widgets/activity_background.dart';
import 'custom_widgets/golden_text_special_case.dart';

class PressSyllable extends StatefulWidget {
  String storyId;
  int subStoryId;
  String syllable;

  // PressSyllable({super.key, required this.storyId, required this.subStoryId, required this.syllable= ""});
  PressSyllable(
      {super.key,
      required this.storyId,
      required this.subStoryId,
      this.syllable = 'Ba'});

  @override
  _PressSyllableState createState() => _PressSyllableState();
}

class _PressSyllableState extends State<PressSyllable> {
  bool dialogShown = false;

  static List<String> wordList = ["Bolo", "Bobagem", "Lista", "Marte"];

  Color defaultColor = Colors.black;
  Color correctColor = const Color(0xFF21D304);
  Color incorrectColor = const Color(0xFFA90C0C);

  int numbersFound = 999;

  // Função que verifica se a palavra contém ou começa com a sílaba/letra
  bool checkSyllable(String word, String syllable) {
    return word.toLowerCase().contains(syllable.toLowerCase());
  }

  // Cria a lista de resultados com base na verificação da sílaba/letra
  var result = wordList.map((word) {
    return {'word': word, 'isCorrect': false, 'isAnswered': false};
  }).toList();

  @override
  void initState() {
    super.initState();
    // Atualiza o estado das palavras com base na sílaba fornecida
    result = wordList.map((word) {
      bool isCorrect = checkSyllable(word, widget.syllable);
      return {'word': word, 'isCorrect': isCorrect, 'isAnswered': false};
    }).toList();

    numbersFound = result
        .where((map) => map['isCorrect'] == true && map['isAnswered'] == false)
        .length;
  }

  @override
  Widget build(BuildContext context) {
    // Conta quantas palavras corretas existem
    numbersFound = result
        .where((map) => map['isCorrect'] == true && map['isAnswered'] == false)
        .length;

    if (numbersFound <= 0 && !dialogShown) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Future.delayed(const Duration(milliseconds: 500), () {
          setState(() {
            dialogShown = true;
          });

          showDialog(
            context: context,
            builder: (BuildContext context) {
              return EndActivityPopup(
                  currentScreen: PressSyllable(
                      subStoryId: widget.subStoryId,
                      storyId: widget.storyId,
                      syllable: widget.syllable),
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
                text: TextSpan(
                  children: [
                    WidgetSpan(
                      child: GoldenTextSpecial(
                        text:
                            "Escolha as palavras que contêm a sílaba '${widget.syllable}'",
                        textSize: 25,
                        borderColor: 0xFF012480,
                        borderWidth: 3,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: result.map((map) {
                    String word = map['word'] as String;
                    bool isCorrect = map['isCorrect'] as bool;
                    bool isAnswered = map['isAnswered'] as bool;

                    return PressableLetters(
                      letterText: word,
                      isAnswer: isCorrect,
                      onTap: () {
                        if (!isAnswered) {
                          setState(() {
                            if (isCorrect) {
                              // Marque como respondida
                              map['isAnswered'] = true;
                              numbersFound -= 1;
                            }

                            // Verifica se todas as palavras corretas foram encontradas
                            if (numbersFound <= 0 && !dialogShown) {
                              dialogShown =
                                  true; // Evite que o diálogo seja mostrado várias vezes
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return EndActivityPopup(
                                      currentScreen: PressSyllable(
                                          subStoryId: widget.subStoryId,
                                          storyId: widget.storyId,
                                          syllable: widget.syllable),
                                      story:
                                          widget.subStoryId != 0 ? true : false,
                                      storyId: widget.storyId,
                                      subStoryId: widget.subStoryId,
                                      ctx: context);
                                },
                                barrierDismissible: false,
                              );
                            }
                          });
                        }
                      },
                    );
                  }).toList(),
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
