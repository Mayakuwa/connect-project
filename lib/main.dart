import 'package:connect_project/screens/AddMemberSuccessScreen.dart';
import 'package:connect_project/screens/AddSalaryNextScreen.dart';
import 'package:connect_project/screens/AddSalaryScreen.dart';
import 'package:connect_project/screens/AddSalarySuccessScreen.dart';
import 'package:connect_project/screens/CheckSalaryDetailScreen.dart';
import 'package:connect_project/screens/CheckSalaryScreen.dart';
import 'package:connect_project/screens/DeleteMemberScreen.dart';
import 'package:connect_project/screens/EditProfileScreen.dart';
import 'package:connect_project/screens/EditSalaryScreen.dart';
import 'package:connect_project/screens/EditSalarySuccessScreen.dart';
import 'package:connect_project/screens/EditSararyDetailScreen.dart';
import 'package:connect_project/screens/FirstScreen.dart';
import 'package:connect_project/screens/LoginScreen.dart';
import 'package:connect_project/screens/RegisterScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'screens/HomeScreen.dart';
import 'screens/AddMemberScreen.dart';
import 'screens/EditMemberScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _auth = FirebaseAuth.instance;

void main() async {
  //Firebaseをアプリ全体で初期化
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  print('${_auth.currentUser} is exist!!');
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
      home: _auth.currentUser != null ? HomeScreen() : FirstScreen(),
      initialRoute: _auth.currentUser != null ? HomeScreen.routeName : FirstScreen.routeName,
      routes: {
        HomeScreen.routeName: (ctx) => HomeScreen(),
        AddMemberScreen.routeName: (ctx) => AddMemberScreen(),
        EditMemberScreen.routeName: (ctx) => EditMemberScreen(),
        DeleteMemberScreen.routeName: (ctx) => DeleteMemberScreen(),
        AddMemberSuccessScreen.routeName: (ctx) => AddMemberSuccessScreen(),
        AddSalaryScreen.routeName: (ctx) => AddSalaryScreen(),
        AddSalaryNextScreen.routeName: (ctx) => AddSalaryNextScreen(),
        AddSalarySuccessScreen.routeName: (ctx) => AddSalarySuccessScreen(),
        CheckSalaryScreen.routeName: (ctx) => CheckSalaryScreen(),
        EditSalaryScreen.routeName: (ctx) => EditSalaryScreen(),
        CheckSalaryDetailScreen.routeName: (ctx) => CheckSalaryDetailScreen(),
        EditSalaryDetailScreen.routeName: (ctx) => EditSalaryDetailScreen(),
        EditSalarySuccessScreen.routeName: (ctx) => EditSalarySuccessScreen(),
        FirstScreen.routeName: (ctx) => FirstScreen(),
        RegisterScreen.routeName: (ctx) => RegisterScreen(),
        LoginScreen.routeName: (ctx) => LoginScreen(),
        EditProfileScreen.routeName: (ctx) => EditProfileScreen(),
      },
    );
  }
}

