import 'package:flutter/material.dart';
import '../custom_widgets/return_button.dart';

class Settings extends StatelessWidget{
  const Settings({super.key});

  @override
  Widget build(BuildContext context){
    return  Scaffold(        
        body: Column(
          children: [
            Row(children: 
              [ReturnButton(parentContext: context)]
            ),
            const Center(
              child: Text("Tela de Configuração"),
            )
          ],
        ),
      );
  }
}