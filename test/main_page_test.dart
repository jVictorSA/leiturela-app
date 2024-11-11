// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:demo_app/ui/games/story_games_screen.dart';
import 'package:demo_app/ui/report/report.dart';
import 'package:demo_app/ui/settings/settings.dart';
import 'package:demo_app/ui/custom_widgets/selected_frame.dart';
import 'package:demo_app/ui/custom_widgets/return_button.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:demo_app/main.dart';

void main() {
  testWidgets('Test elements of main page', (tester) async {    
    const main =  MyApp();
    await tester.pumpWidget(main);

    expect(find.text('Leiturela'), findsOneWidget);
    expect(find.text('Jogar'), findsOneWidget);
    expect(find.byType(ElevatedButton), findsExactly(2));
    expect(find.byType(OutlinedButton), findsOneWidget);
  });

  testWidgets('Test navigation from the Main page to Games page', (tester) async {    
    const main =  MyApp();
    await tester.pumpWidget(main);

    await tester.tap(find.byType(OutlinedButton));
    await tester.pumpAndSettle();
    
    expect(find.byType(SelectedFrame), findsExactly(2));
    expect(find.byType(Games), findsOneWidget);
  });

  testWidgets('Navigates to correct page based on button tap', (WidgetTester tester) async {    
    const main =  MyApp();
    await tester.pumpWidget(main);
    final button1 = find.byType(ElevatedButton).at(0);

    // Go to Setting page
    await tester.tap(button1);
    await tester.pumpAndSettle();
    expect(find.byType(Settings), findsOneWidget);
    
    // Returns to the main page
    Finder returnButton = find.byType(ReturnButton);
    expect(returnButton, findsOneWidget);
    await tester.tap(returnButton);
    await tester.pumpAndSettle();
    expect(find.text('Leiturela'), findsOneWidget);
    expect(find.text('Jogar'), findsOneWidget);
    expect(find.byType(ElevatedButton), findsExactly(2));
    expect(find.byType(OutlinedButton), findsOneWidget);

    // Go to Reports page
    await tester.pumpWidget(const MaterialApp(home: MyApp()));
    final button2 = find.byType(ElevatedButton).at(1);
    await tester.tap(button2);
    await tester.pumpAndSettle();
    expect(find.byType(Report), findsOneWidget);
    
    // Returns to the main page
    returnButton = find.byType(ReturnButton);
    expect(returnButton, findsOneWidget);
    await tester.tap(returnButton);
    await tester.pumpAndSettle();
    expect(find.text('Leiturela'), findsOneWidget);
    expect(find.text('Jogar'), findsOneWidget);
    expect(find.byType(ElevatedButton), findsExactly(2));
    expect(find.byType(OutlinedButton), findsOneWidget);
  });

}


