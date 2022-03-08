import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class AlarmItem {
  final String id;
  final String name;
  final List<int> weekDays;
  final String time;
  final String pillId;
  AlarmItem(
      {@required this.id,
      @required this.name,
      @required this.weekDays,
      @required this.time,
      @required this.pillId});
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

  void addItem(String pillId, String name, String time, List<int> weekDays) {
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

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
