import 'dart:async';
import 'dart:convert';
import 'package:alarm/BLoC/alarms_event.dart';
import 'package:alarm/BLoC/alarms_state.dart';
import 'package:alarm/DataLayar/alarm.dart';
import 'package:alarm/UI/comonents/audio_player.dart';
import 'package:alarm/UI/comonents/cron_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      final alarms = await _loadAlarms();
      ClonManager().addAlarms(alarms, () => Audio().playDefaultAlarm());
      yield AlarmsLoaded(alarms);
    } catch (err) {
      print(err);
    }
  }

  Stream<AlarmsState> _mapAlarmUpdatedToState(UpdateAlarm event) async* {
    if (state is AlarmsLoaded) {
      final alarms = (state as AlarmsLoaded).alarms.map((alarm) {
        return alarm.id == event.updatedAlarm.id ? event.updatedAlarm : alarm;
      }).toList();

      ClonManager().addAlarms(alarms, () => Audio().playDefaultAlarm());
      yield AlarmsLoaded(alarms);
      await _saveAlarms(alarms);
    }
  }

  Stream<AlarmsState> _mapAlarmAddedToState(AddAlarm event) async* {
    if (state is AlarmsLoaded) {
      final alarms = (state as AlarmsLoaded).alarms.map((e) => e).toList();
      alarms.add(event.alarm);
      ClonManager().addAlarms(alarms, () => Audio().playDefaultAlarm());
      yield AlarmsLoaded(alarms);
      await _saveAlarms(alarms);
    }
  }

  Stream<AlarmsState> _mapAlarmDeletedToState(DeleteAlarm event) async* {
    if (state is AlarmsLoaded) {
      final alarms = (state as AlarmsLoaded)
          .alarms
          .toList()
          .where((e) => e.id != event.alarm.id)
          .toList();
      ClonManager().addAlarms(alarms, () => Audio().playDefaultAlarm());
      yield AlarmsLoaded(alarms);
      await _saveAlarms(alarms);
    }
  }

  Future _saveAlarms(List<Alarm> alarms) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final json = jsonEncode(alarms.map((e) => e.toJsonMap()).toList());
    prefs.setString("storage", json);
  }

  Future<List<Alarm>> _loadAlarms() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final json = prefs.getString("storage");
    if (json == null) return [];
    final list = jsonDecode(json) as List;
    print(list.map((e) => Alarm.fromJson(e)));
    return list.map((e) => Alarm.fromJson(e)).toList();
  }
}
