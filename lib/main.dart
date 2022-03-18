import 'package:flutter/material.dart';
import 'package:pill_tracker/screens/pill.dart';
import 'package:provider/provider.dart';

import './providers/auth.dart';
import './providers/profile.dart';
import './providers/pills.dart';
import './providers/alarm.dart';

import './screens/tabs_screen.dart';
import './screens/profile.dart';
import 'screens/alarm_screen.dart';
import './screens/auth_screen.dart';
import './screens/splash_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Pills>(
          create: null,
          update: (ctx, auth, previousPills) => Pills(
            auth.token,
            auth.userId,
            // ignore: unnecessary_null_comparison
            previousPills == null ? [] : previousPills.items,
          ),
        ),
        ChangeNotifierProxyProvider<Auth, Alarm>(
          create:null,
          update: (ctx, auth, previousAlarms) => Alarm(
            auth.token,
            auth.userId,
            // ignore: unnecessary_null_comparison
            previousAlarms == null ? [] : previousAlarms.alarms,
          ),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          title: 'pill tracker',
          theme: ThemeData(
            fontFamily: 'Lato', colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.purple).copyWith(secondary: Colors.green[800]),
          ),
          home: auth.isAuth
              ? AlarmScreen()
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (ctx, authResultSnapshot) =>
                      authResultSnapshot.connectionState ==
                              ConnectionState.waiting
                          ? SplashScreen()
                          : AuthScreen(),
                ),
          routes: {
            '/': (ctx) => TabsScreen(),
            AlarmScreen.routeName: (ctx) => AlarmScreen(),
            ProfileScreen.routeName: (ctx) => ProfileScreen(),
            PillScreen.routeName: (ctx) => PillScreen([])
          },
        ),
      ),
    );
  }
}
