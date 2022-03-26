import 'package:flutter/material.dart';
import 'package:pill_tracker/screens/home.dart';
import 'package:provider/provider.dart';

import '../screens/profile.dart';
import '../screens/pill.dart';
import '../providers/auth.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text('For you'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Profile'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(ProfileScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.medical_services),
            title: Text('Pills'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(PillScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.punch_clock),
            title: Text('Home'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(HomeScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed('/');
              
              // Navigator.of(context)
              //     .pushReplacementNamed(UserProductsScreen.routeName);
              Provider.of<Auth>(context, listen: false).logout();
            },
          ),
        ],
      ),
    );
  }
}
