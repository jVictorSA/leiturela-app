import 'package:demo_app/ui/games/games.dart';
import 'package:demo_app/ui/leaderboard/leaderboard.dart';
import 'package:demo_app/ui/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:flutter/services.dart';

const primaryColor = Color(0xFFAAE0F1);
const outlineTitle = 1.0;


void main() {
  WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  // );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Builder(
        builder: (context) => Scaffold(        
          backgroundColor: primaryColor,
          body: Container(
          decoration: const BoxDecoration( 
            image: DecorationImage(
              image: AssetImage("assets/imgs/background.png"),
              fit: BoxFit.contain,
            ),
          ), 
          child: Center(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          right: 16.0,
                          top: 40.0
                        ),
                        child: Container(
                          height: 40.0,
                          width: 40.0,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter,
                              stops: [0.5,         
                                      0.9,
                                    ],
                              colors: [Color(0xff03BFE7),Color(0xff01419F)]
                            ),
                            borderRadius: BorderRadius.circular(30)
                          ),
                          child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const Settings()),
                            );
                          },
                          style: ButtonStyle(
                                              backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
                                              shadowColor: MaterialStateProperty.all<Color>(Colors.transparent),
                                              padding: MaterialStateProperty.all(EdgeInsets.zero),
                                            ),
                          child: const Icon(Icons.settings,
                                      color: Colors.white
                                ),
                          )
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(
                          right: 48.0,
                          top: 40.0
                        ),
                        child: Container(
                          height: 40.0,
                          width: 40.0,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter,
                              stops: [0.5,         
                                      0.9,
                                    ],
                              colors: [Color(0xff03BFE7),Color(0xff01419F)]
                            ),
                            borderRadius: BorderRadius.circular(30)
                          ),
                          child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const Leaderboard()),
                            );
                          },
                          style: ButtonStyle(
                                              backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
                                              shadowColor: MaterialStateProperty.all<Color>(Colors.transparent),
                                              padding: MaterialStateProperty.all(EdgeInsets.zero),
                                            ),
                          child: const Icon(Icons.leaderboard,
                                        color: Colors.white
                                       ),
                            
                          )
                        ),
                      ),
                    ]
                  ),
                          
                  GradientText(
                    'Leiturela',
                    style: const TextStyle(
                      fontSize: 80.0,
                      fontFamily: 'Playpen-Sans',
                      fontWeight: FontWeight.bold,
                      shadows: [
                                  Shadow( // bottomLeft
                                    offset: Offset(-outlineTitle, -outlineTitle),
                                    color: Colors.black
                                  ),
                                  Shadow( // bottomRight
                                    offset: Offset(outlineTitle, -outlineTitle),
                                    color: Colors.black
                                  ),
                                  Shadow( // topRight
                                    offset: Offset(outlineTitle, outlineTitle),
                                    color: Colors.black
                                  ),
                                  Shadow( // topLeft
                                    offset: Offset(-outlineTitle, outlineTitle),
                                    color: Colors.black
                                  ),
                                ]
                    ),
                    gradientType: GradientType.linear,
                    gradientDirection: GradientDirection.ttb,
                    radius: 4.4,
                    colors: const [
                      Color(0xff03BFE7),
                      Color(0xff01419F),
                    ],
                  ),
                  Container(
                    height: 44.0,
                    width: 120.0,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter,
                        stops: [0.5,         
                                0.9,
                              ],
                        colors: [Color(0xff03BFE7),Color(0xff01419F)]
                      ),                                                           
                      borderRadius: BorderRadius.circular(30)
                    ),

                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const Games()),
                      );
                      },
                      style:ButtonStyle(
                                        backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
                                        shadowColor: MaterialStateProperty.all<Color>(Colors.transparent),
                                        padding: MaterialStateProperty.all(EdgeInsets.zero),                                              
                                       ),
                      child: const Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('Jogar',
                              style: TextStyle(            
                                fontFamily: 'Playpen-Sans',    
                                fontWeight: FontWeight.w400,
                                fontSize: 24,
                                color: Colors.white,                                
                              ),
                            ),
                            Padding(padding: EdgeInsets.symmetric(horizontal: 5.0),
                              child: Icon(Icons.play_circle_fill,
                                          color: Colors.white
                                      ),
                            ),                        
                          ]
                        ),
                      )
                    )
                  )
                ],            
              ),
            ),
          ),
        )
      )
    );
  }
}