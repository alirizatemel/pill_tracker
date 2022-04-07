import 'package:flutter/material.dart';
import 'package:pill_tracker/screens/home.dart';
import 'package:pill_tracker/screens/pill.dart';
import 'package:provider/provider.dart';

import './providers/pills.dart';
import './providers/alarm.dart';
import './providers/profile.dart';
import './providers/auth.dart';

import './screens/profile.dart';
import './screens/tabs_screen.dart';
import './screens/auth_screen.dart';
import './screens/splash_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Pills>(
          create: (_)=>Pills([])
        ),
        ChangeNotifierProvider<Alarm>(
          create:(_)=>Alarm([])
        ),
      ],
      child: MaterialApp(
          title: 'pill tracker',
          theme: ThemeData(
            fontFamily: 'Lato', colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.purple).copyWith(secondary: Colors.green[800]),
          ),
          home: HomeScreen(),
          routes: {
            // '/': (ctx) => const TabsScreen(),
            HomeScreen.routeName:(ctx)=>HomeScreen(),
            ProfileScreen.routeName: (ctx) => ProfileScreen(),
            PillScreen.routeName: (ctx) => PillScreen([])
          },
        ),
    );
  }
}
