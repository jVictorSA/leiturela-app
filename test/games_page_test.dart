// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:demo_app/ui/games/story_games_screen.dart';
// import 'package:demo_app/ui/minigames/minigames.dart';
import 'package:demo_app/ui/stories/stories.dart';
import 'package:demo_app/ui/custom_widgets/selected_frame.dart';
// import 'package:demo_app/ui/custom_widgets/return_button.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:demo_app/main.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import 'package:provider/provider.dart';
import 'dart:io';
// import 'package:my_app/http_service.dart'


// class MockClient extends Mock implements http.Client {}
class MockHttpClient extends Mock implements http.Client {}

void main() {
  testWidgets('Test elements of Games page', (tester) async {    
    const main =  MyApp();
    await tester.pumpWidget(main);

    await tester.tap(find.byType(OutlinedButton));
    await tester.pumpAndSettle();
    
    expect(find.byType(Games), findsOneWidget);
    expect(find.byType(SelectedFrame), findsExactly(2));
  });

  testWidgets('Test navigation from the Games page to Stories and Minigames page', (tester) async {   
    var main =  Games();
    await tester.pumpWidget(MaterialApp(home: main));
    expect(find.byType(Games), findsOneWidget);
    expect(find.byType(SelectedFrame), findsExactly(2));

    final button1 = find.byType(SelectedFrame).at(0);

    // Go to Stories page
    await tester.tap(button1);
    await tester.pumpAndSettle();

    expect(find.byType(Stories), findsOneWidget);
  
  

  });
}


