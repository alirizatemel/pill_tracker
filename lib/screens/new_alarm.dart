import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;
import 'package:pill_tracker/providers/alarm.dart';

class NewAlarm extends StatefulWidget {
  final Function addAlarm;

  NewAlarm(this.addAlarm);

  @override
  _NewAlarmState createState() => _NewAlarmState();
}

class _NewAlarmState extends State<NewAlarm> {
  final _nameController = TextEditingController();
  final _timeController = TextEditingController();
  final _weekDaysController = TextEditingController();
  final _pillController = TextEditingController();

  void _submitData() {
    if (_timeController.text.isEmpty) {
      return;
    }
    final enteredName = _nameController.text;
    final enteredTime = _timeController.text;
    final enteredWeekDays = _weekDaysController.text;
    final enteredPill = _pillController.text;

    if (enteredName.isEmpty ||
        enteredTime.isEmpty ||
        enteredWeekDays.isEmpty ||
        enteredPill.isEmpty) {
      return;
    }
    var newAlarm = AlarmItem(
      name: enteredName,
      time: enteredTime,
      pillId: enteredPill,
      weekDays: enteredWeekDays,
      date: '26.03.2022',
      duration: 'duration',
      userId: '123',
      id: mongo.ObjectId(),
      alarmType: 'test',
    );

    widget.addAlarm(newAlarm);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
              top: 10,
              right: 10,
              left: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: 'Name'),
                controller: _nameController,
                onSubmitted: (_) => _submitData(),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Week Days'),
                controller: _weekDaysController,
                onSubmitted: (_) => _submitData(),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Time'),
                controller: _timeController,
                onSubmitted: (_) => _submitData(),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Pill'),
                controller: _pillController,
                onSubmitted: (_) => _submitData(),
              ),
              ElevatedButton(
                child: Text('Add Alarm'),
                style: ElevatedButton.styleFrom(
                    primary: Colors.purple, onPrimary: Colors.white),
                onPressed: _submitData,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
