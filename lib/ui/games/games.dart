import 'package:flutter/material.dart';

class Games extends StatelessWidget{
  const Games({super.key});

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Escolha de Jogos"),
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
              child: Text("Tela de Escolha de Jogos"),
            )
          ],
        ),
      )
    );
  }
}