import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LetterBox extends StatelessWidget {
  final String text; // The letter this box represents
  final double borderRadius; // The border radius of the box
  final double width; // The width of the box
  List<Color> colors;
  Color boxShadowColor;
  Color fontColor;

  LetterBox({
    super.key,
    required this.text,
    required this.borderRadius,
    required this.width,
    this.colors = const [Color(0xFFFFF3B8), Color(0xFFF7FB31), Color(0xFFFBB631)],
    this.boxShadowColor = const Color(0xFFFBB631),
    this.fontColor = Colors.black
  });

  @override
  Widget build(BuildContext context) {
    return Draggable<String>(
      data: text,
      // Pass the letter as the draggable data
      feedback: _buildLetterBox(isDragging: true),
      // What is shown while dragging
      childWhenDragging:
          _buildLetterBox(isDragging: false, isPlaceholder: true),
      // Placeholder during dragging
      child: _buildLetterBox(isDragging: false),
      // The normal display of the letter box
    );
  }

  // Builds the letter box UI with options for dragging and placeholder states
  Widget _buildLetterBox(
      {required bool isDragging, bool isPlaceholder = false}) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: isPlaceholder
                ? Colors.transparent
                : boxShadowColor.withOpacity(1), // Shadow color
            spreadRadius: 0, // How much the shadow spreads
            blurRadius: 15, // How soft the shadow appears
            offset: const Offset(0, 0), // Offset for the shadow (x, y)
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            colors: colors,
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            stops: const [0, 0.25, 1.0],
          ).createShader(bounds),
          child: Container(
            width: width,
            height: 43,
            color: isPlaceholder ? Colors.transparent : Colors.white,
            // Make placeholder transparent
            child: Center(
              child: isPlaceholder
                  ? null
                  : Text(
                      text,
                      style: GoogleFonts.playpenSans(
                        color: fontColor,
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}

class StaticLetterBox extends StatelessWidget {
  final String text; // The letter this box represents
  final double borderRadius; // The border radius of the box
  final double width; // The width of the box
  final List<Color> colors;
  final Color boxShadowColor;

  StaticLetterBox({
    super.key,
    required this.text,
    this.borderRadius = 15.0,
    this.width = 67.0,
    List<Color>? colors, // Accept null values here
    this.boxShadowColor = const Color(0xFFFBB631),
  }) : colors = colors ?? const [Color(0xFFFFF3B8), Color(0xFFF7FB31), Color(0xFFFBB631)];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
             color: boxShadowColor.withOpacity(0.2), // Shadow color
             spreadRadius: 0, // How much the shadow spreads
             blurRadius: 15, // How soft the shadow appears
             offset: const Offset(0, 0), // Offset for the shadow (x, y)
           ),
         ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        // child:
          // ShaderMask(
          //  shaderCallback: (bounds) => LinearGradient(
          //    colors: colors,
          //    begin: Alignment.topRight,
          //    end: Alignment.bottomLeft,
          //    stops: const [0, 0.25, 1.0],
          //  ).createShader(bounds),
           child: Container(
            width: width,
            height: 43,
            // color: Colors.white,
            // ake placeholder transparent
            child: Center(
              child: Text(
                text,
                style: GoogleFonts.playpenSans(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      //  ),
    );
  }
}
