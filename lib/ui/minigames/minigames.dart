import 'package:flutter/material.dart';
import '../custom_widgets/return_button.dart';
import '../games/activity_example/activity_example.dart';

class Minigames extends StatelessWidget {
  const Minigames({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/imgs/background.png"),
            fit: BoxFit.contain,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              child: ReturnButton(parentContext: context),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ActivityExampleApp()),
                  );
                },
                child: const Text("Mini game"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
