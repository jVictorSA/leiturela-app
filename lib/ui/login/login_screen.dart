import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/services.dart';

import '../custom_widgets/custom_button.dart';
import '../custom_widgets/return_button.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: SvgPicture.asset(
              "assets/imgs/background.svg",
              fit: BoxFit.cover,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start, // Ensure left alignment
                children: [
                  ReturnButton(parentContext: context),
                ],
              ),
              Spacer(
                flex: 4,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start, // Align children to the left
                children: [
                  Spacer(flex: 2,),
                  const Text(
                    "E-mail",
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Playpen-Sans',
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: 8,),
                  Container(
                      height: 56.0,
                      width: 450,
                      decoration: BoxDecoration(
                        color: const Color(0xFFD1E9F6),
                        border: Border.all(
                            color: const Color(0xFF03BFE7)),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: TextField(
                        controller: controllerEmail,
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          contentPadding:
                          EdgeInsets.symmetric(vertical: 16.0),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.singleLineFormatter,
                        ],
                      )),
                  Spacer(),
                  const Text(
                    "Senha",
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Playpen-Sans',
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: 8,),
                  Container(
                      height: 56.0,
                      width: 450,
                      decoration: BoxDecoration(
                        color: const Color(0xFFD1E9F6),
                        border: Border.all(
                            color: const Color(0xFF03BFE7)),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: TextField(
                        controller: controllerPassword,
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          contentPadding:
                          EdgeInsets.symmetric(vertical: 16.0),
                        ),
                        keyboardType: TextInputType.visiblePassword,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.singleLineFormatter,
                        ],
                      )),
                  Spacer(),
                  CustomButton(label: 'Enviar', onPressed: () {  },),
                  Spacer(),
                ],
              ),
              Spacer(
                flex: 5,
              ),
              const SizedBox(
                width: 80,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
