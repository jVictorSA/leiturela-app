import 'package:demo_app/ui//games/activities/count_letters.dart';
import 'package:demo_app/ui//games/activities/build_letter.dart';
import 'package:demo_app/ui//games/activities/complete_word.dart';
import 'package:flutter/material.dart';


class GetActivities{
  int subStoryId;
  String storyId;  
  String nextActivityId;

  GetActivities(this.subStoryId,
                this.storyId,
                this.nextActivityId                
               );
  
  Widget getActivity (String activityType, String nextActivityId){
    print(subStoryId);
    if (activityType == "conta_letra"){
      return CountLetters(subStoryId: subStoryId,
                          storyId: storyId,
                          activityId: nextActivityId,
                          // nextActivityId: nextActivityId,
                        );
    }
    else if(activityType == "build_letter"){
      return BuildWord(subStoryId: subStoryId,
                       storyId: storyId,
                       activityId: nextActivityId
                      );
    }
      
    else if(activityType == "complete_word"){
      return CompleteWord(subStoryId: subStoryId,
                          storyId: storyId,
                          activityId: nextActivityId);
    }
    
    // Caso base apenas para não dar erro de Null-Safety
    else{
      return CountLetters(subStoryId: subStoryId,
                          storyId: storyId,
                          activityId: nextActivityId,
                          // nextActivityId: nextActivityId,
                        );
    }
  }
}