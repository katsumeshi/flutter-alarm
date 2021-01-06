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
    return BlocBuilder<AlarmBloc, AlarmState>(builder: (context, state) {
      return Scaffold(
          appBar: AppBar(
            title: Text("Second Route"),
          ),
          body: Container(
              alignment: Alignment.topCenter,
              child: _listView(context, state)));
    });
  }

  Widget _listView(BuildContext context, AlarmState state) {
    return ListView(
      shrinkWrap: true,
      children: <Widget>[
        Container(
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.black12)),
            ),
            height: rowHeight,
            child: buildRow(state.alarm)),
        InkWell(
            onTap: () => showRepeatDialog(context, state.alarm),
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
    // final bloc = BlocProvider.of<AlarmBloc>(context);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Column(
              mainAxisSize: MainAxisSize.min,
              children: alarm.days.entries
                  .map((e) => InkWell(
                        onTap: () =>
                            {}, //bloc.updateDays(bloc.alarms[0], e.key),
                        child: Row(children: [
                          Checkbox(value: e.value, onChanged: null),
                          Spacer(),
                          Text(e.key),
                        ]),
                      ))
                  .toList()),
          actions: <Widget>[
            // ボタン領域
            FlatButton(
              child: Text("Cancel"),
              onPressed: () => Navigator.pop(context),
            ),
            FlatButton(
              child: Text("OK"),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );

        // return BlocProvider<AlarmBloc>.value(
        //   value: bloc, //
        //   child: dialog,
        // );
      },
    );
  }
}
