import 'package:audioplayers/audioplayers.dart';

class AudioManager {
  static final AudioManager _instance = AudioManager._internal();
  final AudioPlayer _audioPlayer = AudioPlayer();

  factory AudioManager() {
    return _instance;
  }

  AudioManager._internal();

  AudioPlayer get audioPlayer => _audioPlayer;

  Future<void> playMainMenuMusic() async {
    if (_audioPlayer.state == PlayerState.playing) return; // Check if already playing

    await _audioPlayer.setReleaseMode(ReleaseMode.loop); // Loop the background music
    await _audioPlayer.play(AssetSource('audio/main.mp3')); // Ensure path matches your asset setup
  }

  void stopMusic() {
    _audioPlayer.stop();
  }

  void dispose() {
    _audioPlayer.dispose();
  }
}
