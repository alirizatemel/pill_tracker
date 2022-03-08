import 'package:flutter/material.dart';

class AlarmScreen extends StatefulWidget {
  static const routeName = '/alarm';
  AlarmScreen();

  @override
  _AlarmScreenState createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Alarms'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          TextField(
            decoration: InputDecoration(labelText: 'Drug Name'),
          ),
          TextField(
            decoration: InputDecoration(labelText: 'Milligram'),
          ),
          Text(
            'Or',
            style: TextStyle(fontSize: 28),
            textAlign: TextAlign.center,
          ),
          TextField(
            decoration: InputDecoration(labelText: 'SCAN QR CODE'),
          ),
          ElevatedButton(
            child: Text('Save'),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
