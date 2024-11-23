import 'package:demo_app/ui/games/activities/custom_widgets/golden_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

import 'package:demo_app/ui/stories/stories.dart';
import 'package:demo_app/main.dart';
// import '../games/activities/custom_widgets/golden_text.dart';
import '../minigames/minigames.dart';
import '../games/activities/count_letters.dart';
// import '../games/activities/drag_crossword.dart';
import 'package:demo_app/ui/stories/show_story.dart';
import 'package:demo_app/ui/games/activities/activities_map.dart';

class EndActivityPopup extends StatelessWidget {
  final Widget currentScreen;
  final bool story; // Story or Activity ?
  final String? storyId;
  final int? subStoryId;
  final BuildContext ctx; // Story or Activity ?
  final String nextActivityId;
  // final Type sameScreen;

  const EndActivityPopup({super.key,
                          required this.currentScreen,
                          required this.story,
                          required this.storyId,
                          required this.subStoryId,
                          required this.ctx,
                          this.nextActivityId = "",
                          // this.sameScreen = Container
                        });

  Widget getNextPage(){
    print("EndActivityPopup nxtActivityID: $nextActivityId");
    if (nextActivityId != ""){
      if (subStoryId! >= 9){
        return Stories();  
      }
      else{

      return ShowStory(
                  parentContext: ctx,
                  storyId: storyId!,
                  subStoryId: subStoryId! + 1,
                  storyTitle: "História",
                  storyContent: "Olá",
                  nextPage: GetActivities(subStoryId!+1,
                                          storyId!,
                                          
                                          // fetchNextActivity(storyId!, curentSubstory)
                                          nextActivityId,
                                          ),
                  // CountLetters(subStoryId: subStoryId! + 1, storyId: storyId!),
                );
      }
    }
    return const Minigames();
  }
  @override
  Widget build(BuildContext context) {

    final screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    final screenHeigth = MediaQuery
        .of(context)
        .size
        .height;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      backgroundColor: Colors.transparent,
      child: Center(
        child: ClipRect(
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFF2CA7E4), width: 5),
              borderRadius: BorderRadius.circular(30),
            ),
            width: 600,
            height: 340,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Stack(
                alignment: Alignment.center, // Center the children
                children: [
                SvgPicture.asset(
                'assets/imgs/backgrounds/background.svg',
                fit: BoxFit.fill,
              ),
              Container(
                height: 275,
                width: 750,
                padding: const EdgeInsets.all(5),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Padding(
                        padding: EdgeInsets.all(10.0),
                        // You can adjust the padding value
                        child: GoldenText(
                          text: "BOM TRABALHO!",
                          textSize: 48,
                          borderColor: 0xFF0C0C0C,
                          borderWidth: 5,
                          fontWeight: FontWeight.bold,
                        )),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      // You can adjust the padding value
                      child: Container(
                        height: 56.0,
                        width: 272,
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
                            borderRadius: BorderRadius.circular(30)),
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => getNextPage()
                                ),
                                ModalRoute.withName("/")
                              // (route) => false
                            );
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.transparent),
                            shadowColor: MaterialStateProperty.all<Color>(
                                Colors.transparent),
                            padding:
                            MaterialStateProperty.all(EdgeInsets.zero),
                          ),
                          child: Center(
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment:
                                CrossAxisAlignment.center,
                                children: [
                                  Center(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 360 * 0.01),
                                      child: Text(
                                        story
                                            ? 'Próxima História'
                                            : 'Próxima Atividade',
                                        style: const TextStyle(
                                          fontFamily: 'Playpen-Sans',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 24,
                                          color: Colors.white,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ]),
                          ),
                        ),
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   // You can adjust the padding value
                    //   child: Container(
                    //     height: 56.0,
                    //     width: 272.0,
                    //     decoration: BoxDecoration(
                    //         gradient: const LinearGradient(
                    //             begin: Alignment.topCenter,
                    //             end: Alignment.bottomCenter,
                    //             stops: [
                    //               0.5,
                    //               0.9,
                    //             ],
                    //             colors: [
                    //               Color(0xff03BFE7),
                    //               Color(0xff01419F)
                    //             ]),
                    //         borderRadius: BorderRadius.circular(30)),
                    //     child: OutlinedButton(
                    //       onPressed: () {
                    //         Navigator.pushAndRemoveUntil(
                    //             context,
                    //             MaterialPageRoute(
                    //                 builder: (context) => sameScreen
                    //             ),
                    //             ModalRoute.withName("/")
                    //           // (route) => false
                    //         );
                    //       },
                    //       style: ButtonStyle(
                    //         backgroundColor: MaterialStateProperty.all<Color>(
                    //             Colors.transparent),
                    //         shadowColor: MaterialStateProperty.all<Color>(
                    //             Colors.transparent),
                    //         padding:
                    //         MaterialStateProperty.all(EdgeInsets.zero),
                    //       ),
                    //       child: const Center(
                    //         child: Row(
                    //             mainAxisAlignment: MainAxisAlignment.center,
                    //             crossAxisAlignment:
                    //             CrossAxisAlignment.center,
                    //             children: [
                    //               Center(
                    //                 child: Padding(
                    //                   padding: EdgeInsets.only(
                    //                       bottom: 360 * 0.01),
                    //                   child: Text(
                    //                     'Tentar Novamente',
                    //                     style: TextStyle(
                    //                       fontFamily: 'Playpen-Sans',
                    //                       fontWeight: FontWeight.w400,
                    //                       fontSize: 24,
                    //                       color: Colors.white,
                    //                     ),
                    //                     textAlign: TextAlign.center,
                    //                   ),
                    //                 ),
                    //               ),
                    //             ]),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      // You can adjust the padding value
                      child: Container(
                        height: 56.0,
                        width: 272,
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
                            borderRadius: BorderRadius.circular(30)),
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const MyApp()),
                            );
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.transparent),
                            shadowColor: MaterialStateProperty.all<Color>(
                                Colors.transparent),
                            padding:
                            MaterialStateProperty.all(EdgeInsets.zero),
                          ),
                          child: const Center(
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Center(
                                    child: Padding(
                                      padding:
                                            EdgeInsets.only(bottom: 360 * 0.01),
                                      child: Text(
                                        'Voltar ao Menu',
                                        style: TextStyle(
                                          fontFamily: 'Playpen-Sans',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 24,
                                          color: Colors.white,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        ),
    );
  }
}
