import 'package:equatable/equatable.dart';
import 'package:alarm/DataLayar/alarm.dart';

abstract class AlarmsEvent extends Equatable {
  const AlarmsEvent();

  @override
  List<Object> get props => [];
}

class AlarmsLoadSuccess extends AlarmsEvent {}

class AlarmAdded extends AlarmsEvent {
  final Alarm alarm;

  const AlarmAdded(this.alarm);

  @override
  List<Object> get props => [alarm];

  @override
  String toString() => 'AlarmAdded { Alarm: $alarm }';
}

class AlarmUpdated extends AlarmsEvent {
  final Alarm alarm;

  const AlarmUpdated(this.alarm);

  @override
  List<Object> get props => [Alarm];

  @override
  String toString() => 'AlarmUpdated { Alarm: $Alarm }';
}

class AlarmDeleted extends AlarmsEvent {
  final Alarm alarm;

  const AlarmDeleted(this.alarm);

  @override
  List<Object> get props => [alarm];

  @override
  String toString() => 'AlarmDeleted { Alarm: $alarm }';
}

class ClearCompleted extends AlarmsEvent {}

class ToggleAll extends AlarmsEvent {}
