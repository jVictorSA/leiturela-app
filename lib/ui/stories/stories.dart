import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../custom_widgets/return_button.dart';
import '../games/games.dart';

class Stories extends StatelessWidget {
  const Stories({super.key});

  @override
  Widget build(BuildContext context) {
    const textSize = 28.0;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/imgs/background.png"),
            fit: BoxFit.contain,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(children: [ReturnButton(parentContext: context)]),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Stories()),
                            );
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.black, width: 3),
                                borderRadius: BorderRadius.circular(35),
                              ),
                              height: 160,
                              width: 180,
                              margin: const EdgeInsets.only(
                                left: marginVal,
                                right: marginVal,
                                bottom: marginVal,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Heróis",
                                    style: TextStyle(
                                      fontSize: textSize,
                                      fontFamily: 'Playpen-Sans',
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        'assets/imgs/apartment.svg',
                                      ),
                                      SvgPicture.asset(
                                        'assets/imgs/electric_bolt.svg',
                                      ),
                                      SvgPicture.asset(
                                        'assets/imgs/domino_mask.svg',
                                      )
                                    ],
                                  )
                                ],
                              )),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Stories()),
                            );
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.black, width: 3),
                                borderRadius: BorderRadius.circular(35),
                              ),
                              height: 160,
                              width: 180,
                              margin: const EdgeInsets.only(
                                left: marginVal,
                                right: marginVal,
                                bottom: marginVal,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Fadas",
                                    style: TextStyle(
                                      fontSize: textSize,
                                      fontFamily: 'Playpen-Sans',
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        'assets/imgs/castle.svg',
                                        width: 30,
                                        height: 30,
                                      ),
                                      SvgPicture.asset(
                                        'assets/imgs/crown.svg',
                                        width: 35,
                                        height: 35,
                                      ),
                                      SvgPicture.asset(
                                        'assets/imgs/star.svg',
                                        width: 32,
                                        height: 32,
                                      )
                                    ],
                                  )
                                ],
                              )),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Stories()),
                            );
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.black, width: 3),
                                borderRadius: BorderRadius.circular(35),
                              ),
                              height: 160,
                              width: 180,
                              margin: const EdgeInsets.only(
                                left: marginVal,
                                right: marginVal,
                                bottom: marginVal,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Espaço",
                                    style: TextStyle(
                                      fontSize: textSize,
                                      fontFamily: 'Playpen-Sans',
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        'assets/imgs/planet.svg',
                                        height: 35,
                                        width: 35,
                                      ),
                                      SvgPicture.asset(
                                        'assets/imgs/rocket.svg',
                                        height: 35,
                                        width: 35,
                                      ),
                                      SvgPicture.asset(
                                        'assets/imgs/alien.svg',
                                        color: Colors.black,
                                        height: 35,
                                        width: 35,
                                      )
                                    ],
                                  )
                                ],
                              )),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Stories()),
                            );
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.black, width: 3),
                                borderRadius: BorderRadius.circular(35),
                              ),
                              height: 160,
                              width: 180,
                              margin: const EdgeInsets.only(
                                left: marginVal,
                                right: marginVal,
                                bottom: marginVal,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Floresta",
                                    style: TextStyle(
                                      fontSize: textSize,
                                      fontFamily: 'Playpen-Sans',
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        'assets/imgs/bird.svg',
                                        height: 38,
                                        width: 38,
                                      ),
                                      SvgPicture.asset(
                                        'assets/imgs/trail.svg',
                                        height: 35,
                                        width: 35,
                                      ),
                                      SvgPicture.asset(
                                        'assets/imgs/tree.svg',
                                        height: 35,
                                        width: 35,
                                      )
                                    ],
                                  )
                                ],
                              )),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Stories()),
                            );
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                border:
                                Border.all(color: Colors.black, width: 3),
                                borderRadius: BorderRadius.circular(35),
                              ),
                              height: 160,
                              width: 180,
                              margin: const EdgeInsets.only(
                                left: marginVal,
                                right: marginVal,
                                bottom: marginVal,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Aniversário",
                                    style: TextStyle(
                                      fontSize: textSize,
                                      fontFamily: 'Playpen-Sans',
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        'assets/imgs/balloon.svg',
                                        height: 35,
                                        width: 35,
                                      ),
                                      SvgPicture.asset(
                                        'assets/imgs/cake.svg',
                                        height: 35,
                                        width: 35,
                                      ),
                                      SvgPicture.asset(
                                        'assets/imgs/gift.svg',
                                        height: 35,
                                        width: 35,
                                      )
                                    ],
                                  )
                                ],
                              )),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Stories()),
                            );
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                border:
                                Border.all(color: Colors.black, width: 3),
                                borderRadius: BorderRadius.circular(35),
                              ),
                              height: 160,
                              width: 180,
                              margin: const EdgeInsets.only(
                                left: marginVal,
                                right: marginVal,
                                bottom: marginVal,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Piratas",
                                    style: TextStyle(
                                      fontSize: textSize,
                                      fontFamily: 'Playpen-Sans',
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        'assets/imgs/ship.svg',
                                        height: 35,
                                        width: 35,
                                      ),
                                      SvgPicture.asset(
                                        'assets/imgs/map.svg',
                                        height: 35,
                                        width: 35,
                                      ),
                                      SvgPicture.asset(
                                        'assets/imgs/treasure.svg',
                                        height: 35,
                                        width: 35,
                                      )
                                    ],
                                  )
                                ],
                              )),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
