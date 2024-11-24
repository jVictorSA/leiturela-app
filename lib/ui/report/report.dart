import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import '../custom_widgets/return_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:demo_app/ui/login/login_screen.dart';
import 'package:demo_app/ui/login/report_login.dart';
class Report extends StatefulWidget {
  const Report({super.key});

  static Color firstColor = Colors.green;
  static Color secondColor = Colors.purple;
  static Color thirdColor = Colors.deepOrange;
  static Color forthColor = Colors.lightBlue;

  static double sizedBoxSize = 16;

  @override
  State<Report> createState() => _ReportState();
}

class _ReportState extends State<Report> {
  int numAtv = 0;
  double meanNumAtv = 0.0;
  int timeAtv = 0;
  double meanTimeAtv = 0.0;

  @override
  void initState() {
    super.initState();
    _fetchReport();
  }
  void _showCustomDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Importante', style: TextStyle(fontWeight: FontWeight.bold)),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Fecha o popup
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const Login()),
                );
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
    }


  Future<void> _fetchReport() async {
    const url = "http://10.0.2.2:8000/atividade/relatorio";

    try {

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('auth_token');
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': token ?? '',
          'Content-Type': 'application/json',
          // 'User-Id': userId,
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          numAtv = data['entregas'] ?? 0;
          timeAtv = data['total_time']?.toInt() ?? 0;
          meanNumAtv = data['entregas'] > 0 ? data['total_time'] / data['entregas'] : 0.0;
          meanTimeAtv = numAtv > 0 ? timeAtv / numAtv : 0.0;
        });
      } else {
         _showCustomDialog("Precisa fazer login para acessar o relatório");

      }
    } catch (e) {
      _showError("Erro na conexão: $e");
    }
  }

  void _showError(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Erro"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      Positioned.fill(
        child: SvgPicture.asset(
          "assets/imgs/backgrounds/background.svg",
          fit: BoxFit.cover,
        ),
      ),
      Column(
        children: [
          Row(children: [ReturnButton(parentContext: context)]),
          const Center(
            child: Text(
              "Relatórios",
              textAlign: TextAlign.right,
              style: TextStyle(
                fontFamily: 'Playpen-Sans',
                fontWeight: FontWeight.w500,
                fontSize: 40,
              ),
            ),
          ),
          const Spacer(flex: 1),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(width: 8),
              Column(
                children: [
                  Icon(Icons.book, color: Report.firstColor),
                  SizedBox(height: Report.sizedBoxSize),
                  Icon(Icons.library_books, color: Report.secondColor),
                  SizedBox(height: Report.sizedBoxSize),
                  Icon(Icons.access_time_filled, color: Report.thirdColor),
                  SizedBox(height: Report.sizedBoxSize),
                  Icon(Icons.timer, color: Report.forthColor),
                ],
              ),
              Column(
                children: [
                  Text(
                    "Atividades Concluídas:",
                    style: TextStyle(
                        fontFamily: 'Playpen-Sans',
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: Report.firstColor),
                  ),
                  SizedBox(height: Report.sizedBoxSize),
                  Text(
                    "Média de Atividades Concluídas:",
                    style: TextStyle(
                        fontFamily: 'Playpen-Sans',
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: Report.secondColor),
                  ),
                  SizedBox(height: Report.sizedBoxSize),
                  Text(
                    "Tempo em Atividades:",
                    style: TextStyle(
                        fontFamily: 'Playpen-Sans',
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: Report.thirdColor),
                  ),
                  SizedBox(height: Report.sizedBoxSize),
                  Text(
                    "Tempo Médio em Atividades:",
                    style: TextStyle(
                        fontFamily: 'Playpen-Sans',
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: Report.forthColor),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    // numAtv.toString(),
                    '$numAtv',
                    style: TextStyle(
                        fontFamily: 'Playpen-Sans',
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: Report.firstColor),
                  ),
                  SizedBox(height: Report.sizedBoxSize),
                  Text(
                    // meanNumAtv.toString(),
                    '$meanNumAtv',
                    style: TextStyle(
                        fontFamily: 'Playpen-Sans',
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: Report.secondColor),
                  ),
                  SizedBox(height: Report.sizedBoxSize),
                  Text(
                    // timeAtv.toString(),
                    '$timeAtv',
                    style: TextStyle(
                        fontFamily: 'Playpen-Sans',
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: Report.thirdColor),
                  ),
                  SizedBox(height: Report.sizedBoxSize),
                  Text(
                    // meanTimeAtv.toString(),
                    '${meanTimeAtv.toStringAsFixed(2)}',
                    style: TextStyle(
                        fontFamily: 'Playpen-Sans',
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: Report.forthColor),
                  ),
                ],
              ),
              const SizedBox(width: 8),
            ],
          ),
          const Spacer(flex: 3),
        ],
      ),
    ]));
  }
}
