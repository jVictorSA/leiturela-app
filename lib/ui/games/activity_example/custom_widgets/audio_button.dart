import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AudioButton extends StatelessWidget {
  const AudioButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: null, // Set your desired action here
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero, // Remove any padding around the button
        backgroundColor: Colors.transparent, // Set the background color to transparent
      ),
      child: Container(
        width: 57,
        height: 57,
        color: Colors.transparent, // Ensure the child container is also transparent
        child: const Center(
          child: Icon(
            Icons.audiotrack_rounded, // Replace with your desired icon
            color: Color(0xFF03BFE7), // Change icon color as needed
            size: 57,
          ),
        ),
      ),
    );
  }
}
