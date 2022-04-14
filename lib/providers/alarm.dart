import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:mongo_dart/mongo_dart.dart';
import '../utils/constants.dart';
import 'dart:async';

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

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'name': name,
      'weekDays': weekDays,
      'time': time,
      'date': date,
      'duration': duration,
      'pillId': pillId,
      'userId': userId,
      'alarmType': alarmType,
    };
  }
  AlarmItem.fromMap(Map<String, dynamic> map)
      : name = map['name'],
        id = map['_id'],
        weekDays = map['weekDays'],
        time = map['time'],
        date = map['date'],
        duration = map['duration'],
        pillId = map['pillId'],
        userId = map['userId'],
        alarmType = map['alarmType'];
}

class Alarm with ChangeNotifier {
  static var db;
  List<AlarmItem> _alarms = [];
  Map<String, AlarmItem> _items = {};
  Alarm(this._alarms);

  static connect() async {
    db = await Db.create(MONGO_CONN_URL);
    await db.open();
    
  }

  List<AlarmItem> get alarms {
    return [..._alarms];
  }

  int get itemCount {
    return _alarms.length;
  }

  static Future<List<Map<String, dynamic>>> getDocuments() async {
    try {
      print('getDocuments');
      var alarmCollection = db.collection(ALARM_COLLECTION);
      final alarms = await alarmCollection.find().toList();
      print(alarms);
      return alarms;
    } catch (e) {
      print(e);
      return Future.value(e as FutureOr<List<Map<String, dynamic>>>);
    }
  }

  static insert(AlarmItem alarm) async {
    var alarmCollection = db.collection(ALARM_COLLECTION);
    await alarmCollection.insertAll([alarm.toMap()]);
  }

  static update(AlarmItem alarm) async {
    var alarmCollection = db.collection(ALARM_COLLECTION);
    var u = await alarmCollection.findOne({"_id": alarm.id});
    u["name"] = alarm.name;
    await alarmCollection.save(u);
  }

  static delete(String alarmId) async {
    var alarmCollection = db.collection(ALARM_COLLECTION);
    await alarmCollection.remove(where.id(alarmId as ObjectId));
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
