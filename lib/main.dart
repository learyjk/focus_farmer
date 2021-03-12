import 'package:flutter/material.dart';
import 'package:focus_farmer/screens/tree_screen.dart';
import 'screens/timer_select_screen.dart';

//Icons made by Freepik https://www.freepik.comfrom https://www.flaticon.com/

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Focus Farmer',
        theme: ThemeData(
          primarySwatch: Colors.lightGreen,
          fontFamily: 'Inter',
          textTheme: ThemeData.light().textTheme.copyWith(
                bodyText1: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 20,
                ),
                headline2: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87),
                headline3: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87),
                headline6: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87),
              ),
        ),
        home: TimerSelectScreen(),
        routes: {
          TimerSelectScreen.routeName: (ctx) => TimerSelectScreen(),
          TreeScreen.routeName: (ctx) => TreeScreen(),
        });
  }
}
