import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connect_project/screens/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:connect_project/widgets/SelectGradationButton.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterScreen extends StatelessWidget {

  static const routeName = './register_screen';
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String _name = '';
  String _email ='';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('メンバー登録'),
      ),
      body: Container(
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: TextField(
                    onChanged: (value) {
                      _name = value;
                    },
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: '名前',
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
                      buttonText: '登録',
                      lightColor: Colors.orange[300],
                      middleColor: Colors.orange[500],
                      darkColor: Colors.orange[700],
                      onPress: () async {
                        // Navigator.of(context).pushNamed();
                        print(_email);
                        print(_password);
                        print(_name);
                        try {
                          final newUser = await _auth.createUserWithEmailAndPassword(
                              email: _email,
                              password: _password
                          );
                          if(newUser != null) {
                            await FirebaseFirestore.instance.
                            collection('administrators').doc().set({
                              'email' : _email,
                              'password': _password,
                              'name' : _name
                            });
                            Navigator.of(context).pushNamed(HomeScreen.routeName);
                          }
                        } catch(e) {
                          //snack barを表示
                          print(e);
                        }
                      },
                    )
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
