import 'dart:collection';

import 'package:uuid/uuid.dart';
import 'package:equatable/equatable.dart';

const defaultDays = {
  "Monday": true,
  "Tuesday": true,
  "Wednesday": true,
  "Thursday": true,
  "Friday": true,
  "Saturday": true,
  "Sunday": true
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
        time = DateTime.parse(json['time']),
        days = (json['days'] as LinkedHashMap).cast(),
        note = json['note'];

  Alarm(
      {String id,
      this.active = true,
      DateTime time,
      Map<String, bool> days,
      this.note = ""})
      : this.id = id ?? uuid.v1(),
        this.time = time ?? DateTime.now().add(Duration(minutes: 1)),
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

  Map toJsonMap() {
    return {
      "id": id,
      "active": active,
      "time": time.toIso8601String(),
      "days": days,
      "note": note
    };
  }

  String toDaysString() {
    final weekdays = days["Monday"] &&
        days["Tuesday"] &&
        days["Wednesday"] &&
        days["Thursday"] &&
        days["Friday"] &&
        !days["Saturday"] &&
        !days["Sunday"];
    if (weekdays) {
      return "Weekdays";
    }
    final weekends = !days["Monday"] &&
        !days["Tuesday"] &&
        !days["Wednesday"] &&
        !days["Thursday"] &&
        !days["Friday"] &&
        days["Saturday"] &&
        days["Sunday"];
    if (weekends) {
      return "Weekends";
    }
    final everyday = days["Monday"] &&
        days["Tuesday"] &&
        days["Wednesday"] &&
        days["Thursday"] &&
        days["Friday"] &&
        days["Saturday"] &&
        days["Sunday"];
    if (everyday) {
      return "Everyday";
    }

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
