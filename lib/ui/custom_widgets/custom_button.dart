import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final double width;
  final double height;
  final Color colorStart;
  final Color colorEnd;
  final Color letterColor;
  final bool hasStroke;
  final Color strokeColor;

  const CustomButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.width = 120.0,  // Default width
    this.height = 56.0,  // Default height
    this.colorStart = const Color(0xff03BFE7),
    this.colorEnd = const Color(0xff01419F),
    this.letterColor = Colors.white,
    this.hasStroke = false, // Default to no stroke
    this.strokeColor = const Color(0xff1578b9), // Default stroke color
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: const [0.5, 0.9],
          colors: [
            colorStart,
            colorEnd,
          ],
        ),
        borderRadius: BorderRadius.circular(30),
        border: hasStroke ? Border.all(color: strokeColor, width: 2.0) : null, // Add stroke conditionally
      ),
      child: OutlinedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          side: hasStroke ? MaterialStateProperty.all(BorderSide.none) : null, // Removes the border
          backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
          shadowColor: MaterialStateProperty.all<Color>(Colors.transparent),
          padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.zero),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontFamily: 'Playpen-Sans',
              fontWeight: FontWeight.w400,
              fontSize: 24,
              color: letterColor,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
