import 'package:http/http.dart' as http;
import 'dart:convert';// show utf8;

String token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY3M2QyMTkyYjE5Y2M2ZWIwMjc5YWNhMiIsImV4cCI6MTczMjE0NTk0NX0.n9725w1hjSrN3yqt9KX1H_cgO8hqzEmqB1C8rNTmpwE";

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

Future<String> fetchStory(id) async {
  var response = await http.get(Uri.parse('http://10.0.2.2:8000/atividade/story:$id'), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': token,
    });
  print("fetch story id: " + id);  

  if (response.statusCode == 200) {
  var decoded = utf8.decode(response.bodyBytes);

    return decoded.toString();
  }
  return response.body;
}

Future<String> fetchNextActivity(storyId, curentSubstory) async {
  var response = await http.get(Uri.parse('http://10.0.2.2:8000/atividade/story:$storyId'), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': token,
    });

  if (response.statusCode == 200) {
    var decoded = utf8.decode(response.bodyBytes);  
    
    String entireObject;        
      
    entireObject = decoded.toString();
    Map subStories = json.decode(entireObject);    
    String nextActivityId = subStories["activities"][curentSubstory]["_id"];    
    print("ID SHOWSTORY: " +nextActivityId);

    return nextActivityId;
  }
  return response.body;
}

Future<String> fetchActivity(http.Client client, activityId) async {
  var response = await client.get(Uri.parse('http://10.0.2.2:8000/atividade/atividade:$activityId'));  

  if (response.statusCode == 200) {
  var decoded = utf8.decode(response.bodyBytes);  

    return decoded.toString();
  }
  return response.body;
}

Future<String> fetchActivities(http.Client client) async {
  var response = await client.get(Uri.parse('http://10.0.2.2:8000/atividade/atividades'));  

  if (response.statusCode == 200) {
  var decoded = utf8.decode(response.bodyBytes);  

    return decoded.toString();
  }
  return response.body;
}