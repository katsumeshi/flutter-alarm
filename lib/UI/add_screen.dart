import 'package:alarm/BLoC/alarms_event.dart';
import 'package:alarm/BLoC/alarms_state.dart';
import 'package:alarm/DataLayar/alarm.dart';
import 'package:alarm/UI/alarm_row.dart';
import 'package:flutter/material.dart';
import 'package:alarm/BLoC/alarm_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SecondRoute extends StatelessWidget {
  static const rowHeight = 70.0;
  static const margin = 16.0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AlarmsBloc, AlarmsState>(builder: (context, state) {
      print("hogehoge loading");
      print((state as AlarmsLoaded).alarms[0].days);
      return Scaffold(
          appBar: AppBar(
            title: Text("Second Route"),
          ),
          body: Container(
              alignment: Alignment.topCenter,
              child: _listView(context, (state as AlarmsLoaded).alarms[0])));
    });
  }

  Widget _listView(BuildContext context, Alarm alarm) {
    return ListView(
      shrinkWrap: true,
      children: <Widget>[
        Container(
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.black12)),
            ),
            height: rowHeight,
            child: buildRow(alarm)),
        InkWell(
            onTap: () => showRepeatDialog(context, alarm),
            child: Container(
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.black12)),
                ),
                height: rowHeight,
                padding: const EdgeInsets.only(left: margin, right: margin),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [Text("Repeat"), Text("Never")]))),
        Container(
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.black12)),
            ),
            height: rowHeight,
            padding: const EdgeInsets.only(left: margin, right: margin),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [Text("Ringtone"), Text("Default(Bright Morning)")])),
        Container(
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.black12)),
            ),
            padding: const EdgeInsets.only(left: margin, right: margin),
            height: rowHeight,
            child:
                Row(children: [Text("Gentle pre-alarm"), Spacer(), Text("□")])),
        Container(
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.black12)),
          ),
          margin: const EdgeInsets.only(left: margin, right: margin),
          height: rowHeight,
          alignment: Alignment.centerLeft,
          child: TextField(
              decoration:
                  InputDecoration(border: InputBorder.none, hintText: 'Label')),
        )
      ],
    );
  }

  void showRepeatDialog(BuildContext context, Alarm alarm) {
    final bloc = BlocProvider.of<AlarmsBloc>(context);
    showDialog(
        context: context,
        builder: (context) {
          Map<String, bool> days =
              defaultDays.map((key, value) => MapEntry(key, value));
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: days.entries
                      .map((e) => InkWell(
                            onTap: () {
                              setState(() {
                                days[e.key] = !days[e.key];
                              });
                            },
                            child: Row(children: [
                              Checkbox(value: e.value, onChanged: null),
                              Spacer(),
                              Text(e.key),
                            ]),
                          ))
                      .toList()),
              actions: <Widget>[
                FlatButton(
                  child: Text("Cancel"),
                  onPressed: () => Navigator.pop(context),
                ),
                FlatButton(
                    child: Text("OK"),
                    onPressed: () {
                      bloc.add(UpdateAlarm(alarm.copyWith(days: days)));
                      Navigator.pop(context);
                    }),
              ],
            );
          });
        });
  }
}
