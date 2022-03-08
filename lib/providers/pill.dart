import 'package:flutter/material.dart';

class Pill with ChangeNotifier {
  final String id;
  final String name;
  final String milligram;
  final String qrCode;
  Pill(
      {@required this.id,
      @required this.name,
      @required this.milligram,
      @required this.qrCode});
}
