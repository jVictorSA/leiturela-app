import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LetterBox extends StatelessWidget {
  final String text; // The letter this box represents

  const LetterBox({
    super.key,
    required this.text,
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
    return ClipRRect(
      borderRadius: BorderRadius.circular(15.0),
      child: ShaderMask(
        shaderCallback: (bounds) => const LinearGradient(
          colors: [Color(0xFFF7FB31), Color(0xFFFBB631)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.22, 1.0],
        ).createShader(bounds),
        child: Container(
          width: 67,
          height: 43,
          color: isPlaceholder ? Colors.transparent : Colors.white,
          // Make placeholder transparent
          child: Center(
            child: isPlaceholder
                ? null
                : Text(
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
    );
  }
}

class StaticLetterBox extends StatelessWidget {
  final String text; // The letter this box represents

  const StaticLetterBox({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15.0),
      child: ShaderMask(
        shaderCallback: (bounds) => const LinearGradient(
          colors: [Color(0xFFF7FB31), Color(0xFFFBB631)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.22, 1.0],
        ).createShader(bounds),
        child: Container(
          width: 67,
          height: 43,
          color: Colors.white,
          // Make placeholder transparent
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
    );
  }
}
