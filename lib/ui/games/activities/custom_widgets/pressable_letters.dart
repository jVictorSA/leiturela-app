import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

void _playSounds(String sound) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  int? volumePref = _prefs.getInt('efeitos');
  double volume = (volumePref ?? 5).toDouble() / 10; // Default to 5 if null

  final AudioPlayer soundPlayer = AudioPlayer();

  try {
    await soundPlayer.setVolume(volume);
    await soundPlayer.play(AssetSource('audio/sound_effects/$sound')); // Play each sound
    await soundPlayer.onPlayerComplete.first; // Wait until the current sound finishes
  } finally {
    soundPlayer.dispose(); // Dispose of the player after sound finishes
  }
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
      solved
          ? null // Disable onTap if solved is true
          : () {
        if (widget.isAnswer == true) {

          widget.onTap(); // Actually invoke the parent's callback function
        } else {
          _playSounds("wrong_sound.wav");
        }
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
