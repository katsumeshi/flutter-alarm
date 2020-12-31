import 'dart:async';
import 'package:alarm/DataLayar/alarm.dart';
import 'bloc.dart';

class AlarmBloc implements Bloc {
  var _alarms = <Alarm>[];
  List<Alarm> get alarms => _alarms;

  final _controller = StreamController<List<Alarm>>.broadcast();
  Stream<List<Alarm>> get alarmsStream => _controller.stream;

  AlarmBloc() {
    _alarms.add(Alarm(0, false, DateTime.now()));
    _controller.sink.add(_alarms);
  }

  void toggleRestaurant(Alarm restaurant) {
    if (_alarms.contains(restaurant)) {
      _alarms.remove(restaurant);
    } else {
      _alarms.add(restaurant);
    }

    _controller.sink.add(_alarms);
  }

  @override
  void dispose() {
    _controller.close();
  }
}
