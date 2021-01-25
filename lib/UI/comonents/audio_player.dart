import 'package:alarm/UI/comonents/alarm_dialog.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class Audio {
  static final Audio _singleton = Audio._internal();
  AudioPlayer player = AudioPlayer();
  AudioCache cache;

  factory Audio() {
    _singleton.cache = AudioCache(fixedPlayer: _singleton.player);
    return _singleton;
  }

  playDefaultAlarm() {
    _singleton.cache.play('alarm.mp3');
  }

  listenAudio(BuildContext context) {
    _singleton.player.onPlayerStateChanged.listen((s) {
      if (s == AudioPlayerState.PLAYING) {
        showAlarmDialog(context);
      } else if (s == AudioPlayerState.STOPPED) {
        Navigator.pop(context);
      }
    }, onError: (msg) {
      print(msg);
    });
  }

  Audio._internal();
}
