import 'package:demo_app/ui/games/activities/count_letters.dart';
import 'package:demo_app/ui/games/activities/build_letter.dart';
import 'package:demo_app/ui/games/activities/complete_word.dart';
import 'package:demo_app/ui/games/activities/mark_the_word.dart';
import 'package:demo_app/ui/games/activities/image_association.dart';
import 'package:demo_app/ui/games/activities/count_letters_by_sound.dart';
import 'package:demo_app/ui/games/activities/drag_crossword.dart';
import 'package:demo_app/ui/games/activities/press_letter.dart';
import 'package:demo_app/ui/games/activities/abc_press_letters.dart';
import 'package:demo_app/ui/games/activities/select_word_by_audio.dart';
import 'package:demo_app/ui/games/activities/sound_letters_association.dart';
import 'package:demo_app/ui/games/activities/upper_and_lowercase.dart';
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
    if (activityType == "count_letters"){
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
    
    else if(activityType == "mark_the_word"){
      return PressSyllable(subStoryId: subStoryId,
                           storyId: storyId,
                           activityId: nextActivityId);
    }

    else if(activityType == "abc_press_letters"){
      return ABCPressLetter(subStoryId: subStoryId,
                            storyId: storyId,
                            activityId: nextActivityId);
    }
    else if(activityType == "press_letter"){
      return PressLetter(subStoryId: subStoryId,
                            storyId: storyId,
                            activityId: nextActivityId);
    }
    else if(activityType == "drag_crossword"){
      return DragSyllables(subStoryId: subStoryId,
                            storyId: storyId,
                            activityId: nextActivityId);
    }
    else if(activityType == "upper_and_lowercase"){
      return UpperLower(subStoryId: subStoryId,
                            storyId: storyId,
                            activityId: nextActivityId);
    }
    else if(activityType == "select_word_by_audio"){
      return SelectWordAudio(subStoryId: subStoryId,
                            storyId: storyId,
                            activityId: nextActivityId);
    }
    else if(activityType == "image_association"){      
      return ImageAssociation(subStoryId: subStoryId,
                                storyId: storyId,
                                activityId: nextActivityId);
    }
    else if(activityType == "count_letter_by_sound"){
      return CountLettersBySound(subStoryId: subStoryId,
                                storyId: storyId,
                                activityId: nextActivityId);
    }
    else if(activityType == "sound_letters_association"){
      return SoundLettersAssociation(subStoryId: subStoryId,
                                    storyId: storyId,
                                    activityId: nextActivityId);
    }
    

    // Caso base apenas para não dar erro de Null-Safety
    else{
      return Container();
    }
  }
}