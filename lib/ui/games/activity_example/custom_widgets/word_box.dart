import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WordBox extends StatelessWidget {
  final List<String> text; // The letter this box represents

  const WordBox({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15.0),
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: const Color(0xFFD1E9F6),
        ),
        // Background color
        width: 137,
        height: 128,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: text
                .map(
                  (word) => Text(
                    word,
                    style: GoogleFonts.playpenSans(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
