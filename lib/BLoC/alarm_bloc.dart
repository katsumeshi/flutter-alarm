import 'dart:async';
import 'package:alarm/BLoC/alarms_event.dart';
import 'package:alarm/BLoC/alarms_state.dart';
import 'package:alarm/DataLayar/alarm.dart';
import 'package:alarm/UI/comonents/cron_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AlarmsBloc extends Bloc<AlarmsEvent, AlarmsState> {
  List<Alarm> alarms = [];

  AlarmsBloc() : super(AlarmsLoaded());

  @override
  Stream<AlarmsState> mapEventToState(AlarmsEvent event) async* {
    if (event is LoadAlarms) {
      yield* _mapLoadAlarmsToState();
    } else if (event is UpdateAlarm) {
      yield* _mapAlarmUpdatedToState(event);
    } else if (event is AddAlarm) {
      yield* _mapAlarmAddedToState(event);
    } else if (event is DeleteAlarm) {
      yield* _mapAlarmDeletedToState(event);
    }
  }

  Stream<AlarmsState> _mapLoadAlarmsToState() async* {
    try {
      alarms.forEach((element) {
        print(element.days);
      });
    } catch (_) {
      // yield PlayerErrorState();
    }
  }

  Stream<AlarmsState> _mapAlarmUpdatedToState(UpdateAlarm event) async* {
    if (state is AlarmsLoaded) {
      final alarms = (state as AlarmsLoaded).alarms.map((alarm) {
        print(alarm);
        return alarm.id == event.updatedAlarm.id ? event.updatedAlarm : alarm;
      }).toList();

      ClonManager().addAlarms(alarms);
      yield AlarmsLoaded(alarms);
    }
  }

  Stream<AlarmsState> _mapAlarmAddedToState(AddAlarm event) async* {
    if (state is AlarmsLoaded) {
      final alarms = (state as AlarmsLoaded).alarms.map((e) => e).toList();
      alarms.add(event.alarm);
      ClonManager().addAlarms(alarms);
      yield AlarmsLoaded(alarms);
    }
  }

  Stream<AlarmsState> _mapAlarmDeletedToState(DeleteAlarm event) async* {
    if (state is AlarmsLoaded) {
      final alarms = (state as AlarmsLoaded)
          .alarms
          .toList()
          .where((e) => e.id != event.alarm.id)
          .toList();
      print(alarms);
      ClonManager().addAlarms(alarms);
      yield AlarmsLoaded(alarms);
    }
  }
}
