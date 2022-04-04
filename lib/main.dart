import 'package:flutter/material.dart';
import 'package:pill_tracker/screens/home.dart';
import 'package:pill_tracker/screens/pill.dart';
import 'package:provider/provider.dart';

import './providers/auth.dart';
import './providers/profile.dart';
import './providers/pills.dart';
import './providers/alarm.dart';

import './screens/tabs_screen.dart';
import './screens/profile.dart';
import './screens/auth_screen.dart';
import './screens/splash_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create:(_)=> Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Pills>(
          create: (_)=>Pills('','',[]),
          update: (ctx, auth, previousPills) => Pills(
            auth.token,
            auth.userId,
            // ignore: unnecessary_null_comparison
            previousPills == null ? [] : previousPills.items,
          ),
        ),
        ChangeNotifierProxyProvider<Auth, Alarm>(
          create:(_)=>Alarm('','',[]),
          update: (_, auth, previousAlarms) => Alarm(
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
              ? HomeScreen()
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (ctx, authResultSnapshot) =>
                      authResultSnapshot.connectionState ==
                              ConnectionState.waiting
                          ? SplashScreen()
                          : AuthScreen(),
          ),
          routes: {
            // '/': (ctx) => const TabsScreen(),
            HomeScreen.routeName:(ctx)=>HomeScreen(),
            ProfileScreen.routeName: (ctx) => ProfileScreen(),
            PillScreen.routeName: (ctx) => PillScreen([])
          },
        ),
      ),
    );
  }
}
