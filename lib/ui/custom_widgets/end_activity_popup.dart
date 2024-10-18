import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../main.dart';
import '../minigames/minigames.dart';

class EndActivityPopup extends StatelessWidget {
  final Widget currentScreen;
  final bool story; // Story or Activity ?

  const EndActivityPopup({super.key, required this.currentScreen, required this.story});

  @override
  Widget build(BuildContext context) {

    final screenHeight = MediaQuery.of(context).size.height;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      backgroundColor: Colors.transparent,
      child: Center(
    child: Stack(
        children: [
          Transform.translate(
            offset: Offset(90,0), // Move 20 pixels to the right
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              // Adjust the radius as needed
              child: SvgPicture.asset(
                'assets/imgs/background.svg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Container(
              height: 500,
              width: 750,
              padding: EdgeInsets.all(5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Spacer(flex: 1,),
                      Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.identity()..scale(-1.0, 1.0),
                        child: SvgPicture.asset(
                          "assets/imgs/star.svg",
                          fit: BoxFit.cover,
                          width: 64,
                          height: 64,
                          color: Colors.black,
                        ),
                      ),
                      Spacer(flex: 2,)
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        // You can adjust the padding value
                        child: Text(
                          'Bom Trabalho!',
                          style: TextStyle(
                            fontFamily: 'Playpen-Sans',
                            fontWeight: FontWeight.w400,
                            fontSize: 48,
                            color: Colors.black,
                            letterSpacing: 2,
                            shadows: [
                              Shadow(
                                offset: Offset(2.0, 2.0),
                                blurRadius: 5.0,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
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
                                    builder: (context) => const Minigames()),
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
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Center(
                                      child: Padding(
                                        padding:
                                        EdgeInsets.only(bottom: 360 * 0.01),
                                        child: Text(
                                          story ? 'Próxima História': 'Próxima Atividade',
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
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        // You can adjust the padding value
                        child: Container(
                          height: 56.0,
                          width: 272.0,
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
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => currentScreen, // Navigate to the current screen again
                                ),
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
                                          'Tentar Novamente',
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
                                  ]),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
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
                                  ]),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Spacer(flex: 2,),
                      SvgPicture.asset(
                        "assets/imgs/star.svg",
                        fit: BoxFit.cover,
                        width: 72,
                        height: 72,
                        color: Colors.black,
                      ),
                      Spacer(flex: 1,),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      ),);
  }
}
