import 'package:uuid/uuid.dart';
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

final uuid = Uuid();

class Alarm extends Equatable {
  final String id;
  final bool active;
  final DateTime time;
  final Map<String, bool> days;
  final String note;

  Alarm.fromJson(Map json)
      : id = json['id'],
        active = json['active'],
        time = json['title'],
        days = json['days'],
        note = json['note'];

  Alarm(
      {String id,
      this.active = false,
      DateTime time,
      Map<String, bool> days,
      this.note = ""})
      : this.id = id ?? uuid.v1(),
        this.time = time ?? DateTime.now(),
        this.days = days ?? defaultDays;

  AlarmEntity toEntity() {
    return AlarmEntity(id, active, time, days, note);
  }

  Alarm copyWith(
      {String id,
      bool active,
      DateTime time,
      Map<String, bool> days,
      String note}) {
    return Alarm(
        id: id ?? this.id,
        active: active ?? this.active,
        time: time ?? this.time,
        days: days ?? this.days,
        note: note ?? this.note);
  }

  String toDaysString() {
    var ret = "";
    days.forEach((key, value) {
      if (value == true) {
        ret += key.substring(0, 3) + ", ";
      }
    });
    if (ret.length == 0) {
      return ret;
    }
    return ret.substring(0, ret.length - 2);
  }

  @override
  List<Object> get props => [id, active, time, days, note];
}

class AlarmEntity extends Equatable {
  final String id;
  final bool active;
  final DateTime time;
  final Map<String, bool> days;
  final String note;

  const AlarmEntity(this.id, this.active, this.time, this.days, this.note);

  @override
  List<Object> get props => [id, active, time, days, note];
}
