import 'package:alarm/DataLayar/alarm.dart';
import 'package:cron/cron.dart';

class ClonManager {
  static final ClonManager _singleton = ClonManager._internal();
  Cron cron;

  factory ClonManager() {
    return _singleton;
  }

  addAlarms(List<Alarm> alarms) {
    if (_singleton.cron != null) {
      _singleton.cron.close();
    }
    _singleton.cron = Cron();
    alarms.forEach((e) {
      final minute = e.time.minute;
      final hour = e.time.hour;
      e.days.forEach((key, value) {
        final day = e.days.keys.toList().indexOf(key);
        _singleton.cron.schedule(Schedule.parse('$minute $hour * * $day'),
            () async {
          print('between every 8 and 11 minutes');
        });
      });
    });
  }

  ClonManager._internal();
}
