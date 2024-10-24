import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WordBox extends StatelessWidget {
  final List<String> text; // The letter this box represents
  final List<bool> correctText; // List of booleans for color decision

  const WordBox({
    super.key,
    required this.text,
    required this.correctText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.35), // Shadow color
            spreadRadius: 0, // How much the shadow spreads
            blurRadius: 10, // How soft the shadow appears
            offset: const Offset(0, 5), // Offset for the shadow (x, y)
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [Color(0xFFDDDDDD), Color(0xFFBCBCBC), Color(0xFF979797)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.25, 0.75, 1.0],
          ).createShader(bounds),
          child: Container(
            padding: const EdgeInsets.all(4),
            color: Colors.white,
            // Background color
            width: 137,
            height: 128,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(text.length, (index) {
                  return Text(
                    text[index],
                    style: GoogleFonts.playpenSans(
                      // Change colors based on the boolean
                      color: correctText[index] ? Colors.green : Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                    ),
                  );
                }),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
