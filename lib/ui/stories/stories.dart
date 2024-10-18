import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../custom_widgets/return_button.dart';
import '../custom_widgets/selected_frame.dart';
import '../games/games.dart';

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
                            svgs: const [
                              'assets/imgs/apartment.svg',
                              'assets/imgs/electric_bolt.svg',
                              'assets/imgs/domino_mask.svg'
                            ],
                          ),
                          SelectedFrame(
                            parentContext: context,
                            nextPage: const Stories(),
                            title: 'Fadas',
                            svgs: const [
                              'assets/imgs/castle.svg',
                              'assets/imgs/crown.svg',
                              'assets/imgs/star.svg',
                            ],
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
                            svgs: const [
                              'assets/imgs/planet.svg',
                              'assets/imgs/rocket.svg',
                              'assets/imgs/alien.svg',
                            ],
                          ),
                          SelectedFrame(
                            parentContext: context,
                            nextPage: const Stories(),
                            title: 'Floresta',
                            svgs: const [
                              'assets/imgs/bird.svg',
                              'assets/imgs/trail.svg',
                              'assets/imgs/tree.svg',
                            ],
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
                            svgs: const [
                              'assets/imgs/balloon.svg',
                              'assets/imgs/cake.svg',
                              'assets/imgs/gift.svg',
                            ],
                          ),
                          SelectedFrame(
                            parentContext: context,
                            nextPage: const Stories(),
                            title: 'Piratas',
                            svgs: const [
                              'assets/imgs/ship.svg',
                              'assets/imgs/map.svg',
                              'assets/imgs/treasure.svg',
                            ],
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
