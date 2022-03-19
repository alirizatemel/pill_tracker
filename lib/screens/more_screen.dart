import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';

class MoreScreen extends StatefulWidget {
  static const routeName = '/more';
  MoreScreen();
  @override
  _MoreScreenState createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('More'),
      ),
      drawer: AppDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Text('Must be menu',
          )
        ],
      ),
    );
  }
}
