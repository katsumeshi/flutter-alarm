import 'dart:async';
import 'package:alarm/BLoC/alarms_event.dart';
import 'package:alarm/BLoC/alarms_state.dart';
import 'package:alarm/DataLayar/alarm.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const days = {
  "Monday": false,
  "Tuesday": false,
  "Wednesday": false,
  "Thursday": false,
  "Friday": false,
  "Saturday": false,
  "Sunday": false
};

class AlarmsBloc extends Bloc<AlarmsEvent, AlarmsState> {
  StreamSubscription<Alarm> _alarmSubscription;

  AlarmsBloc() : super(AlarmsUninitialized());

  @override
  Stream<AlarmsState> mapEventToState(AlarmsEvent event) async* {
    if (event is AlarmsLoadSuccess) {
      yield* _mapAlarmsLoadedToState();
    } else if (event is AlarmUpdated) {
      yield* _mapAlarmUpdatedToState(event);
    }
  }

  Stream<AlarmsState> _mapAlarmsLoadedToState() async* {
    List<AlarmsState> alarms;
    try {
      // if (event is CountrySelectedEvent) {
      //   players = await playerRepository
      //       .fetchPlayersByCountry(event.nationModel.countryId);
      // } else if (event is SearchTextChangedEvent) {
      //   players = await playerRepository.fetchPlayersByName(event.searchTerm);
      // }
      if (alarms.length == 0) {
        yield AlarmsEmptyState();
      } else {
        // yield PlayerFetchedState(players: players);
      }
    } catch (_) {
      // yield PlayerErrorState();
    }
  }

  Stream<AlarmsState> _mapAlarmUpdatedToState(AlarmUpdated event) async* {
    if (state is AlarmsLoadSuccess) {
      // final List<Alarm> updatedAlarms =
      //     (state as AlarmsLoadSuccesss).alarms.map((alarm) {
      //   return alarm.id == event.alarm.id ? event.alarm : alarm;
      // }).toList();
      // yield AlarmsLoadSuccesss(updatedAlarms);
      // _saveAlarms(updatedAlarms);
    }
  }

  Future _saveAlarms(List<Alarm> todos) {
    return Future.value(todos);
    // return todosRepository.saveTodos(
    //   todos.map((todo) => todo.toEntity()).toList(),
    // );
  }
}
