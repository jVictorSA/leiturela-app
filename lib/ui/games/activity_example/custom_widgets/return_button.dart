import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReturnButton extends StatelessWidget {
  const ReturnButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15.0),
      child: ElevatedButton(
        onPressed: null,
        // It currently does nothing, but it should go back a screen
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero, // Remove any padding around the button
        ),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(15.0),
            border: Border.all(
                color: const Color(0xFF000000),
                width: 2), // Stroke color and width
            color: const Color(0xFFEAEAEA),
          ),
          child: const SizedBox(
            width: 68,
            height: 34,
            child: Center(
              child: Icon(
                Icons.keyboard_return_rounded, // Replace with your desired icon
                color: Colors.black, // Change icon color as needed
                size: 30,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
