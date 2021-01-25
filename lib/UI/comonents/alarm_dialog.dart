import 'package:alarm/UI/comonents/audio_player.dart';
import 'package:flutter/material.dart';

showAlarmDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text("Stop alarm"),
          actions: <Widget>[
            FlatButton(
                child: Text("Stop"),
                onPressed: () {
                  Audio().player.stop();
                }),
          ],
        );
      });
}
