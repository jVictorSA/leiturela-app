import 'package:demo_app/ui/minigames/minigames.dart';
import 'package:flutter/material.dart';
import 'package:demo_app/ui/stories/stories.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../custom_widgets/return_button.dart';
import '../custom_widgets/selected_frame.dart';

const primaryColor = Color(0xFFAAE0F1);

const marginVal = 30.0;

class Games extends StatelessWidget {
  const Games({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor = primaryColor,
      body: Stack(children: [
        Positioned.fill(
          child: SvgPicture.asset(
            "assets/imgs/background.svg", // Update with your SVG path
            fit: BoxFit.cover, // Same as the fit you used for PNG
          ),
        ),
        Column(children: [
          Row(children: [ReturnButton(parentContext: context)]),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SelectedFrame(
                      parentContext: context,
                      nextPage: const Stories(),
                      title: 'Histórias',
                      svgs: const [
                      'assets/imgs/apartment.svg',
                      'assets/imgs/electric_bolt.svg',
                      'assets/imgs/domino_mask.svg',
                      ],
                      textSize: 32,
                    ),
                    SelectedFrame(
                      parentContext: context,
                      nextPage: const Minigames(),
                      title: 'Minigames',
                      svgs: const [
                      'assets/imgs/mood.svg',
                      'assets/imgs/letter_block.svg',
                      'assets/imgs/joystick.svg',
                      ],
                      textSize: 32,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ]),
      ]),
    );
  }
}
