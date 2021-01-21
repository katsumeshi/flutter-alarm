import 'package:alarm/BLoC/alarms_event.dart';
import 'package:alarm/BLoC/alarms_state.dart';
import 'package:alarm/BLoC/alarm_bloc.dart';
import 'package:alarm/DataLayar/alarm.dart';
import 'package:alarm/UI/comonents/alarm_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SecondRoute extends StatelessWidget {
  static const rowHeight = 70.0;
  static const margin = 16.0;

  @override
  Widget build(BuildContext context) {
    final alarm = ModalRoute.of(context).settings.arguments as Alarm;
    final bloc = BlocProvider.of<AlarmsBloc>(context);
    return BlocBuilder<AlarmsBloc, AlarmsState>(builder: (context, state) {
      final alarms = (state as AlarmsLoaded).alarms;
      return Scaffold(
          appBar: AppBar(
              title: Text("Second Route"),
              leading: IconButton(
                icon: Icon(Icons.chevron_left, size: 30),
                onPressed: () {
                  final ret = alarms.firstWhere((e) => e.id == alarm.id,
                      orElse: () => null);
                  if (ret == null) {
                    bloc.add(AddAlarm(alarm));
                  } else {
                    bloc.add(UpdateAlarm(alarm));
                  }
                  Navigator.of(context).pop();
                },
              )),
          body: Container(
              alignment: Alignment.topCenter,
              child: _listView(context, alarm)));
    });
  }

  Widget _listView(BuildContext context, Alarm alarm) {
    final bloc = BlocProvider.of<AlarmsBloc>(context);
    return ListView(
      shrinkWrap: true,
      children: <Widget>[
        Container(
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.black12)),
            ),
            height: rowHeight,
            child: buildRow(context, alarm)),
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
          child: TextFormField(
              initialValue: alarm.note,
              onFieldSubmitted: (String text) =>
                  {bloc.add(UpdateAlarm(alarm.copyWith(note: text)))},
              decoration:
                  InputDecoration(border: InputBorder.none, hintText: 'Note')),
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
              alarm.days.map((key, value) => MapEntry(key, value)) ??
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
                  onPressed: () {
                    Navigator.pop(context);
                  },
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
