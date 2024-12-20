import 'package:demo_app/ui/games/activities/custom_widgets/activity_background.dart';
import 'package:demo_app/ui/stories/show_story.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';// show utf8;

import '../custom_widgets/return_button.dart';
import '../custom_widgets/selected_frame.dart';
import '../games/story_games_screen.dart';
// import '../games/games.dart';
import '../games/activities/count_letters.dart';
// import '../games/activities/drag_crossword.dart';
import 'package:demo_app/ui/games/activities/activities_map.dart';
import "package:demo_app/services/services.dart";

class Stories extends StatefulWidget {
  int? storiesLength;
  List<String>? titles;
  List<String> ids = [];
  List<List<String>> activities_ids = [];
  List<String> nextActivitiesType = [];

  Stories({
    super.key,
    this.storiesLength,
    this.titles,
    // this.nextActivityType = "",
  });

  @override
  StoriesState createState() => StoriesState();
}

class StoriesState extends State<Stories>{
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    fetchStories(http.Client()).then((response) => {
      setState(() {
        String entireObject;
        entireObject = response;        
        List stories = json.decode(entireObject);
        List<String> titles = [];
        for (var story in stories){
          titles.add(story["story_prompt"]);
          widget.ids.add(story["_id"]);          
          
          List<dynamic> activitiesArroba = story["activities"];          
          widget.activities_ids.add(activitiesArroba.cast<String>());          
        }
        widget.storiesLength = stories.length;
        widget.titles = titles;
        
        isLoaded = true;
      })
    });
  }

  Widget getTextWidgets(int firstIndex)
  {
    List<Widget> list = <Widget>[];    
    int maxTextLength = 10;
    int smallTextSize = 18;
    
    if (firstIndex < widget.titles!.length -1){      
      list.add(SelectedFrame(
                backgroundColor: Colors.blueGrey,
                parentContext: context,
                nextPage: ShowStory(
                  parentContext: context,
                  storyId: widget.ids[firstIndex],
                  subStoryId: 0,
                  storyTitle: "História",
                  storyContent: "Faça Login para jogar as histórias",
                  nextPage: GetActivities(0,
                                          widget.ids[firstIndex],
                                          // widget.activities_ids[firstIndex][1],
                                          widget.activities_ids[firstIndex][0],
                                         )
                ),
                title: widget.titles![firstIndex],
                svgs: 'assets/imgs/${widget.titles![firstIndex]}.svg',
                textSize: widget.titles![firstIndex].length < maxTextLength ? 28 : smallTextSize.toDouble()
              )
      );
      list.add(SelectedFrame(
                parentContext: context,
                backgroundColor: Colors.orange,
                nextPage: ShowStory(
                  parentContext: context,
                  storyId: widget.ids[firstIndex + 1],
                  subStoryId: 0,
                  storyTitle: "História",
                  storyContent: "Faça Login para jogar as histórias",
                  nextPage: GetActivities(0,
                                          widget.ids[firstIndex + 1],
                                          // widget.activities_ids[firstIndex][1],
                                          widget.activities_ids[firstIndex + 1][1+1],
                                         )
                ),
                title: widget.titles![firstIndex+1],
                svgs: 'assets/imgs/${widget.titles![firstIndex+1]}.svg',
                textSize: widget.titles![firstIndex+1].length < maxTextLength ? 28 : smallTextSize.toDouble(),
              )
      );
    }else{
      list.add(SelectedFrame(
                backgroundColor: Colors.teal,
                parentContext: context,
                nextPage: ShowStory(
                  parentContext: context,
                  storyId: widget.ids[firstIndex],
                  subStoryId: 0,
                  storyTitle: "História",
                  storyContent: "Faça Login para jogar as histórias",
                  nextPage: GetActivities(0,
                                          widget.ids[firstIndex],
                                          // widget.activities_ids[firstIndex][1],
                                          widget.activities_ids[firstIndex][1+1],
                                         )
                ),
                title: widget.titles![firstIndex],
                svgs: 'assets/imgs/${widget.titles![firstIndex]}.svg',
                textSize: widget.titles![firstIndex].length < maxTextLength ? 28 : smallTextSize.toDouble(),
              ));
    }
    // }
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: list);
  }

  @override
  Widget build(BuildContext context) {    
    return Scaffold(
      body: isLoaded ? SingleChildScrollView(
        child: Stack(
          children: [
            Positioned.fill(
              child: SvgPicture.asset(
                "assets/imgs/backgrounds/background.svg",
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
                      for ( var i = 0; i < widget.titles!.length; i = i + 2) getTextWidgets(i)
                    ],
                  )
                )
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
