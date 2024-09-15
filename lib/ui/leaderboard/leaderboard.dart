import 'package:flutter/material.dart';

class Leaderboard extends StatelessWidget{
  const Leaderboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Ranking"),
          leading: IconButton(
          icon: Icon(Icons.arrow_back,
                    color: Colors.black
                    ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        ) ,
        body: Column(
          children: [
            Center(
              child: Text("Tela de Ranking"),
            )
          ],
        ),
      )
    );
  }
}