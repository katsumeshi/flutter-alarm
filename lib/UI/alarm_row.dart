import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:alarm/DataLayar/alarm.dart';

Widget buildRow(Alarm alarm) {
  return Row(mainAxisSize: MainAxisSize.min, children: [
    Switch(
      value: alarm.active,
      activeColor: Colors.orange,
      activeTrackColor: Colors.red,
      onChanged: (value) => print(value),
    ),
    Expanded(
        child: Column(children: [
      Row(mainAxisSize: MainAxisSize.min, children: [
        Text(DateFormat("hh:mm").format(alarm.time),
            style: TextStyle(
              color: Colors.black,
              fontSize: 35,
            )),
        Text(DateFormat("a").format(alarm.time),
            style: TextStyle(
              color: Colors.black,
              fontSize: 15,
            ),
            textAlign: TextAlign.justify)
      ]),
      Text('Tue, Wed, Thu',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
          ))
    ])),
    Icon(Icons.more_horiz)
  ]);
}
