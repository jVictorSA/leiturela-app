import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../main.dart';
import '../custom_widgets/return_button.dart';
import '../custom_widgets/selected_frame.dart';
import '../games/activities/count_letters.dart';
import '../games/activities/drag_crossword.dart';

class Minigames extends StatelessWidget {
  const Minigames({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Positioned.fill(
              child: SvgPicture.asset(
                "assets/imgs/background.svg", // Update with your SVG path
                fit: BoxFit.cover, // Same as the fit you used for PNG
              ),
            ),
            Column(
              children: [
                Row(children: [ReturnButton(parentContext: context)]),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SelectedFrame(
                            parentContext: context,
                            nextPage: const DragSyllables(),
                            title: 'Montar Palavra',
                            svgs: const [
                              'assets/imgs/drag_and_drop.svg',
                              'assets/imgs/build.svg',
                              'assets/imgs/me.svg'
                            ],
                          ),
                          SelectedFrame(
                            parentContext: context,
                            nextPage: const CountLetters(),
                            title: 'Contar Letras',
                            svgs: const [
                              'assets/imgs/calculator.svg',
                              'assets/imgs/a_capitalized.svg',
                              'assets/imgs/three_hand.svg'
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SelectedFrame(
                            parentContext: context,
                            nextPage: const MyApp(),
                            title: 'ATV 3',
                            svgs: const [
                              'assets/imgs/abc.svg',
                              'assets/imgs/abc.svg',
                              'assets/imgs/abc.svg'
                            ],
                          ),
                          SelectedFrame(
                            parentContext: context,
                            nextPage: const MyApp(),
                            title: 'ATV 4',
                            svgs: const [
                              'assets/imgs/abc.svg',
                              'assets/imgs/abc.svg',
                              'assets/imgs/abc.svg'
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SelectedFrame(
                            parentContext: context,
                            nextPage: const MyApp(),
                            title: 'ATV 5',
                            svgs: const [
                              'assets/imgs/abc.svg',
                              'assets/imgs/abc.svg',
                              'assets/imgs/abc.svg'
                            ],
                          ),
                          SelectedFrame(
                            parentContext: context,
                            nextPage: const MyApp(),
                            title: 'ATV 6',
                            svgs: const [
                              'assets/imgs/abc.svg',
                              'assets/imgs/abc.svg',
                              'assets/imgs/abc.svg'
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
