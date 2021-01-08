import 'package:equatable/equatable.dart';

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

  Alarm(this.id, this.active, this.time, this.days);

  AlarmEntity toEntity() {
    return AlarmEntity(id, active, time, days);
  }

  static Alarm fromEntity(AlarmEntity entity) {
    return Alarm(entity.id, entity.active, entity.time, entity.days);
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
