import 'package:alarm/BLoC/alarm_bloc.dart';
import 'package:alarm/BLoC/alarms_event.dart';
import 'package:alarm/UI/add_screen.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'UI/main_screen.dart';

var advancedPlayer = AudioPlayer();
final audioCache = AudioCache(fixedPlayer: advancedPlayer);
void main() {
  // var advancedPlayer = AudioPlayer();
  // final audioCache = AudioCache();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<AlarmsBloc>(
        create: (context) => AlarmsBloc()..add(LoadAlarms()),
      ),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (BuildContext context) => MainScreen(),
        '/second': (BuildContext context) => SecondRoute(),
      },
      title: 'Restaurant Finder',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
    );
  }
}
