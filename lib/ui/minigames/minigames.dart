import 'package:demo_app/ui/games/activities/complete_word.dart';
import 'package:demo_app/ui/games/activities/image_association.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../custom_widgets/return_button.dart';
import '../custom_widgets/selected_frame.dart';
import '../games/activities/build_letter.dart';
import '../games/activities/count_letters.dart';
import '../games/activities/count_letters_by_sound.dart';
import '../games/activities/drag_crossword.dart';
import '../games/activities/press_letter.dart';
import '../games/activities/abc_press_letters.dart';
import '../games/activities/select_word_by_audio.dart';
import '../games/activities/mark_the_word.dart';
import '../games/activities/sound_letters_association.dart';
import '../games/activities/upper_and_lowercase_update.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import "package:demo_app/services/services.dart";
import 'dart:math';

class Minigames extends StatefulWidget {
  const Minigames({super.key});

  @override
  _MinigamesState createState() => _MinigamesState();

}

class _MinigamesState extends State<Minigames> {
  Map<String, List<String>> minigames = {};
  bool isLoaded = false;


  @override
  void initState() {
    super.initState();

    fetchActivities(http.Client()).then((response) => {
      setState(() {        
        String entireObject;
        entireObject = response;        
        List activities = json.decode(entireObject);
        
        print(activities);

        for (var activity in activities){
          Map<String, String> activityInfo = {};          

          // activityInfo["id"] = 
          // activityInfo["type"] = 
          String? type = activity["type"];
          String? id = activity["_id"];
          
          if(id != null && type != null){
            if(!minigames.containsKey(type)){
              minigames[type] = [];
            }
            minigames[type]?.add(id);            
          }
        }
        print(minigames.keys.toList());

        isLoaded = true;
      })
    });
  }

  String getRandomActivity(String type){
    String activityID = minigames[type]![Random().nextInt(minigames[type]!.length)];
    return activityID;
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoaded ?SingleChildScrollView(
        child: Stack(
          children: [
            Positioned.fill(
              child: SvgPicture.asset(
                "assets/imgs/backgrounds/background.svg", // Update with your SVG path
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
                            nextPage: DragSyllables(storyId: "", subStoryId: 0, activityId: getRandomActivity("drag_crossword")),
                            title: 'Arrastar Sílaba',
                            svgs: 'assets/imgs/atv_button_svg/drag.svg',
                            backgroundColor: Colors.lightBlueAccent,
                            textSize: 20,
                          ),
                          SelectedFrame(
                            parentContext: context,
                            nextPage: CountLetters(storyId: "", subStoryId: 0, activityId: getRandomActivity("count_letters")),
                            title: 'Contar Letras',
                            svgs: 'assets/imgs/atv_button_svg/hand_two.svg',
                            backgroundColor: Colors.redAccent,
                            textSize: 20,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SelectedFrame(
                            parentContext: context,
                            nextPage: BuildWord(storyId: "", subStoryId: 0, activityId: getRandomActivity("build_letter")),
                            title: 'Montar Palavra',
                            svgs: 'assets/imgs/atv_button_svg/press.svg',
                            backgroundColor: Colors.indigoAccent,
                            textSize: 20,
                            svgSize: 56,
                          ),
                          SelectedFrame(
                            parentContext: context,
                            nextPage: CompleteWord(storyId: "", subStoryId: 0, activityId: getRandomActivity("complete_word")),
                            title: 'Completar Palavra',
                            svgs: 'assets/imgs/atv_button_svg/puzzle.svg',
                            backgroundColor: Colors.purpleAccent,
                            textSize: 20,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SelectedFrame(
                            parentContext: context,
                            nextPage: ImageAssociation(storyId: "", subStoryId: 0, activityId: getRandomActivity("image_association")),
                            title: 'Associar Imagem',
                            svgs: 'assets/imgs/atv_button_svg/image_icon.svg',
                            backgroundColor: Colors.lightGreenAccent,
                            textSize: 20,
                          ),
                          SelectedFrame(
                            parentContext: context,
                            nextPage: SelectWordAudio(storyId: "", subStoryId: 0, activityId: getRandomActivity("select_word_by_audio")),
                            title: 'Selecionar Palavras Pelo Áudio',
                            svgs: 'assets/imgs/atv_button_svg/letter_sound.svg',
                            backgroundColor: Colors.pinkAccent,
                            textSize: 15,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SelectedFrame(
                            parentContext: context,
                            nextPage: PressLetter(storyId: "", subStoryId: 0, activityId: getRandomActivity("press_letter")),
                            title: 'Pressionar Letras',
                            svgs: 'assets/imgs/atv_button_svg/press_letter.svg',
                            backgroundColor: Colors.limeAccent,
                            textSize: 20,
                          ),
                          SelectedFrame(
                            parentContext: context,
                            nextPage: ABCPressLetter(storyId: "", subStoryId: 0, activityId: getRandomActivity("abc_press_letters")),
                            title: 'Escolher Letras',
                            svgs: 'assets/imgs/atv_button_svg/abc_press.svg',
                            backgroundColor: Colors.teal,
                            textSize: 20,
                            svgSize: 56,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SelectedFrame(
                            parentContext: context,
                            nextPage: PressSyllable(storyId: "", subStoryId: 0, syllable: 'Bo', activityId: getRandomActivity("mark_the_word")),
                            title: 'Marcar Letras',
                            svgs: 'assets/imgs/atv_button_svg/press_word.svg',
                            backgroundColor: const Color.fromARGB(255, 80, 80, 80),
                            textSize: 20,
                          ),
                          SelectedFrame(
                            parentContext: context,
                            nextPage: CountLettersBySound(storyId: "", subStoryId: 0, activityId: getRandomActivity("count_letter_by_sound")),
                            title: 'Contar Letras por Som',
                            svgs: 'assets/imgs/atv_button_svg/count_sound.svg',
                            backgroundColor: Colors.lightGreenAccent,
                            textSize: 18,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SelectedFrame(
                            parentContext: context,
                            nextPage: SoundLettersAssociation(storyId: "", subStoryId: 0, activityId: getRandomActivity("sound_letters_association")),
                            title: 'Asssociar Letra pelo Som',
                            svgs: 'assets/imgs/atv_button_svg/sound_letter_press.svg',
                            backgroundColor: Colors.pink,
                            textSize: 16,
                            svgSize: 55,
                          ),
                          SelectedFrame(
                            parentContext: context,                          
                            nextPage: UpperLower(storyId: '', subStoryId: 0, activityId: getRandomActivity("upper_and_lowercase")),
                            title: 'Palavras maiúsculas e minúsculas',
                            svgs: 'assets/imgs/atv_button_svg/sound_letter_press.svg',
                            backgroundColor: Colors.pink,
                            textSize: 16,
                            svgSize: 55,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        )
      )
        : const Column(mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [Center(child: CircularProgressIndicator(),)]
              ),
    );
  }
}
