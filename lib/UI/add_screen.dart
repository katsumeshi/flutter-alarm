import 'package:alarm/UI/alarm_row.dart';
import 'package:flutter/material.dart';
import 'package:alarm/BLoC/alarm_bloc.dart';
import 'package:alarm/BLoC/bloc_provider.dart';
import 'package:flutter/services.dart';

class SecondRoute extends StatelessWidget {
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
      padding: const EdgeInsets.all(8),
      children: <Widget>[
        buildRow(bloc, bloc.alarms[0]),
        Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text("Repeat"), Text("Never")]),
        Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text("Ringtone"), Text("Default(Bright Morning)")]),
        Row(children: [Text("Gentle pre-alarm"), Spacer(), Text("□")]),
        TextField(
          decoration:
              InputDecoration(border: InputBorder.none, hintText: 'Label'),
        )
      ],
    );
  }
}
