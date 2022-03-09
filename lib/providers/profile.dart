import 'package:flutter/material.dart';

class Profile with ChangeNotifier {
  final String id;
  final String fullName;
  final DateTime birthDate;
  final String alergens;
  Profile(
      {required this.id,
    required this.fullName,
    required this.birthDate,
    required this.alergens});
}
