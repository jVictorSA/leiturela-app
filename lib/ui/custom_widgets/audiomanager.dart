import 'package:just_audio/just_audio.dart';

class AudioManager {
  static final AudioManager _instance = AudioManager._internal();
  final AudioPlayer _audioPlayer = AudioPlayer();

  factory AudioManager() {
    return _instance;
  }

  AudioManager._internal();

  AudioPlayer get audioPlayer => _audioPlayer;

  Future<void> playMainMenuMusic() async {
    if (_audioPlayer.playing) return;

    await _audioPlayer.setAudioSource(
      AudioSource.asset('assets/audio/main.mp3'),
    );
    _audioPlayer.setLoopMode(LoopMode.all);
    _audioPlayer.play();
  }

  void stopMusic() {
    _audioPlayer.stop();
  }

  void dispose() {
    _audioPlayer.dispose();
  }
}
