import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/http_exception.dart';
import './pill.dart';

class Pills with ChangeNotifier {
  List<Pill> _items = [];
  final String authToken;
  final String userId;
  Pills(this.authToken, this.userId, this._items);
  List<Pill> get items {
    return [..._items];
  }

  Pill findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  Future<void> fetchAndSetPills() async {
    final url = Uri.https('flutter-update.firebaseio.com', '/Pills.json');
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      final List<Pill> loadedPills = [];
      extractedData.forEach((pillId, pillData) {
        loadedPills.add(Pill(
          id: pillId,
          name: pillData.name,
          milligram: pillData.milligram,
          qrCode: pillData.qrCode,
        ));
      });
      _items = loadedPills;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> addPill(Pill pill) async {
    final url = Uri.https('flutter-update.firebaseio.com', '/Pills.json');
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'name': pill.name,
          'milligram': pill.milligram,
          'qrCode': pill.qrCode,
        }),
      );
      final newPill = Pill(
        name: pill.name,
        milligram: pill.milligram,
        qrCode: pill.qrCode,
        id: json.decode(response.body)['name'],
      );
      _items.add(newPill);
      // _items.insert(0, newPill); // at the start of the list
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> updatePill(String id, Pill newPill) async {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      final url = Uri.https('flutter-update.firebaseio.com', '/Pills/$id.json');
      await http.patch(url,
          body: json.encode({
            'name': newPill.name,
          }));
      _items[prodIndex] = newPill;
      notifyListeners();
    } else {
      print('...');
    }
  }

  Future<void> deletePill(String id) async {
    final url = Uri.https('flutter-update.firebaseio.com', '/Pills/$id.json');
    final existingPillIndex = _items.indexWhere((prod) => prod.id == id);
    var existingPill = _items[existingPillIndex];
    _items.removeAt(existingPillIndex);
    notifyListeners();
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _items.insert(existingPillIndex, existingPill);
      notifyListeners();
      throw HttpException('Could not delete Pill.');
    }
  }
}
