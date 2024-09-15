import 'package:flutter/material.dart';

class Settings extends StatelessWidget{
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return  MaterialApp(
      debugShowCheckedModeBanner: false,      
      home: Scaffold(
        appBar: AppBar(
          title: Text("Configurações"),
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
              child: Text("Tela de Configuração"),
            )
          ],
        ),
      )
    );
  }
}