import 'package:alarm/DataLayar/alarm.dart';
import 'package:cron/cron.dart';

class ClonManager {
  static final ClonManager _singleton = ClonManager._internal();
  Cron cron;
  Map map;

  factory ClonManager() {
    return _singleton;
  }

  addAlarms(List<Alarm> alarms, Function callback) {
    if (_singleton.cron != null) {
      _singleton.cron.close();
    }
    _singleton.cron = Cron();
    map = {};
    alarms.forEach((e) {
      if (e.active) {
        final minute = e.time.minute;
        final hour = e.time.hour;
        e.days.forEach((key, value) {
          final day = e.days.keys.toList().indexOf(key);
          final cronKey = '$minute $hour * * $day';
          if (map[cronKey] == null) {
            _singleton.cron.schedule(Schedule.parse(cronKey), () async {
              callback();
            });
            map[cronKey] = true;
          }
        });
      }
    });
  }

  ClonManager._internal();
}
