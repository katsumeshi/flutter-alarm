import 'package:alarm/UI/alarm_row.dart';
import 'package:flutter/material.dart';
import 'package:alarm/BLoC/alarm_bloc.dart';
import 'package:alarm/BLoC/bloc_provider.dart';

class SecondRoute extends StatelessWidget {
  static const rowHeight = 70.0;
  static const margin = 16.0;

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<AlarmBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Route"),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        child: _listView(bloc),
      ),
    );
  }

  Widget _listView(AlarmBloc bloc) {
    return ListView(
      shrinkWrap: true,
      children: <Widget>[
        Container(
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.black12)),
            ),
            height: rowHeight,
            child: buildRow(bloc, bloc.alarms[0])),
        InkWell(
            onTap: () => print("test"),
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
}
