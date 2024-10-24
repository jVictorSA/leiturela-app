import 'package:demo_app/ui/stories/show_story.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';// show utf8;

import '../custom_widgets/return_button.dart';
import '../custom_widgets/selected_frame.dart';
// import '../games/games.dart';
import '../games/activities/count_letters.dart';
// import '../games/activities/drag_crossword.dart';


// for ( var i in text ) Text(i.toString())Future<String> fetchStory(id) async {
Future<String> fetchStories() async {
  var response = await http.get(Uri.parse('http://10.0.2.2:8000/stories/'));
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

  Stories({
    super.key,
    this.storiesLength,
    this.titles,
  });

  @override
  StoriesState createState() => StoriesState();
}

class StoriesState extends State<Stories>{
  
  @override
  void initState() {
    super.initState();    
    fetchStories().then((response) => {
      setState(() {
        String entireObject;
        entireObject = response;
        // print(entireObject);
        List stories = json.decode(entireObject);
        List<String> titles = [];
        for (var story in stories){
          titles.add(story["story_prompt"]);
        }
        widget.storiesLength = stories.length;  
        widget.titles = titles;
        // print(widget.storiesLength);
        // print(widget.titles);
      })
    });
  }

  Widget getTextWidgets(int firstIndex)
  {
    List<Widget> list = <Widget>[];
    // print(firstIndex);
    int maxTextLength = 20;
    // for ( var i = 0; i < widget.titles!.length; i = i + 2){
    if (firstIndex < widget.titles!.length -1){
      // print("par");
      list.add(SelectedFrame(
                parentContext: context,
                nextPage: ShowStory(
                  parentContext: context,
                  storyId: firstIndex+1,
                  subStoryId: 1,
                  storyTitle: "História",
                  storyContent: "Olá",
                  nextPage: CountLetters(subStoryId: 1, storyId: firstIndex+1),
                ),
                title: widget.titles![firstIndex],
                svgs: const [
                  'assets/imgs/apartment.svg',
                  'assets/imgs/electric_bolt.svg',
                  'assets/imgs/domino_mask.svg'
                ],
                textSize: widget.titles![firstIndex].length < maxTextLength ? 28 : 20
              )
      );
      list.add(SelectedFrame(
                parentContext: context,
                nextPage: ShowStory(
                  parentContext: context,
                  storyId: firstIndex+2,
                  subStoryId: 1,
                  storyTitle: "História",
                  storyContent: "Olá",
                  nextPage: CountLetters(subStoryId: 1, storyId: firstIndex+2),
                ),
                title: widget.titles![firstIndex+1],
                svgs: const [
                  'assets/imgs/apartment.svg',
                  'assets/imgs/electric_bolt.svg',
                  'assets/imgs/domino_mask.svg'
                ],
                textSize: widget.titles![firstIndex+1].length < maxTextLength ? 28 : 20,
              )        
      );
    }else{
      
      list.add(SelectedFrame(
                parentContext: context,
                nextPage: ShowStory(
                  parentContext: context,
                  storyId: firstIndex+1,
                  subStoryId: 1,
                  storyTitle: "História",
                  storyContent: "Olá",
                  nextPage: CountLetters(subStoryId: 1, storyId: firstIndex+1),
                ),
                title: widget.titles![firstIndex],
                svgs: const [
                  'assets/imgs/apartment.svg',
                  'assets/imgs/electric_bolt.svg',
                  'assets/imgs/domino_mask.svg'
                ],
                textSize: widget.titles![firstIndex].length < maxTextLength ? 28 : 20
              ));
    }
    // }
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: list);
  }

  @override
  Widget build(BuildContext context) {    
    // print(widget.storiesLength);
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
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
                  child: 
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for ( var i = 0; i < widget.titles!.length; i = i + 2) getTextWidgets(i)                      
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
