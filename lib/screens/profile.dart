import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  static const routeName = '/profile';
  ProfileScreen();
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          TextField(
            decoration: InputDecoration(labelText: 'Full Name'),
          ),
          TextField(
            decoration: InputDecoration(labelText: 'Birth Date'),
          ),
          TextField(
            decoration: InputDecoration(labelText: 'Allergens'),
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
