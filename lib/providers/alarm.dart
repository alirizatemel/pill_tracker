import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:pill_tracker/screens/new_alarm.dart';
import '../models/http_exception.dart';


class AlarmItem {
  final String id;
  final String name;
  final String weekDays;
  final String time;
  final String pillId;
  AlarmItem(
      {required this.id,
      required this.name,
      required this.weekDays,
      required this.time,
      required this.pillId});
}

class Alarm with ChangeNotifier {
  List<AlarmItem> _alarms = [];
  final String authToken;
  final String userId;
  Map<String, AlarmItem> _items = {};
  Alarm(this.authToken, this.userId, this._alarms);

  List<AlarmItem> get alarms {
    return [..._alarms];
  }

  int get itemCount {
    return _alarms.length;
  }


  Future<void> fetchAndSetAlarms([bool filterByUser = false]) async {
    final filterString = filterByUser ? 'orderBy="creatorId"&equalTo="$userId"' : '';
    var url =
        Uri.https('pill-trucker-default-rtdb.europe-west1.firebasedatabase.app', '/alarms.json',{'auth': authToken});
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      final List<AlarmItem> loadedAlarms = [];
      extractedData.forEach((alarmId, alarmData) {
        loadedAlarms.add(AlarmItem(
          id: alarmId,
          name: alarmData['name'],
          weekDays: alarmData['weekDays'],
          time: alarmData['time'],
          pillId: alarmData['pillId'],
        ));
      });
      _alarms = loadedAlarms;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> addAlarm(AlarmItem alarm) async {
    final url = Uri.https('pill-trucker-default-rtdb.europe-west1.firebasedatabase.app', '/alarms.json',{'auth': authToken});
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'name': alarm.name,
          'weekDays': alarm.weekDays,
          'time': alarm.time,
          'pillId': alarm.pillId,
        }),
      );
      final newAlarm = AlarmItem(
        name: alarm.name,
        weekDays: alarm.weekDays,
        time: alarm.time,
        pillId: alarm.pillId,
        id: json.decode(response.body)['name'],
      );
      _alarms.add(newAlarm);
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  void addItem(String pillId, String name, String time, String weekDays) {
    if (_items.containsKey(pillId)) {
      // change quantity...
      _items.update(
        pillId,
        (existingAlarmItem) => AlarmItem(
            id: existingAlarmItem.id,
            name: existingAlarmItem.name,
            time: existingAlarmItem.time,
            weekDays: existingAlarmItem.weekDays,
            pillId: existingAlarmItem.pillId),
      );
    } else {
      _items.putIfAbsent(
        pillId,
        () => AlarmItem(
            id: DateTime.now().toString(),
            name: name,
            time: time,
            weekDays: weekDays,
            pillId: pillId),
      );
    }
    notifyListeners();
  }

  Future<void> deleteAlarm(String id) async {
    final url =
        Uri.https('pill-trucker-default-rtdb.europe-west1.firebasedatabase.app', '/alarms/$id.json',{'auth': authToken});
    final existingAlarmIndex = _alarms.indexWhere((prod) => prod.id == id);
    AlarmItem? existingAlarm = _alarms[existingAlarmIndex];
    _alarms.removeAt(existingAlarmIndex);
    notifyListeners();
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _alarms.insert(existingAlarmIndex, existingAlarm);
      notifyListeners();
      throw HttpException('Could not delete product.');
    }
    existingAlarm = null;
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
