import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AudioButton extends StatelessWidget {
  final AudioPlayer audioPlayer = AudioPlayer();

  AudioButton({
    super.key,
  });

  void _playSound() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    await audioPlayer.setVolume(_prefs.getInt('efeitos')!.toDouble() / 10);
    await audioPlayer.play(
        AssetSource('audio/cabelo.wav')); // Update with your sound file path
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: _playSound, // Set your desired action here
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero, // Remove any padding around the button
        backgroundColor:
            Colors.transparent, // Set the background color to transparent
      ),
      child: SvgPicture.asset(
        'assets/imgs/speaker.svg',
        width: 90,
        height: 66,
      ),
    );
  }
}
