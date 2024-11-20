import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SelectedFrame extends StatelessWidget {
  final BuildContext parentContext;
  final Widget nextPage;
  final marginVal = 30.0;

  final double textSize;
  final String title;
  final String svgs;
  final double svgSize;

  final Color backgroundColor;

  const SelectedFrame({
    super.key,
    required this.parentContext,
    required this.nextPage,
    required this.title,
    required this.svgs,
    double? textSize,
    required this.backgroundColor,
    double? svgSize,
  }) : textSize = textSize ?? 28.0, svgSize = svgSize ?? 44; // Set default value to 28.0 if null
  @override
  Widget build(BuildContext parentContext) {

    Color yellowColor  = const Color(0xFFFFFE75);
    Color yellowStrong = const Color(0xFFFAFF00);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          parentContext,
          MaterialPageRoute(builder: (context) => nextPage),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: yellowStrong, width: 5),
            bottom: BorderSide(color: yellowStrong, width: 5),
            left: BorderSide(color: yellowStrong, width: 3),
            right: BorderSide(color: yellowStrong, width: 3),
          ),
          borderRadius: BorderRadius.circular(35),
          color: backgroundColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(1), // Shadow color
              spreadRadius: 0, // How much the shadow spreads
              blurRadius: 10, // Blur effect
              offset: const Offset(0, 0), // Position of the shadow (x, y)
            ),
          ],
        ),
        height: 160,
        width: 160,
        margin: EdgeInsets.only(
          left: marginVal,
          right: marginVal,
          bottom: marginVal,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                // Stroke (Outlined text)
                Text(
                  title,
                  style: TextStyle(
                    fontSize: textSize,
                    fontFamily: 'Playpen-Sans',
                    fontWeight: FontWeight.bold,
                    foreground: Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 5
                      ..color = Colors.black, // Outline color
                  ),
                  textAlign: TextAlign.center,
                ),
                // Main Text
                Text(
                  title,
                  style: TextStyle(
                    color: yellowColor, // Main text color
                    fontSize: textSize,
                    fontFamily: 'Playpen-Sans',
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            SvgPicture.asset(
              // 'assets/imgs/apartment.svg',
              svgs,
              width: svgSize,
              height: svgSize,
            ),
          ],
        ),
      ),
    );
  }
}
