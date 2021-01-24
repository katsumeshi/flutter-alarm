import 'package:alarm/BLoC/alarms_event.dart';
import 'package:alarm/BLoC/alarms_state.dart';
import 'package:alarm/DataLayar/alarm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:alarm/BLoC/alarm_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

Widget buildRow(BuildContext context, Alarm alarm) {
  final bloc = BlocProvider.of<AlarmsBloc>(context);
  return BlocBuilder<AlarmsBloc, AlarmsState>(builder: (context, state) {
    return Row(mainAxisSize: MainAxisSize.min, children: [
      Switch(
        value: alarm.active,
        activeColor: Colors.orange,
        activeTrackColor: Colors.red,
        onChanged: (v) => {bloc.add(UpdateAlarm(alarm.copyWith(active: v)))},
      ),
      Expanded(
          child: InkWell(
              onTap: () {
                DatePicker.showTime12hPicker(context, showTitleActions: true,
                    onConfirm: (time) {
                  bloc.add(UpdateAlarm(alarm.copyWith(time: time)));
                }, currentTime: alarm.time, locale: LocaleType.en);
              },
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(mainAxisSize: MainAxisSize.min, children: [
                      Text(DateFormat("hh:mm").format(alarm.time),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 35,
                          )),
                      Text(DateFormat("a").format(alarm.time),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                          textAlign: TextAlign.justify)
                    ]),
                    _daysWidget(alarm)
                  ]))),
      Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        InkWell(
            onTap: () {
              Navigator.of(context).pushNamed('/second', arguments: alarm);
            },
            child: Icon(Icons.more_horiz))
      ]),
    ]);
  });
}

Widget _daysWidget(Alarm alarm) {
  final dayString = alarm.toDaysString();
  return dayString.isEmpty
      ? SizedBox.shrink()
      : Text(dayString,
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
          ));
}
