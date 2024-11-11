import 'package:flutter/material.dart';
import 'package:demo_app/ui/games/story_games_screen.dart';
import 'package:demo_app/ui/minigames/minigames.dart';
import 'package:demo_app/ui/custom_widgets/selected_frame.dart';
import 'package:demo_app/ui/custom_widgets/return_button.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:demo_app/main.dart';
import 'package:demo_app/ui/games/activities/drag_crossword.dart';

void main() {
  
  testWidgets('Test elements of Minigames page', (tester) async {
    const main =  Minigames();
    await tester.pumpWidget(const MaterialApp(home: main));
        
    expect(find.byType(Minigames), findsOneWidget);
    expect(find.byType(SelectedFrame), findsAtLeast(2));

    expect(find.text('Montar Palavra'), findsExactly(2));
    expect(find.text('Contar Letras'), findsExactly(2));
  });

  testWidgets('Navigates to Minigames page based on button tap', (WidgetTester tester) async {    
    const main =  Games();
    await tester.pumpWidget(const MaterialApp(home: main));


    // Go to Minigames page    
    final button1 = find.byType(SelectedFrame).at(1);
    await tester.tap(button1);
    await tester.pumpAndSettle();
    expect(find.byType(Minigames), findsOneWidget);

    // Returns to the Games page
    Finder returnButton = find.byType(ReturnButton);
    expect(returnButton, findsOneWidget);
    await tester.tap(returnButton);
    await tester.pumpAndSettle();
    expect(find.byType(Games), findsOneWidget);
    expect(find.byType(SelectedFrame), findsExactly(2));
  });

  // Precisa testar com o emulador pra pegar
  testWidgets('Navigates to one of the Minigames listed', (WidgetTester tester) async {    
    const main =  Minigames();
    await tester.pumpWidget(const MaterialApp(home: main));

    final button1 = find.byType(SelectedFrame).at(0);
    await tester.tap(button1);
    await tester.pumpAndSettle();
    expect(find.byType(DragSyllables), findsOneWidget);
  });
}