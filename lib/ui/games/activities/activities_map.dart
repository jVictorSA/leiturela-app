import 'package:demo_app/ui//games/activities/count_letters.dart';
import 'package:flutter/material.dart';


class GetActivities{
  int subStoryId;
  String storyId;
  // String activityId;
  String nextActivityId;
  // String activityType;


  GetActivities(this.subStoryId,
                this.storyId,
                // this.activityId,
                this.nextActivityId,
                // this.activityType
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
    //else if(activityType == "desembaralha_palavra"){
    // }
      
    //else if(activityType == "desembaralha_palavra"){
    // }
    
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