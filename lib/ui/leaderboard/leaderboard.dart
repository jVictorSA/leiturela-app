import 'package:flutter/material.dart';
import '../custom_widgets/return_button.dart';

class Leaderboard extends StatelessWidget{
  const Leaderboard({super.key});

  @override
  Widget build(BuildContext context){    
      return Scaffold(        
        body: Column(
          children: [
            Row(children: 
              [ReturnButton(parentContext: context)]
            ),
            const Center(
              child: Text("Tela de Ranking"),
            )
          ],        
      )
    );
  }
}