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
                      nextPage: Stories(),
                      title: 'Histórias',
                      svgs: 'assets/imgs/book.svg',
                      textSize: 30,
                      backgroundColor: Color(0xFFAF80FF),
                    ),
                    SizedBox(width: 80,),
                    SelectedFrame(
                      parentContext: context,
                      nextPage: const Minigames(),
                      title: 'Jogos',
                      svgs: 'assets/imgs/game_controller.svg',
                      textSize: 30,
                      backgroundColor: Color(0xFF74E7FF),
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
