import 'package:flutter/material.dart';
import 'package:pill_tracker/screens/alarm.dart';
import 'package:pill_tracker/screens/profile.dart';

class MainDrawer extends StatelessWidget {
  Widget buildListTile(String title, IconData icon, VoidCallback tapHandler) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontFamily: 'RobotoCondensed',
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: tapHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            height: 120,
            width: double.infinity,
            padding: EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            color: Theme.of(context).accentColor,
            child: Text(
              'health for everyone!',
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 30,
                  color: Theme.of(context).primaryColor),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          buildListTile('Profile', Icons.person, () {
            Navigator.of(context).pushReplacementNamed(ProfileScreen.routeName);
          }),
          buildListTile('Alarms', Icons.alarm, () {
            Navigator.of(context).pushReplacementNamed(AlarmScreen.routeName);
          }),
        ],
      ),
    );
  }
}
