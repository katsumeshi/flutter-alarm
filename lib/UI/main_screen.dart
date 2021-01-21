import 'package:alarm/BLoC/alarm_bloc.dart';
import 'package:alarm/BLoC/alarms_state.dart';
import 'package:alarm/DataLayar/alarm.dart';
import 'package:alarm/UI/alarm_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alarms'),
      ),
      body: Center(
        child: _listView(context),
      ),
      floatingActionButton: _add(context),
    );
  }

  Widget _listView(BuildContext context) {
    return BlocBuilder<AlarmsBloc, AlarmsState>(builder: (context, state) {
      final alarms = (state as AlarmsLoaded).alarms;
      return ListView.separated(
          separatorBuilder: (context, index) => Divider(),
          itemCount: alarms.length,
          padding: const EdgeInsets.all(16.0),
          itemBuilder: (context, i) {
            return buildRow(context, alarms[i]);
          });
    });
  }

  Widget _add(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.of(context).pushNamed('/second', arguments: Alarm());
      },
      child: Icon(Icons.add),
      backgroundColor: Colors.green,
    );
  }
}
