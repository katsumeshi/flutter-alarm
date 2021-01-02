import 'package:alarm/BLoC/alarm_bloc.dart';
import 'package:alarm/BLoC/bloc_provider.dart';
import 'package:alarm/DataLayar/alarm.dart';
import 'package:alarm/UI/alarm_row.dart';
import 'package:flutter/material.dart';

import 'add_screen.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<AlarmBloc>(context);

    return BlocProvider<AlarmBloc>(
        bloc: AlarmBloc(),
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Alarms'),
          ),
          body: Center(
            child: _bindBloc(bloc),
          ),
          floatingActionButton: _add(context),
        ));
  }

  Widget _bindBloc(AlarmBloc bloc) {
    return StreamBuilder<List<Alarm>>(
      stream: bloc.alarmsStream,
      builder: (context, snapshot) {
        return _listView(bloc);
      },
    );
  }

  Widget _listView(AlarmBloc bloc) {
    return ListView.separated(
        separatorBuilder: (context, index) => Divider(),
        itemCount: bloc.alarms.length,
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          return buildRow(bloc, bloc.alarms[i]);
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
