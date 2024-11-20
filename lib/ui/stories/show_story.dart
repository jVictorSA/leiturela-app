// import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';// show utf8;

import '../custom_widgets/return_button.dart';
import 'package:demo_app/ui/games/activities/activities_map.dart';
import "package:demo_app/services/services.dart";

class ShowStory extends StatefulWidget {
  BuildContext parentContext;
  GetActivities nextPage;
  double marginVal = 30.0;
  double textSize;
  String storyTitle;
  String storyContent;
  String storyId;
  int subStoryId;
  // String nextActivityType;

  ShowStory({
    super.key,
    required this.parentContext,
    required this.nextPage,
    required this.storyTitle,
    required this.storyContent,
    required this.storyId,
    required this.subStoryId,
    // required this.nextActivityType,
    double? textSize, // Add an optional parameter
  }) : textSize = textSize ?? 28.0; // Set default value to 28.0 if null

  @override
  ShowStoryState createState() => ShowStoryState();
}

class ShowStoryState extends State<ShowStory> {  
  // String storyContent = "";
  String nextActivityType = "";
  String nextActivityId = "";
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    widget.storyTitle = "Xis";
    fetchStory(widget.storyId).then((response) => {
      setState(() {
        String storyId = widget.storyId;
        String entireObject;        
        int subStoryId = widget.subStoryId;
        print("História: $storyId - substória: $subStoryId");
        entireObject = response;
        Map subStories = json.decode(entireObject);
        String substory = subStories["chunks"][subStoryId];

        widget.storyContent = substory;
        nextActivityType = subStories["activities"][subStoryId]["type"];        
      })
    });

    fetchNextActivity(widget.storyId, widget.subStoryId).then((response) => {
      setState(() {        
        nextActivityId = response;
        isLoaded = true;
      })
    });
    print("isLoaded: " + isLoaded.toString());
  }

  
  @override
  Widget build(BuildContext parentContext) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: SvgPicture.asset(
              "assets/imgs/backgrounds/background.svg",
              // Update with your SVG path
              fit: BoxFit.cover, // Same as the fit you used for PNG
            ),
          ),
          Column(
            children: [
              Row(children: [ReturnButton(parentContext: parentContext)]),              
              Center(                
                child: Container(
                  constraints:const  BoxConstraints(minHeight: 40, maxHeight: 200, maxWidth: 620, minWidth: 40),
                  decoration: BoxDecoration(color: Colors.yellow.shade100, borderRadius: BorderRadius.circular(20)),
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                            widget.storyContent,
                            style: const TextStyle(
                                fontSize: 28,
                                fontFamily: 'Playpen-Sans',
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                            ),
                            textAlign: TextAlign.left,
                      )
                    ],
                  ),
                )
              ),
              
              Padding(padding: const EdgeInsets.only(top: 60.0),
              child:  isLoaded ?
                                // Caso dados forem carregados 
                                Container(
                                  height: 70.0,
                                  width: 100.0,
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
                                      BorderRadius.circular(10)),
                                      child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                            widget.nextPage.getActivity(nextActivityType,
                                                                        nextActivityId)),
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
                                    child: const Icon(Icons.play_circle_fill,
                                                      color: Colors.white,
                                                      size: 50)
                                    )
                                  ) :
                                
                                // Caso dados não tiverem sido caregados
                                Container(
                                  height: 70.0,
                                  width: 100.0,
                                  decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          stops: [
                                            0.5,
                                            0.9,
                                          ],
                                          colors: [
                                            Color.fromARGB(255, 158, 161, 161),
                                            Color.fromARGB(255, 69, 70, 73)
                                          ]),
                                      borderRadius:
                                      BorderRadius.circular(10)),
                                      child: ElevatedButton(
                                    onPressed: () {},
                                    style: ButtonStyle(
                                      backgroundColor:
                                      MaterialStateProperty.all<
                                          Color>(Colors.transparent),
                                      shadowColor: MaterialStateProperty
                                          .all<Color>(Colors.transparent),
                                      padding: MaterialStateProperty.all(
                                          EdgeInsets.zero),
                                    ),
                                    child: const Icon(Icons.play_circle_fill,
                                                      color: Colors.white,
                                                      size: 50)
                                    )
                                  )
              )

            ],
          )
        ],
      ),
    );
  }
}
