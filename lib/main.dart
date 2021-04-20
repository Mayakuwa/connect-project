import 'package:flutter/material.dart';
import 'screens/HomeScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Connect-App',
      theme: ThemeData(
        primaryTextTheme: TextTheme(
          headline6: TextStyle(
            color: Colors.white
          )
        ),
        primaryColor: Colors.amber,
        accentColor: Colors.lightGreenAccent,
      ),
      home: HomeScreen(),
      initialRoute: HomeScreen.routeName,
      routes: {
        HomeScreen.routeName: (ctx) => HomeScreen()
      },
    );
  }
}

