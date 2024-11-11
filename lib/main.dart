import 'package:demo_app/ui/games/story_games_screen.dart';
import 'package:demo_app/ui/minigames/minigames.dart';
import 'package:demo_app/ui/report/report.dart';
import 'package:demo_app/ui/settings/settings.dart';
import 'package:demo_app/ui/stories/stories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';

const primaryColor = Color(0xFFAAE0F1);
const outlineTitle = 1.0;

const bgWidth = 615.0;
const bgHeight = 396.0;

// Initialize shared preferences

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  // );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    final AudioPlayer audioPlayer = AudioPlayer();

    audioPlayer.setAudioSource(
      AudioSource.asset('assets/audio/main.mp3'),
    ).then((_) {
      audioPlayer.play();
    });

    final screenHeight = MediaQuery.of(context).size.height;
    return MaterialApp(
        theme: ThemeData(scaffoldBackgroundColor: primaryColor),
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
        // "/home": (context) => ,
        "/settings": (context) => const Settings(),
        "/stories": (context) => Stories(),
        "/minigames": (context) => const Minigames(),
        "/play": (context) => const Games()
        },
        home: Builder(
            builder: (context) => Scaffold(
                  // backgroundColor: primaryColor,
                  body: Stack(
                    children: [
                      Positioned.fill(
                        child: SvgPicture.asset(
                          "assets/imgs/background.svg",
                          // Update with your SVG path
                          fit: BoxFit.cover, // Same as the fit you used for PNG
                        ),
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Spacer(flex: 4,),
                            Padding(
                              padding: const EdgeInsets.only(
                                  right: 16.0, top: 40.0),
                              child: Container(
                                  height: 40.0,
                                  width: 40.0,
                                  decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          stops: [
                                            0.5,
                                            0.9,
                                          ],
                                          colors: [
                                            Color(0xff03BFE7),
                                            Color(0xff01419F)
                                          ]),
                                      borderRadius:
                                      BorderRadius.circular(30)),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                            const Settings()),
                                      );
                                    },
                                    style: ButtonStyle(
                                      backgroundColor:
                                      MaterialStateProperty.all<
                                          Color>(Colors.transparent),
                                      shadowColor: MaterialStateProperty
                                          .all<Color>(Colors.transparent),
                                      padding: MaterialStateProperty.all(
                                          EdgeInsets.zero),
                                    ),
                                    child: const Icon(Icons.settings,
                                        color: Colors.white),
                                  )),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                // right: (screenWidth/2) - ((bgWidth/2) * 1.05 ),
                                  right: 0.0,
                                  top: 40.0),
                              child: Container(
                                  height: 40.0,
                                  width: 40.0,
                                  decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          stops: [
                                            0.5,
                                            0.9,
                                          ],
                                          colors: [
                                            Color(0xff03BFE7),
                                            Color(0xff01419F)
                                          ]),
                                      borderRadius:
                                      BorderRadius.circular(30)),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                            const Report()),
                                      );
                                    },
                                    style: ButtonStyle(
                                      backgroundColor:
                                      MaterialStateProperty.all<
                                          Color>(Colors.transparent),
                                      shadowColor: MaterialStateProperty
                                          .all<Color>(Colors.transparent),
                                      padding: MaterialStateProperty.all(
                                          EdgeInsets.zero),
                                    ),
                                    child: const Icon(Icons.leaderboard,
                                        color: Colors.white),
                                  )),
                            ),
                            const Spacer(),
                          ]),
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  // right: (screenWidth/2) - ((bgWidth/2) * 1.05 ),
                                  right: 0.0,
                                  top: 40.0),
                              child: GradientText(
                                'Leiturela',
                                style: const TextStyle(
                                    fontSize: 88.0,
                                    fontFamily: 'Playpen-Sans',
                                    fontWeight: FontWeight.bold,
                                    shadows: [
                                      Shadow(
                                          // bottomLeft
                                          offset: Offset(
                                              -outlineTitle, -outlineTitle),
                                          color: Colors.black),
                                      Shadow(
                                          // bottomRight
                                          offset: Offset(
                                              outlineTitle, -outlineTitle),
                                          color: Colors.black),
                                      Shadow(
                                          // topRight
                                          offset: Offset(
                                              outlineTitle, outlineTitle),
                                          color: Colors.black),
                                      Shadow(
                                          // topLeft
                                          offset: Offset(
                                              -outlineTitle, outlineTitle),
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
                            const SizedBox(height: 16,),
                            Container(
                                height: 80,
                                width: 240,
                                decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        stops: [
                                          0.5,
                                          0.9,
                                        ],
                                        colors: [
                                          Color(0xff03BFE7),
                                          Color(0xff01419F)
                                        ]),
                                    borderRadius: BorderRadius.circular(45)),
                                child: OutlinedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const Games()),
                                      );
                                    },
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.transparent),
                                      shadowColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.transparent),
                                      padding: MaterialStateProperty.all(
                                          EdgeInsets.zero),
                                    ),
                                    child: Center(
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Center(
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    bottom:
                                                        screenHeight * 0.01),
                                                child: const Text(
                                                  'Jogar',
                                                  style: TextStyle(
                                                    fontFamily: 'Playpen-Sans',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 32,
                                                    color: Colors.white,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                            const Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 5.0),
                                              child: Icon(
                                                  Icons.play_circle_fill,
                                                  color: Colors.white,
                                              size: 45,),
                                            ),
                                          ]),
                                    ))),
                            const SizedBox(height: 56,),
                          ],
                        ),
                        // ],
                        // )
                      ),
                    ],
                  ),
                )));
  }
}
