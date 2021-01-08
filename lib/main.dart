import 'package:alarm/BLoC/alarm_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'UI/main_screen.dart';

void main() {
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<AlarmsBloc>(
        create: (context) => AlarmsBloc(),
      ),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant Finder',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MainScreen(),
    );
  }
}
