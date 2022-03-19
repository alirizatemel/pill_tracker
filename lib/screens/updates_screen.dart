import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';

class UpdatesScreen extends StatefulWidget {
  static const routeName = '/updates';
  UpdatesScreen();
  @override
  _UpdatesScreenState createState() => _UpdatesScreenState();
}

class _UpdatesScreenState extends State<UpdatesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Updates'),
      ),
      drawer: AppDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          TextField(
            decoration: InputDecoration(labelText: 'Updates'),
          ),
        ],
      ),
    );
  }
}
