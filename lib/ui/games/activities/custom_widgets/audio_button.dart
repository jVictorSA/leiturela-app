import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AudioButton extends StatelessWidget {
  final List<String> soundFiles;  // Change to a list of sound files

  AudioButton({
    super.key, required this.soundFiles,
  });

  void _playSounds() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    int? volumePref = _prefs.getInt('efeitos');
    double volume = (volumePref ?? 5).toDouble() / 10; // Default to 5 if null

    // Loop through the list of sound files
    for (var sound in soundFiles) {
      final AudioPlayer soundPlayer = AudioPlayer();

      try {
        await soundPlayer.setVolume(volume);
        await soundPlayer.play(AssetSource('audio/word_sounds/$sound')); // Play each sound
        await soundPlayer.onPlayerComplete.first; // Wait until the current sound finishes
      } finally {
        soundPlayer.dispose(); // Dispose of the player after sound finishes
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: _playSounds,  // Play all sounds when pressed
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        backgroundColor: Colors.transparent,
      ),
      child: SvgPicture.asset(
        'assets/imgs/speaker.svg',
        width: 90,
        height: 66,
      ),
    );
  }
}

