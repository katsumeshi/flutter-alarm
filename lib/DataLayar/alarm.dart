import 'package:equatable/equatable.dart';

const defaultDays = {
  "Monday": false,
  "Tuesday": false,
  "Wednesday": false,
  "Thursday": false,
  "Friday": false,
  "Saturday": false,
  "Sunday": false
};

class Alarm extends Equatable {
  final int id;
  final bool active;
  final DateTime time;
  final Map<String, bool> days;

  Alarm.fromJson(Map json)
      : id = json['id'],
        active = json['active'],
        time = json['title'],
        days = json['days'];

  Alarm(
      {this.id = 0, this.active = false, DateTime time, Map<String, bool> days})
      : time = DateTime.now(),
        days = defaultDays;

  AlarmEntity toEntity() {
    return AlarmEntity(id, active, time, days);
  }

  // static Alarm fromEntity(AlarmEntity entity) {
  //   return Alarm(entity.id, entity.active, entity.time, entity.days);
  // }

  Alarm copyWith({int id, bool active, DateTime time, Map<String, bool> days}) {
    return Alarm(
      id: id ?? this.id,
      active: active ?? this.active,
      time: time ?? this.time,
      days: days ?? this.days,
    );
  }

  @override
  List<Object> get props => [id, active, time, days];
}

class AlarmEntity extends Equatable {
  final int id;
  final bool active;
  final DateTime time;
  final Map<String, bool> days;

  const AlarmEntity(this.id, this.active, this.time, this.days);

  @override
  List<Object> get props => [id, active, time, days];
}
