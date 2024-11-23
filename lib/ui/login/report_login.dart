import 'dart:async';

import 'package:demo_app/ui/report/report.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/services.dart';
import '../custom_widgets/custom_button.dart';
import '../custom_widgets/return_button.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; 
import 'package:shared_preferences/shared_preferences.dart';
class ReportLogin extends StatefulWidget {
  const ReportLogin({super.key});

  @override
  _ReportLoginState createState() => _ReportLoginState();
}

class _ReportLoginState extends State<ReportLogin> {
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();

  bool _showFirstFrame = true; // Toggle between frames
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(milliseconds: 500), (timer) {
      setState(() {
        _showFirstFrame = !_showFirstFrame;
      });
    });
  }

  @override
  void dispose() {
    // Optional: Stop music if you want to stop it when navigating away.
    // _audioManager.stopMusic();
    _timer.cancel();
    super.dispose();
  }



  Future<void> _login() async {
    String email = controllerEmail.text;
    String password = controllerPassword.text;

    try {
      const url = 'http://10.0.2.2:8000/user/login';

      var response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );
    
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        String token = data['access_token'];
        String userId = data['user_id'];

        SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('auth_token', token);
          await prefs.setString('user_id', userId);

        print('Login realizado com sucesso: ${data}');
        print('toke, ${token}');
        print('id user, ${userId}');
        
        Navigator.pushReplacement(
          context,
           MaterialPageRoute(builder: (context) => const Report()),
        );
      } else {
        print('Erro: ${response.body}');
        _showErrorDialog('Erro no login. Verifique suas credenciais.');
      }
    } catch (e) {
      print('Erro: $e');
      _showErrorDialog('Erro na conexão com o servidor.');
    }
  }

  // Função para mostrar o diálogo de erro
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Erro'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: SvgPicture.asset(
              _showFirstFrame ? "assets/imgs/backgrounds/login_1.svg" : 'assets/imgs/backgrounds/login_2.svg',
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
              const Spacer(
                flex: 4,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                // Align children to the left
                children: [
                  const Spacer(
                    flex: 1,
                  ),
                  const Text(
                    "Login",
                    style: TextStyle(
                        fontSize: 35,
                        fontFamily: 'Playpen-Sans',
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                  const Spacer(
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
                      obscureText: true,
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
                  const Spacer(),
                  CustomButton(
                    label: 'Entrar',
                    onPressed: _login,
                  ),
                  const Spacer(),
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
