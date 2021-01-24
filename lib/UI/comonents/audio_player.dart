import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';

class Audio {
  static final Audio _singleton = Audio._internal();
  AudioPlayer player;
  AudioCache cache;

  factory Audio() {
    _singleton.player = AudioPlayer();
    _singleton.cache = AudioCache(fixedPlayer: _singleton.player);
    return _singleton;
  }

  Audio._internal();
}
