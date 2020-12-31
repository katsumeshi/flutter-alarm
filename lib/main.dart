import 'package:alarm/BLoC/alarm_bloc.dart';
import 'package:alarm/BLoC/bloc_provider.dart';
import 'package:flutter/material.dart';

import 'UI/main_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AlarmBloc>(
        bloc: AlarmBloc(),
        child: MaterialApp(
            title: 'Restaurant Finder',
            theme: ThemeData(
              primarySwatch: Colors.red,
            ),
            home: MainScreen()));
  }
}
