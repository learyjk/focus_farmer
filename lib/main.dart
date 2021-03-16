import 'package:flutter/material.dart';
import 'package:focus_farmer/providers/fruit_stack.dart';
import 'package:focus_farmer/screens/tree_screen.dart';
import 'package:provider/provider.dart';
import 'screens/timer_select_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:focus_farmer/screens/about.dart';

//Icons made by Freepik https://www.freepik.comfrom https://www.flaticon.com/

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Open the database and store the reference.

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FruitStack(),
      child: MaterialApp(
          title: 'Focus Farmer',
          //themeMode: ThemeMode.dark,
          darkTheme: ThemeData.dark().copyWith(),
          theme: ThemeData(
            primarySwatch: Colors.green,
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
            AboutScreen.routeName: (ctx) => AboutScreen(),
          }),
    );
  }
}
