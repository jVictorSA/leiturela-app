import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/services.dart';

import '../custom_widgets/custom_button.dart';
import '../custom_widgets/return_button.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  TextEditingController controllerPasswordRepeat = TextEditingController();

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
                crossAxisAlignment: CrossAxisAlignment.start,
                // Ensure left alignment
                children: [
                  ReturnButton(parentContext: context),
                ],
              ),
              Spacer(
                flex: 4,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                // Align children to the left
                children: [
                  Spacer(
                    flex: 1,
                  ),
                  const Text(
                    "Cadastro",
                    style: TextStyle(
                        fontSize: 35,
                        fontFamily: 'Playpen-Sans',
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                  Spacer(
                    flex: 1,
                  ),
                  const Text(
                    "E-mail",
                    style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'Playpen-Sans',
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                      height: 40,
                      width: 450,
                      decoration: BoxDecoration(
                        color: const Color(0xFFD1E9F6),
                        border: Border.all(color: const Color(0xFF03BFE7)),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: TextField(
                        controller: controllerEmail,
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 16.0),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.singleLineFormatter,
                        ],
                      )),
                  const Spacer(flex: 1,),
                  const Text(
                    "Senha",
                    style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'Playpen-Sans',
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    height: 40,
                    width: 450,
                    decoration: BoxDecoration(
                      color: const Color(0xFFD1E9F6),
                      border: Border.all(color: const Color(0xFF03BFE7)),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: TextField(
                      controller: controllerPassword,
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 16.0),
                      ),
                      keyboardType: TextInputType.visiblePassword,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.singleLineFormatter,
                      ],
                    ),
                  ),
                  const Spacer(flex: 1,),
                  const Text(
                    "Repita a Senha",
                    style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'Playpen-Sans',
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    height: 40,
                    width: 450,
                    decoration: BoxDecoration(
                      color: const Color(0xFFD1E9F6),
                      border: Border.all(color: const Color(0xFF03BFE7)),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: TextField(
                      controller: controllerPasswordRepeat,
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 16.0),
                      ),
                      keyboardType: TextInputType.visiblePassword,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.singleLineFormatter,
                      ],
                    ),
                  ),
                  const Spacer(flex: 1,),
                  CustomButton(
                    label: 'Enviar',
                    onPressed: () {},
                  ),
                  const Spacer(flex: 1,),
                ],
              ),
              const Spacer(
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
