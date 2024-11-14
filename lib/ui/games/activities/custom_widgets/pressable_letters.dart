import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PressableLetters extends StatefulWidget {
  final VoidCallback onTap;
  final String letterText; // The letter
  final bool isAnswer; // Is this part of the answer

  const PressableLetters({
    super.key,
    required this.letterText,
    required this.isAnswer,
    required this.onTap,
  });

  @override
  _PressableLettersState createState() => _PressableLettersState();
}

class _PressableLettersState extends State<PressableLetters> {
  bool solved = false; // Moved to the state class

  @override
  Widget build(BuildContext context) {
    Color currentColor = Colors.black;
    Color correctColor = Color(0xFF21D304);
    Color incorrectColor = Color(0xFFA90C0C);

    return GestureDetector(
      onTap: () {
        if (widget.isAnswer == true) {
          widget.onTap(); // Actually invoke the parent's callback function
        }
      solved
          ? null // Disable onTap if solved is true
          : () {
        setState(() {
          solved = true;
        });
      }();
    },
      child: Text(
        widget.letterText,
        style: GoogleFonts.playpenSans(
          color: solved
              ? widget.isAnswer
                  ? correctColor
                  : incorrectColor
              : currentColor,
          fontSize: 35,
          fontWeight: FontWeight.w600,
          shadows: [
            const Shadow(
              offset: Offset(2, 2), // Position of shadow
              blurRadius: 4, // Softness of shadow
              color: Colors.black38, // Shadow color
            ),
          ],
        ),
      ),
    );
  }
}
