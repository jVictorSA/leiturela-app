import 'package:audioplayers/audioplayers.dart';
import 'package:demo_app/ui/games/activities/custom_widgets/audio_button.dart';
import 'package:demo_app/ui/games/activities/custom_widgets/pressable_letters.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';
import '../../custom_widgets/custom_button.dart';
import '../../custom_widgets/end_activity_popup.dart';
import '../../custom_widgets/return_button.dart';
import 'custom_widgets/activity_background.dart';
import 'custom_widgets/golden_text_special_case.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import "package:demo_app/services/services.dart";

class SoundLettersAssociation extends StatefulWidget {
  String storyId;
  int subStoryId;
  String activityId;
  String nextActivityId;

  SoundLettersAssociation(
      {super.key,
      required this.storyId,
      required this.subStoryId,
      this.activityId = "",
      this.nextActivityId = ""});

  @override
  _SoundLettersAssociationState createState() =>
      _SoundLettersAssociationState();
}

class _SoundLettersAssociationState extends State<SoundLettersAssociation> {
  bool dialogShown = false; // Add a flag to check if the dialog has been shown
  bool nextActivityLoaded = false;
  bool isLoaded = false;

  Random random = Random();

  late final DateTime
      timeStartActivity; // Será utilizado para calcula tempo para o relatório.

  late int letterAnswer;

  List<String> allLetters = [
    'a.mp3',
    'b.mp3',
    'c.mp3',
    'd.mp3',
    'e.mp3',
    'f.mp3',
    'g.mp3',
    'h.mp3',
    'i.mp3',
    'j.mp3',
    'k.mp3',
    'l.mp3',
    'm.mp3',
    'n.mp3',
    'o.mp3',
    'p.mp3',
    'q.mp3',
    'r.mp3',
    's.mp3',
    't.mp3',
    'y.mp3',
    'v.mp3',
    'w.mp3',
    'x.mp3',
    'y.mp3',
    'z.mp3'
  ];
  List<String> activityLetters = [];
  List<String> audioChosenLetters = [];
  List<String> chosenLetters = [];

  // Store the current color of each button
  Map<String, List<Color>> buttonColors = {};

  List<Color> defaultColor = [const Color(0xFFFBB631), const Color(0xFFF7FB31)];
  List<Color> correctColor = [const Color(0xFF03A603), const Color(0xFF45FF2D)];
  List<Color> incorrectColor = [
    const Color(0xFF991C1C),
    const Color(0xFFFF2F2F)
  ];

  List<String> get questionText =>
      ["Ouça o áudio e escolha as letras que você ouviu."];

  @override
  void initState() {
    super.initState();

    if (widget.storyId != "") {
      fetchNextActivity(widget.storyId, widget.subStoryId).then((response) => {
            setState(() {
              widget.nextActivityId = response;
              nextActivityLoaded = true;
              var activityDuration = DateTime.now().difference(
                  timeStartActivity); // Mandar essa variável para o back do relatório.

              nextActivityLoaded = true;
            })
          });
    } else {}

    fetchActivity(http.Client(), widget.activityId).then((response) => {
          setState(() {
            String entireObject;
            entireObject = response;
            Map activity = json.decode(entireObject);

            print(activity);

            activityLetters =
                activity["body"]["activity_letters"].cast<String>();
            chosenLetters = activity["body"]["chosen_letters"].cast<String>();
            _initializeLetters();

            isLoaded = true;
          })
        });

    timeStartActivity = DateTime.now();
  }

