import 'package:http/http.dart' as http;
import 'dart:convert';// show utf8;
import 'package:shared_preferences/shared_preferences.dart';

// SharedPreferences prefs = await SharedPreferences.getInstance();
// String tok = await prefs.getString('auth_token', token);

// String token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY3M2QyMTkyYjE5Y2M2ZWIwMjc5YWNhMiIsImV4cCI6MTczMjUyNDA1MH0.kn0hadPT4IlaYZLXj-dkR2d_bTrYQsmSTaZ2ylPrV50";
String url = "https://leiturela-api-pedrovictor48-pedrovictor48s-projects.vercel.app";

String tok = '';
_loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // setState(() {
      tok = (prefs.getString('auth_token') ?? '');
    // });
  }

Future<String> fetchStories(http.Client client) async {
  // _loadCounter();

  var response = await client.get(Uri.parse('$url/atividade/stories'));
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
  print("init await");
  await _loadCounter();
  print("finish await");
  print("Token = " + tok);
  var response = await http.get(Uri.parse('$url/atividade/story:$id'), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': tok,
    });
  print("fetch story id: " + id);  

  if (response.statusCode == 200) {
  var decoded = utf8.decode(response.bodyBytes);

    return decoded.toString();
  }
  return response.body;
}

Future<String> fetchNextActivity(storyId, curentSubstory) async {
  print("init await");
  await _loadCounter();
  print("finish await");
  print("Token = " + tok);
  var response = await http.get(Uri.parse('$url/atividade/story:$storyId'), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': tok,
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
  var response = await client.get(Uri.parse('$url/atividade/atividade:$activityId'));  

  if (response.statusCode == 200) {
  var decoded = utf8.decode(response.bodyBytes);  

    return decoded.toString();
  }
  return response.body;
}

Future<String> fetchActivities(http.Client client) async {
  var response = await client.get(Uri.parse('$url/atividade/atividades'));  

  if (response.statusCode == 200) {
  var decoded = utf8.decode(response.bodyBytes);  

    return decoded.toString();
  }
  return response.body;
}