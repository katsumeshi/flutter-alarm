class Alarm {
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
}
