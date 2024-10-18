import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../custom_widgets/return_button.dart';

class Report extends StatelessWidget {
  const Report({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: SvgPicture.asset(
              "assets/imgs/background.svg",
              // Update with your SVG path
              fit: BoxFit.cover, // Same as the fit you used for PNG
            ),
          ),
          Column(
            children: [
              Row(children: [ReturnButton(parentContext: context)]),
              const Center(
                child: Text("Tela de Relatórios"),
              )
            ],
          )
        ],
      ),
    );
  }
}
