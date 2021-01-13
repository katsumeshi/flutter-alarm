import 'dart:async';
import 'package:alarm/BLoC/alarms_event.dart';
import 'package:alarm/BLoC/alarms_state.dart';
import 'package:alarm/DataLayar/alarm.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AlarmsBloc extends Bloc<AlarmsEvent, AlarmsState> {
  StreamSubscription<Alarm> _alarmSubscription;

  AlarmsBloc() : super(AlarmsUninitialized());

  @override
  Stream<AlarmsState> mapEventToState(AlarmsEvent event) async* {
    if (event is LoadAlarms) {
      yield* _mapLoadAlarmsToState();
    } else if (event is UpdateAlarm) {
      yield* _mapAlarmUpdatedToState(event);
    }
  }

  Stream<AlarmsState> _mapLoadAlarmsToState() async* {
    try {
      final alarms = [Alarm()];
      yield AlarmsLoaded(
        alarms,
      );
    } catch (_) {
      // yield PlayerErrorState();
    }
  }

  Stream<AlarmsState> _mapAlarmUpdatedToState(UpdateAlarm event) async* {
    if (state is AlarmsLoaded) {
      final updatedTodos = (state as AlarmsLoaded).alarms.map((alarm) {
        return alarm.id == event.updatedAlarm.id ? event.updatedAlarm : alarm;
      }).toList();
      // print(updatedTodos);
      yield AlarmsLoaded(updatedTodos);
      // await _saveTodos(updatedTodos);
    }
  }

  Future _saveAlarms(List<Alarm> todos) {
    return Future.value(todos);
    // return todosRepository.saveTodos(
    //   todos.map((todo) => todo.toEntity()).toList(),
    // );
  }
}
