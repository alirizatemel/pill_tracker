import 'package:flutter/material.dart';

class PillScreen extends StatelessWidget {
  static const routeName = '/pill';
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      width: double.infinity,
      child: Column(
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
