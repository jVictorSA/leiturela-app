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
import 'package:demo_app/ui/games/activities/activities_map.dart' as activitiesMap;


// for ( var i in text ) Text(i.toString())Future<String> fetchStory(id) async {
Future<String> fetchStories(http.Client client) async {
  var response = await client.get(Uri.parse('http://10.0.2.2:8000/atividade/stories'));
  // print(id);
  // print(response.body);

  if (response.statusCode == 200) {
  var decoded = utf8.decode(response.bodyBytes);
  // print(decoded);

    return decoded.toString();
  }
  return response.body;
}

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
        // print(entireObject);
        List stories = json.decode(entireObject);
        List<String> titles = [];
        for (var story in stories){                  
          titles.add(story["story_prompt"]);
          widget.ids.add(story["_id"]);          
          
          List<dynamic> activitiesArroba = story["activities"];
          // print(activitiesArroba);
          widget.activities_ids.add(activitiesArroba.cast<String>());
          // widget.nextActivitiesType.add(story[])
        }
        widget.storiesLength = stories.length;
        widget.titles = titles;
        print(titles);
        isLoaded = true;
        // print(widget.ids);
        // print(widget.activities_ids);
        
        // print(widget.storiesLength);
        // print(widget.titles);
      })
    });
  }

  Widget getTextWidgets(int firstIndex)
  {
    List<Widget> list = <Widget>[];
    // print(firstIndex);
    int maxTextLength = 10;
    int smallTextSize = 18;
    // for ( var i = 0; i < widget.titles!.length; i = i + 2){
    if (firstIndex < widget.titles!.length -1){
      // print("par");
      list.add(SelectedFrame(
                backgroundColor: Colors.blueGrey,
                parentContext: context,
                nextPage: ShowStory(
                  parentContext: context,
                  storyId: widget.ids[firstIndex],
                  subStoryId: 0,
                  storyTitle: "História",
                  storyContent: "Olá",
                  nextPage: CountLetters(subStoryId: 0, storyId: widget.ids[firstIndex],
                                         activityId: widget.activities_ids[firstIndex][1],
                                         nextActivityId: widget.activities_ids[firstIndex][1+1],
                                        ),
                ),
                title: widget.titles![firstIndex],
                svgs: 'assets/imgs/apartment.svg',
                textSize: widget.titles![firstIndex].length < maxTextLength ? 28 : smallTextSize.toDouble()
              )
      );
      list.add(SelectedFrame(
                parentContext: context,
                backgroundColor: Colors.blueGrey,
                nextPage: ShowStory(
                  parentContext: context,
                  storyId: widget.ids[firstIndex + 1],
                  subStoryId: 0,
                  storyTitle: "História",
                  storyContent: "Olá",
                  nextPage: CountLetters(subStoryId: 0, storyId: widget.ids[firstIndex + 1],
                                         activityId: widget.activities_ids[firstIndex+1][1],
                                         nextActivityId: widget.activities_ids[firstIndex+1][1+1]
                                        ),
                ),
                title: widget.titles![firstIndex+1],
                svgs: 'assets/imgs/electric_bolt.svg',
                textSize: widget.titles![firstIndex+1].length < maxTextLength ? 28 : smallTextSize.toDouble(),
              )
      );
    }else{

      list.add(SelectedFrame(
                backgroundColor: Colors.blueGrey,
                parentContext: context,
                nextPage: ShowStory(
                  parentContext: context,
                  storyId: widget.ids[firstIndex],
                  subStoryId: 0,
                  storyTitle: "História",
                  storyContent: "Olá",
                  nextPage: CountLetters(subStoryId: 0, storyId: widget.ids[firstIndex],
                                        activityId: widget.activities_ids[firstIndex][1],
                                         nextActivityId: widget.activities_ids[firstIndex][1+1]
                                        ),
                ),
                title: widget.titles![firstIndex],
                svgs: 'assets/imgs/domino_mask.svg',
                textSize: widget.titles![firstIndex].length < maxTextLength ? 28 : smallTextSize.toDouble(),
              ));
    }
    // }
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: list);
  }

  @override
  Widget build(BuildContext context) {    
    return Scaffold(
      body: SingleChildScrollView(
        child: isLoaded ? Stack(
          children: [
            Positioned.fill(
              child: SvgPicture.asset(
                "assets/imgs/background.svg", // Update with your SVG path
                fit: BoxFit.cover, // Same as the fit you used for PNG
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
        : const Column(mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [Center(child: CircularProgressIndicator(),)]
                ),
      ),
    );
  }
}
