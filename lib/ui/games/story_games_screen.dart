import 'dart:async';

import 'package:demo_app/ui/minigames/minigames.dart';
import 'package:flutter/material.dart';
import 'package:demo_app/ui/stories/stories.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import '../../main.dart';
import '../custom_widgets/return_button.dart';
import '../custom_widgets/selected_frame.dart';

const primaryColor = Color(0xFFAAE0F1);

const marginVal = 30.0;

class Games extends StatefulWidget {
  const Games({super.key});

  @override
  _GamesState createState() => _GamesState();
}

class _GamesState extends State<Games> {
  String userName =
      "Default Name"; // Muda para "" depois de adicionar a integração com o back, para não aparecer caso não tenha login.

  bool _showFirstFrame = true; // Toggle between frames
  late Timer _timer;

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(Duration(milliseconds: 500), (timer) {
      setState(() {
        _showFirstFrame = !_showFirstFrame;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor = primaryColor,
      body: Stack(children: [
        Positioned.fill(
          child: SvgPicture.asset(
            _showFirstFrame ? "assets/imgs/backgrounds/story_games_1.svg" : 'assets/imgs/backgrounds/story_games_2.svg',
            // Update with your SVG path
            fit: BoxFit.cover, // Same as the fit you used for PNG
          ),
        ),
        Column(children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: ReturnButton(parentContext: context),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 120),
                child: GradientText(
                  userName,
                  style: const TextStyle(
                      fontSize: 28,
                      fontFamily: 'Playpen-Sans',
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                            // bottomLeft
                            offset: Offset(-outlineTitle, -outlineTitle),
                            color: Colors.black),
                        Shadow(
                            // bottomRight
                            offset: Offset(outlineTitle, -outlineTitle),
                            color: Colors.black),
                        Shadow(
                            // topRight
                            offset: Offset(outlineTitle, outlineTitle),
                            color: Colors.black),
                        Shadow(
                            // topLeft
                            offset: Offset(-outlineTitle, outlineTitle),
                            color: Colors.black),
                      ]),
                  gradientType: GradientType.linear,
                  gradientDirection: GradientDirection.ttb,
                  radius: 4.4,
                  colors: const [
                    Color(0xff03BFE7),
                    Color(0xff01419F),
                  ],
                ),
              ),
            ],
          ),
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
                      backgroundColor: const Color(0xFFAF80FF),
                    ),
                    const SizedBox(
                      width: 80,
                    ),
                    SelectedFrame(
                      parentContext: context,
                      nextPage: const Minigames(),
                      title: 'Jogos',
                      svgs: 'assets/imgs/game_controller.svg',
                      textSize: 30,
                      backgroundColor: const Color(0xFF74E7FF),
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
