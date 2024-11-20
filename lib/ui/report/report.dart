import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../custom_widgets/return_button.dart';

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
  int numAtv = 40;
  double meanNumAtv = 40.0;
  int timeAtv = 40;
  double meanTimeAtv = 40.0;

  @override
  void initState() {
    super.initState();
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
                    numAtv.toString(),
                    style: TextStyle(
                        fontFamily: 'Playpen-Sans',
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: Report.firstColor),
                  ),
                  SizedBox(height: Report.sizedBoxSize),
                  Text(
                    meanNumAtv.toString(),
                    style: TextStyle(
                        fontFamily: 'Playpen-Sans',
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: Report.secondColor),
                  ),
                  SizedBox(height: Report.sizedBoxSize),
                  Text(
                    timeAtv.toString(),
                    style: TextStyle(
                        fontFamily: 'Playpen-Sans',
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: Report.thirdColor),
                  ),
                  SizedBox(height: Report.sizedBoxSize),
                  Text(
                    meanTimeAtv.toString(),
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
