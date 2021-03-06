import 'package:alarm/BLoC/alarm_bloc.dart';
import 'package:alarm/BLoC/alarms_event.dart';
import 'package:alarm/UI/edit_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'UI/main_screen.dart';

void main() {
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<AlarmsBloc>(
        create: (context) => AlarmsBloc()..add(LoadAlarms()),
      ),
    ],
    child: App(),
  ));
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (BuildContext context) => MainScreen(),
        '/add': (BuildContext context) => SecondRoute(Mode.Add),
        '/edit': (BuildContext context) => SecondRoute(Mode.Edit),
      },
      title: '',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
    );
  }
}
