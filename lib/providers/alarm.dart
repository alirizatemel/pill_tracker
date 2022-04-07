import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:pill_tracker/screens/new_alarm.dart';
import '../models/http_exception.dart';

enum AlarmType { Date, All }

class AlarmItem {
  final String id;
  final String name;
  final String weekDays;
  final String time;
  final String date;
  final String duration;
  final String pillId;
  final String userId;
  final String alarmType;
  AlarmItem(
      {required this.id,
      required this.name,
      required this.weekDays,
      required this.time,
      required this.date,
      required this.duration,
      required this.pillId,
      required this.userId,
      required this.alarmType});
}

class Alarm with ChangeNotifier {
  List<AlarmItem> _alarms = [];
  Map<String, AlarmItem> _items = {};
  Alarm(this._alarms);

  List<AlarmItem> get alarms {
    return [..._alarms];
  }

  int get itemCount {
    return _alarms.length;
  }

  Future<void> fetchAndSetAlarms(
    DateTime date,
  ) async {
    final weekDay = date.weekday;
    // var filterString = 'orderBy="userId"&equalTo="$userId"';
    // var filterString = '?orderBy="userId"&equalTo="123"';
    var filterString = '';
    // Map<String, String> queryParams = {
    //   'auth': authToken,
    //   'orderBy': 'userId',
    //   'equalTo': '123',
    //   // 'orderBy': 'weekDay',
    //   // 'equalTo': 'pzt.'
    // };
    var url = Uri.https(
        'pill-trucker-default-rtdb.europe-west1.firebasedatabase.app',
        '/alarms.json' + filterString);
    try {
      final response = await http.get(url);
      
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      
      if (extractedData == null) {
        return;
      }
      
      final List<AlarmItem> loadedAlarms = [];
      extractedData.forEach((alarmId, alarmData) {
        loadedAlarms.add(AlarmItem(
          id: 'asdas',
          name: alarmData['name'] ,
          weekDays: alarmData['weekDays'],
          time: alarmData['time'] ,
          date: alarmData['date'] ,
          duration: alarmData['duration'],
          pillId: alarmData['pillId'] ,
          userId: alarmData['userId'] ,
          alarmType: alarmData['type'],
        ));
      });
      _alarms = loadedAlarms;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> addAlarm(AlarmItem alarm) async {
    final url = Uri.https(
        'pill-trucker-default-rtdb.europe-west1.firebasedatabase.app',
        '/alarms.json',
        // {'auth': authToken}
        );
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'name': alarm.name,
          'weekDays': alarm.weekDays,
          'time': alarm.time,
          'date': alarm.date,
          'duration': alarm.duration,
          'pillId': alarm.pillId,
          'userId': alarm.userId,
          'alarmType': alarm.alarmType,
        }),
      );
      final newAlarm = AlarmItem(
        name: alarm.name,
        weekDays: alarm.weekDays,
        time: alarm.time,
        date: alarm.date,
        duration: alarm.duration,
        pillId: alarm.pillId,
        userId: alarm.userId,
        alarmType: alarm.alarmType,
        id: json.decode(response.body)['name'],
      );
      _alarms.add(newAlarm);
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> deleteAlarm(String id) async {
    final url = Uri.https(
        'pill-trucker-default-rtdb.europe-west1.firebasedatabase.app',
        '/alarms/$id.json',
        // {'auth': authToken}
        );
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
