import 'package:equatable/equatable.dart';
import 'package:alarm/DataLayar/alarm.dart';

abstract class AlarmsState extends Equatable {
  const AlarmsState();

  @override
  List<Object> get props => [];
}

class AlarmsUninitialized extends AlarmsState {}

// class AlarmsLoadSuccesss extends AlarmsState {
//   final List<Alarm> alarms;

//   const AlarmsLoadSuccesss([this.alarms = const []]);

//   @override
//   List<Object> get props => [alarms];

//   @override
//   String toString() => 'AlarmsLoadSuccess { Alarms: $alarms }';
// }

class AlarmsLoadFailure extends AlarmsState {}

class AlarmsEmptyState extends AlarmsState {}
