import 'package:equatable/equatable.dart';
import 'package:alarm/DataLayar/alarm.dart';

abstract class AlarmsEvent extends Equatable {
  const AlarmsEvent();

  @override
  List<Object> get props => [];
}

class LoadAlarms extends AlarmsEvent {}

class AddAlarm extends AlarmsEvent {
  final Alarm alarm;

  const AddAlarm(this.alarm);

  @override
  List<Object> get props => [alarm];

  @override
  String toString() => 'AlarmAdded { Alarm: $alarm }';
}

class UpdateAlarm extends AlarmsEvent {
  final Alarm updatedAlarm;

  const UpdateAlarm(this.updatedAlarm);

  @override
  List<Object> get props => [updatedAlarm];

  @override
  String toString() => 'UpdateAlarm { Alarm: $updatedAlarm }';
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
