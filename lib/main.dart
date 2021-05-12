import 'package:connect_project/screens/AddMemberSuccessScreen.dart';
import 'package:connect_project/screens/AddSalaryNextScreen.dart';
import 'package:connect_project/screens/AddSalaryScreen.dart';
import 'package:connect_project/screens/AddSalarySuccessScreen.dart';
import 'package:connect_project/screens/CheckSalaryScreen.dart';
import 'package:connect_project/screens/DeleteMemberScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'screens/HomeScreen.dart';
import 'screens/AddMemberScreen.dart';
import 'screens/EditMemberScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
        accentColor: Colors.amberAccent,
        //バックボタンを白に設定
        primaryIconTheme: IconThemeData(color: Colors.white)
      ),
      home: HomeScreen(),
      initialRoute: HomeScreen.routeName,
      routes: {
        HomeScreen.routeName: (ctx) => HomeScreen(),
        AddMemberScreen.routeName: (ctx) => AddMemberScreen(),
        EditMemberScreen.routeName: (ctx) => EditMemberScreen(),
        DeleteMemberScreen.routeName: (ctx) => DeleteMemberScreen(),
        AddMemberSuccessScreen.routeName: (ctx) => AddMemberSuccessScreen(),
        AddSalaryScreen.routeName: (ctx) => AddSalaryScreen(),
        AddSalaryNextScreen.routeName: (ctx) => AddSalaryNextScreen(),
        AddSalarySuccessScreen.routeName: (ctx) => AddSalarySuccessScreen(),
        CheckSalaryScreen.routeName: (ctx) => CheckSalaryScreen()
      },
    );
  }
}

