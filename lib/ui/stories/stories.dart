import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../custom_widgets/return_button.dart';
import '../custom_widgets/selected_frame.dart';
import '../games/story_games_screen.dart';

class Stories extends StatelessWidget {
  const Stories({super.key});

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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SelectedFrame(
                            parentContext: context,
                            nextPage: const Stories(),
                            title: 'Heróis',
                            svgs: 'assets/imgs/domino_mask.svg',
                            backgroundColor: Colors.redAccent,
                            textSize: 24,
                          ),
                          SelectedFrame(
                            parentContext: context,
                            nextPage: const Stories(),
                            title: 'Fadas',
                            svgs: 'assets/imgs/crown.svg',
                            backgroundColor: Colors.pinkAccent,
                            textSize: 24,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SelectedFrame(
                            parentContext: context,
                            nextPage: const Stories(),
                            title: 'Espaço',
                            svgs: 'assets/imgs/planet.svg',
                            backgroundColor: Colors.deepPurpleAccent,
                            textSize: 24,
                          ),
                          SelectedFrame(
                            parentContext: context,
                            nextPage: const Stories(),
                            title: 'Floresta',
                            svgs: 'assets/imgs/tree.svg',
                            backgroundColor: Colors.green,
                            textSize: 24,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SelectedFrame(
                            parentContext: context,
                            nextPage: const Stories(),
                            title: 'Aniversário',
                            svgs: 'assets/imgs/gift.svg',
                            backgroundColor: Colors.blueAccent,
                            textSize: 24,
                          ),
                          SelectedFrame(
                            parentContext: context,
                            nextPage: const Stories(),
                            title: 'Piratas',
                            svgs: 'assets/imgs/ship.svg',
                            backgroundColor: Colors.blueGrey,
                            textSize: 24,
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
