import 'package:connect_project/screens/HomeScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:connect_project/widgets/SelectGradationButton.dart';

class LoginScreen extends StatelessWidget {

  static const routeName = './login_screen';
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String _email = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ログイン'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: TextField(
                onChanged: (value) {
                  _email = value;
                },
                textAlign: TextAlign.center,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    hintText: 'メールアドレス',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: TextField(
                onChanged: (value) {
                  _password = value;
                },
                textAlign: TextAlign.center,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'パスワード',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Padding(
                padding: EdgeInsets.all(20),
                child: SelectGradationButton(
                  buttonText: 'ログイン',
                  lightColor: Colors.orange[300],
                  middleColor: Colors.orange[500],
                  darkColor: Colors.orange[700],
                  onPress: () async {
                    try {
                      final existUser = await _auth.signInWithEmailAndPassword(
                          email: _email,
                          password: _password);

                      if(existUser != null) {
                        Navigator.of(context).pushNamed(HomeScreen.routeName);
                      }
                    } catch (e) {
                      print(e);
                    }
                    // Navigator.of(context).pushNamed();
                  },
                )
            ),
          ),
        ],
      ),
    );
  }
}
