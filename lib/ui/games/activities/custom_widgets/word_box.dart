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
    return ClipRRect(
      borderRadius: BorderRadius.circular(15.0),
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: const BoxDecoration(
          color: Color(0xFFD1E9F6),
        ),
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
    );
  }
}
