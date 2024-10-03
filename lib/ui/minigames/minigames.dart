import 'package:flutter/material.dart';
import '../custom_widgets/return_button.dart';
import '../custom_widgets/selected_frame.dart';
import 'package:flutter_svg/svg.dart';
import '../games/games.dart';

class Minigames extends StatelessWidget {
  Minigames({super.key});

  List<String> myArray = ['Montar Palavra', 'Divisão Silábica'];//, 'Reconhecimento de Voz', 'Corrigir Palavra'];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Positioned.fill(
              child: SvgPicture.asset(
                "assets/imgs/background.svg",
                fit: BoxFit.cover,
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
                          SelectedFrame(parentContext: context, 
                                        nextPage: const Games(),
                                        title: 'Montar Palavra',
                                        svgs: const ['assets/imgs/apartment.svg',
                                                     'assets/imgs/electric_bolt.svg',
                                                     'assets/imgs/domino_mask.svg'
                                                    ]
                                       ),
                          
                          SelectedFrame(parentContext: context, 
                                        nextPage: const Games(),
                                        title: 'Reconhecimento por voz',
                                        svgs: const ['assets/imgs/castle.svg',
                                                     'assets/imgs/crown.svg',
                                                     'assets/imgs/star.svg'
                                                    ]
                                       ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SelectedFrame(parentContext: context, 
                                        nextPage: const Games(),
                                        title: 'Divisão Silábica',
                                        svgs: const ['assets/imgs/planet.svg',
                                                     'assets/imgs/rocket.svg',
                                                     'assets/imgs/alien.svg'
                                                    ]
                                       ),
                          
                          SelectedFrame(parentContext: context, 
                                        nextPage: const Games(),
                                        title: 'Corrigir Palavra',
                                        svgs: const ['assets/imgs/bird.svg',
                                                     'assets/imgs/trail.svg',
                                                     'assets/imgs/tree.svg'
                                                    ]
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