// import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';// show utf8;

import '../custom_widgets/return_button.dart';

Future<String> fetchStory(id) async {
  var response = await http.get(Uri.parse('http://10.0.2.2:8000/atividade/story:$id'), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY3MzNkNDI3ODc2ZDRmZGNhNGQ0MGM3ZiIsImV4cCI6MTczMTU1MzUyOX0.Kd0RuMdzxi1nolZrl9SvJOfEHx8GCuN4gKmmUbwasGI',
    });
  print(id);
  print(response.body);

  if (response.statusCode == 200) {
  var decoded = utf8.decode(response.bodyBytes);
  // print(decoded);

    return decoded.toString();
  }
  return response.body;
}


class ShowStory extends StatefulWidget {
  BuildContext parentContext;
  Widget nextPage;
  double marginVal = 30.0;
  double textSize;
  String storyTitle;
  String storyContent;
  String storyId;
  int subStoryId;
  String nextActivityType;

  ShowStory({
    super.key,
    required this.parentContext,
    required this.nextPage,
    required this.storyTitle,
    required this.storyContent,
    required this.storyId,
    required this.subStoryId,
    this.nextActivityType = "",
    double? textSize, // Add an optional parameter
  }) : textSize = textSize ?? 28.0; // Set default value to 28.0 if null

  @override
  ShowStoryState createState() => ShowStoryState();
}

class ShowStoryState extends State<ShowStory> {
  // BuildContext? parentContext;
  // Widget? nextPage;
  // final marginVal = 30.0;
  // double? textSize;
  // String? storyTitle;
  String storyContent = "";
  

  // const ShowStory({
  //   super.key,
  //   required this.parentContext,
  //   required this.nextPage,
  //   required this.storyTitle,
  //   // required this.svgs,
  //   double? textSize, // Add an optional parameter
  // }) : textSize = textSize ?? 28.0; // Set default value to 28.0 if null

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
        // print(substory);
        storyContent = substory;
        // print(valueMap["sub_stories"]);
      })
    });
  }

  
  @override
  Widget build(BuildContext parentContext) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: SvgPicture.asset(
              "assets/imgs/background.svg",
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
                            storyContent,
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
              child:  Container(
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
                                            widget.nextPage),
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
                                  ))
              )

            ],
          )
        ],
      ),
    );
  }
}
