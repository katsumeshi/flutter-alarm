import 'dart:async';
import 'package:alarm/DataLayar/alarm.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class AlarmState extends Equatable {
  final Alarm alarm;

  const AlarmState(this.alarm);

  @override
  List<Object> get props => [alarm];
}

class AlarmInitial extends AlarmState {
  const AlarmInitial(Alarm alarm) : super(alarm);

  @override
  String toString() => 'AlarmInitial { alarm: $alarm }';
}

class TimerRunInProgress extends AlarmState {
  const TimerRunInProgress(Alarm alarm) : super(alarm);

  @override
  String toString() => 'TimerRunInProgress { duration: $alarm }';
}

abstract class AlarmEvent extends Equatable {
  const AlarmEvent();

  @override
  List<Object> get props => [];
}

class AlarmStarted extends AlarmEvent {
  final Alarm alarm;

  const AlarmStarted({@required this.alarm});

  @override
  String toString() => "TimerStarted { duration: $alarm }";
}

class AlarmUpdated extends AlarmEvent {
  final Alarm alarm;

  const AlarmUpdated(this.alarm);

  @override
  List<Object> get props => [alarm];

  @override
  String toString() => 'TodoUpdated { todo: $alarm }';
}

const days = {
  "Monday": false,
  "Tuesday": false,
  "Wednesday": false,
  "Thursday": false,
  "Friday": false,
  "Saturday": false,
  "Sunday": false
};

class AlarmBloc extends Bloc<AlarmEvent, AlarmState> {
  AlarmBloc() : super(AlarmInitial(Alarm(0, false, DateTime.now(), days)));

  StreamSubscription<Alarm> _alarmSubscription;

  @override
  Stream<AlarmState> mapEventToState(AlarmEvent event) async* {
    if (event is AlarmStarted) {
      yield* _mapTimerStartedToState(event);
    }
  }

  Stream<AlarmState> _mapTimerStartedToState(AlarmStarted alarm) async* {
    yield TimerRunInProgress(alarm.alarm);
  }
  // AlarmBloc() : super();

  // var _alarms = <Alarm>[];
  // List<Alarm> get alarms => _alarms;

  // final _controller = StreamController<List<Alarm>>.broadcast();
  // Stream<List<Alarm>> get alarmsStream => _controller.stream;

  // void toggleAlerm(Alarm alarm, bool value) {
  //   var index = _alarms.indexOf(alarm);
  //   _alarms[index] = Alarm(alarm.id, value, alarm.time, alarm.days);
  //   _controller.sink.add(_alarms);
  // }

  // void updateDays(Alarm alarm, String key) {
  //   final index = _alarms.indexOf(alarm);
  //   final newDays = alarm.days
  //       .map((_key, value) => MapEntry(_key, _key == key ? !value : value));
  //   print(newDays);
  //   _alarms[index] = Alarm(alarm.id, alarm.active, alarm.time, newDays);
  //   _controller.sink.add(_alarms);
  // }

  // @override
  // void dispose() {
  //   _controller.close();
  // }

  // // @override
  // // Stream<AlarmState> mapEventToState(AlaramEvent event) {
  // //   // TODO: implement mapEventToState
  // //   throw UnimplementedError();
  // // }
  // @override
  // Stream<AlarmState> mapEventToState(
  //   AlarmState event,
  // ) async* {
  //   if (event is AlarmUpdated) {
  //     yield* _mapTimerStartedToState(event);
  //   }
  // }

  // Stream<AlarmState> _mapTimerStartedToState(AlarmUpdated start) async* {
  //   // yield TimerRunInProgress(start.duration);
  //   // _tickerSubscription?.cancel();
  //   // _tickerSubscription = _ticker
  //   //     .tick(ticks: start.duration)
  //   //     .listen((duration) => add(TimerTicked(duration: duration)));
  // }
}