  void _initializeLetters() {
    // Randomly convert some letters to lowercase
    activityLetters = activityLetters.map((letter) {
      return random.nextBool() ? letter.toLowerCase() : letter;
    }).toList();

    // Randomly convert some letters to lowercase
    audioChosenLetters = chosenLetters.map((letter) {
      return random.nextBool() ? letter.toLowerCase() : letter;
    }).toList();

    chosenLetters =
        audioChosenLetters.map((str) => str.replaceAll('.mp3', '')).toList();

    // Shuffle activityLetters to randomize their order
    activityLetters.shuffle(random);

    activityLetters =
        activityLetters.map((str) => str.replaceAll('.mp3', '')).toList();

    activityLetters = activityLetters.map((letter) {
      return random.nextBool() ? letter.toUpperCase() : letter;
    }).toList();

    buttonColors = {
      for (var letter in activityLetters) letter: defaultColor,
    };

    letterAnswer = chosenLetters.length;
  }

  void _handleButtonPress(String letter) {
    if (buttonColors[letter]?[0] != correctColor[0]) {
      setState(() {
        if (chosenLetters.contains(letter.toUpperCase()) ||
            chosenLetters.contains(letter.toLowerCase())) {
          _playSounds("correct_sound.wav");
          // Correct letter: green gradient
          buttonColors[letter] = [correctColor[0], correctColor[1]];
          letterAnswer -= 1;
        } else {
          _playSounds("wrong_sound.wav");
          // Incorrect letter: red gradient
          buttonColors[letter] = [incorrectColor[0], incorrectColor[1]];
        }
      });
    }
  }

  void _playSounds(String sound) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    int? volumePref = _prefs.getInt('efeitos');
    double volume = (volumePref ?? 5).toDouble() / 10; // Default to 5 if null

    final AudioPlayer soundPlayer = AudioPlayer();

    try {
      await soundPlayer.setVolume(volume);
      await soundPlayer
          .play(AssetSource('audio/sound_effects/$sound')); // Play each sound
      await soundPlayer
          .onPlayerComplete.first; // Wait until the current sound finishes
    } finally {
      soundPlayer.dispose(); // Dispose of the player after sound finishes
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoaded && letterAnswer <= 0 && !dialogShown) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _playSounds("act_end_sound.wav");
        Future.delayed(const Duration(milliseconds: 500), () {
          // To avoid multiple calls to showDialog, we set a flag
          setState(() {
            dialogShown = true; // Ensure the dialog is only shown once
            var activityDuration = DateTime.now().difference(
                timeStartActivity); // Mandar essa variável para o back do relatório.
          });

          showDialog(
            context: context,
            builder: (BuildContext context) {
              return EndActivityPopup(
                  currentScreen: SoundLettersAssociation(
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

    TextSpan printedText = TextSpan(children: [
      WidgetSpan(
        child: GoldenTextSpecial(
          text: questionText[0],
          textSize: 25,
          // Adjust as needed
          borderColor: 0xFF012480,
          // Adjust as needed
          borderWidth: 3,
          fontWeight: FontWeight.w500,
        ),
      ),
    ]);

    return Scaffold(
      body: ActivityBackground(
        child: isLoaded
            ? Stack(
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
                      AudioButton(
                        soundFiles: audioChosenLetters
                            .map((file) => 'letter_sounds/$file.mp3')
                            .toList(),
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Spacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: activityLetters.take(3).map((letter) {
                                return CustomButton(
                                  label: letter,
                                  onPressed: () => _handleButtonPress(letter),
                                  colorEnd: buttonColors[letter]![0],
                                  colorStart: buttonColors[letter]![1],
                                  letterColor: Colors.black,
                                  hasStroke: true,
                                  strokeColor: Colors.black,
                                );
                              }).toList(),
                            ),
                            const Spacer(flex: 2), // Space between rows
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children:
                                  activityLetters.skip(3).take(3).map((letter) {
                                return CustomButton(
                                  label: letter,
                                  onPressed: () => _handleButtonPress(letter),
                                  colorEnd: buttonColors[letter]![0],
                                  colorStart: buttonColors[letter]![1],
                                  letterColor: Colors.black,
                                  hasStroke: true,
                                  strokeColor: Colors.black,
                                );
                              }).toList(),
                            ),
                            const Spacer(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              )
            : const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                    Center(
                      child: CircularProgressIndicator(),
                    )
                  ]),
      ),
    );
  }
}
