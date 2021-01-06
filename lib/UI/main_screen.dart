import 'package:alarm/BLoC/alarm_bloc.dart';
// import 'package:alarm/BLoC/bloc_provider.dart';
// import 'package:alarm/DataLayar/alarm.dart';
import 'package:alarm/UI/alarm_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'add_screen.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AlarmBloc, AlarmState>(builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Alarms'),
        ),
        body: Center(
          child: _listView(state),
        ),
        floatingActionButton: _add(context),
      );
    });
  }

  Widget _listView(AlarmState state) {
    return ListView.separated(
        separatorBuilder: (context, index) => Divider(),
        itemCount: 1,
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          return buildRow(state.alarm);
        });
  }

  Widget _add(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SecondRoute()),
        );
      },
      child: Icon(Icons.add),
      backgroundColor: Colors.green,
    );
  }
}
