class Alarm {
  final int id;
  final bool active;
  final DateTime time;

  Alarm.fromJson(Map json)
      : id = json['id'],
        active = json['active'],
        time = json['title'];

  Alarm(this.id, this.active, this.time);
}
