import 'package:flutter/material.dart';

class ActivityBackground extends StatelessWidget {
  final Widget
      child; // Child widget to be displayed inside the gradient background

  const ActivityBackground({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: RadialGradient(
          colors: [
            Color(0xFF8ADCFA), // Inner color
            Color(0xFF0C7FD1), // Outer color
          ],
          radius: 1.25,
          center: Alignment.center,
          stops: [0.1, 1],
        ),
      ),
      child: child, // Display the child widget
    );
  }
}
