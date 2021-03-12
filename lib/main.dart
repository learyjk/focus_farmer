import 'package:flutter/material.dart';
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
      ),
      home: TimerSelectScreen(),
    );
  }
}
