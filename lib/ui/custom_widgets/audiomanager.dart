import 'package:audioplayers/audioplayers.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

    SharedPreferences _prefs = await SharedPreferences.getInstance();
    int? volumePref = _prefs.getInt('music');
    double volume = ((volumePref ?? 5) / 10).clamp(0.0, 1.0) * 0.3; // Default to 5 if null

    await _audioPlayer.setVolume(volume);
    await _audioPlayer.setReleaseMode(ReleaseMode.loop); // Loop the background music
    await _audioPlayer.play(AssetSource('audio/background_music/main.mp3')); // Ensure path matches your asset setup
  }

  Future<void> updateVolume() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    int? volumePrefMusic = _prefs.getInt('music');
    double volume = ((volumePrefMusic ?? 5) / 10).clamp(0.0, 1.0) * 0.3;
    await _audioPlayer.setVolume(volume);
  }

  void stopMusic() {
    _audioPlayer.stop();
  }

  void dispose() {
    _audioPlayer.dispose();
  }
}