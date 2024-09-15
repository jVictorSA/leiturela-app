import 'package:demo_app/ui/minigames/minigames.dart';
import 'package:flutter/material.dart';
import 'package:demo_app/ui/stories/stories.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../custom_widgets/return_button.dart';

const primaryColor = Color(0xFFAAE0F1);

const marginVal = 30.0;

class Games extends StatelessWidget{
  const Games({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
        // backgroundColor = primaryColor,
      body: Container(
      decoration: const BoxDecoration( 
            image: DecorationImage(
              image: AssetImage("assets/imgs/background.png"),
              fit: BoxFit.contain,
            ),
          ),   
      child: Column(
        children: [
          Row(children: 
              [ReturnButton(parentContext: context)]
            ),            
            Expanded(child:  
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: (){
                        Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const Stories()),
                              );
                      },
                      child:Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                            width: 3
                          ),
                          borderRadius: BorderRadius.circular(35),                    
                        ),
                        height: 160,
                        width: 180,
                        margin: const EdgeInsets.only(left: marginVal,
                                                      right: marginVal,
                                                      bottom: marginVal,
                                                    ),
                        child:  Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text("História",
                              style: TextStyle(
                                fontSize: 32,
                                fontFamily: 'Playpen-Sans',
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,                            
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
                        )
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const Minigames()),
                              );
                      },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                          width: 3
                        ),
                        borderRadius: BorderRadius.circular(35),                    
                      ),
                      height: 160,
                      width: 180,
                      margin: const EdgeInsets.only(left: marginVal,
                                                    right: marginVal,
                                                    bottom: marginVal,
                                                  ),
                      child:  Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text("Minigames",
                            style: TextStyle(
                              fontSize: 32,
                              fontFamily: 'Playpen-Sans',
                            ),
                          ),
                          Row(                            
                            crossAxisAlignment: CrossAxisAlignment.center,  
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,                          
                            children: [
                              SvgPicture.asset(
                                'assets/imgs/mood.svg',                
                              ),
                              SvgPicture.asset(
                                'assets/imgs/abc.svg',                
                              ),
                              SvgPicture.asset(
                                'assets/imgs/joystick.svg',                
                              )
                            ],
                          )
                        ],
                      )
                    ),
                    )
                  ],
                ),
              
          ],
        ),
            ),
        ]
        ),
      ),      
    );
  }
}