import 'package:equatable/equatable.dart';
import 'package:alarm/DataLayar/alarm.dart';

abstract class AlarmsState extends Equatable {
  const AlarmsState();

  @override
  List<Object> get props => [];
}

class AlarmsLoaded extends AlarmsState {
  final List<Alarm> alarms;

  const AlarmsLoaded([this.alarms = const []]);

  @override
  List<Object> get props => [alarms];

  @override
  String toString() => 'AlarmsLoaded { alarms: $alarms }';
}

class AlarmsLoadFailure extends AlarmsState {}
