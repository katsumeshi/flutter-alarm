import 'package:alarm/BLoC/alarm_bloc.dart';
import 'package:alarm/BLoC/bloc_provider.dart';
import 'package:alarm/DataLayar/alarm.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final bloc = AlarmBloc();
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
          floatingActionButton: _add(),
        ));
  }

  Widget _bindBloc(AlarmBloc bloc) {
    return StreamBuilder<List<Alarm>>(
      stream: bloc.alarmsStream,
      builder: (context, snapshot) {
        // final results = snapshot.data;
        // print(snapshot);
        // print(results);

        // if (results == null) {
        //   return Center(child: Text('Enter a location'));
        // }

        // if (results.isEmpty) {
        //   return Center(child: Text('No Results'));
        // }

        return _listView(bloc.alarms);
      },
    );
  }

  Widget _listView(List<Alarm> alarms) {
    return ListView.separated(
        separatorBuilder: (context, index) => Divider(),
        itemCount: alarms.length,
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          return _buildRow(alarms[i]);
        });
  }

  Widget _buildRow(Alarm alarm) {
    return Row(mainAxisSize: MainAxisSize.min, children: [
      Switch(
        value: alarm.active,
        activeColor: Colors.orange,
        activeTrackColor: Colors.red,
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

  Widget _add() {
    return FloatingActionButton(
      onPressed: () {
        // Add your onPressed code here!
      },
      child: Icon(Icons.navigation),
      backgroundColor: Colors.green,
    );
  }
}
