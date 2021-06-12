import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connect_project/data/Administrator.dart';
import 'package:connect_project/screens/AddSalaryScreen.dart';
import 'package:connect_project/screens/CheckSalaryScreen.dart';
import 'package:connect_project/screens/EditMemberScreen.dart';
import 'package:connect_project/screens/EditProfileScreen.dart';
import 'package:connect_project/screens/FirstScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:connect_project/widgets/SelectGradationButton.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeScreen extends StatefulWidget {

  static const routeName = './home_screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _auth = FirebaseAuth.instance;
  User _loginUser;
  String userName = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCurrentUser();
  }

  void _getCurrentUser() async {
    try {
      final currentUser =  _auth.currentUser;
      if(currentUser != null) {
        _loginUser = currentUser;
        QuerySnapshot docSnapshot = await FirebaseFirestore.instance.collection('administrators')
            .where('email', isEqualTo: _loginUser.email).get();

        userName = docSnapshot.docs[0].data()['name'];
      }
    } catch(e) {
      print(e);
    }
  }

  //ママのアドレスを入れる
  Future<void>  _showCheckLogoutDialog() async {
    await showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text('ログアウト'),
            content: Text('ログアウトしますか？'),
            actions: <Widget>[
              TextButton(
                child: Text('ログアウトする', style: TextStyle(color: Colors.redAccent),),
                onPressed: () {
                  try {
                    if(_loginUser != null) {
                      _auth.signOut();
                      Navigator.popUntil(
                          context,
                          ModalRoute.withName(FirstScreen.routeName));
                    }
                  } catch(e) {
                    print(e);
                  }
                },
              ),
              TextButton(
                child: Text('キャンセル', style: TextStyle(color: Colors.black38),),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      drawer: Drawer(
        child: Column(children: [
          UserAccountsDrawerHeader(
            accountName: Text(userName),
            accountEmail: Text(_loginUser.email),
            // currentAccountPicture: CircleAvatar(
            //   backgroundColor: Colors.white,
            //   backgroundImage: NetworkImage(""),
            // ),
          ),
          ListTile(
            title: Text("プロフィール編集"),
            trailing: IconButton(
                icon: Icon(Icons.arrow_forward),
                onPressed: () async {
                  await Navigator.pushNamed(
                      context,
                      EditProfileScreen.routeName,
                      arguments: Administrator(
                          name: userName,
                          email: _loginUser.email
                      )
                  );
                },
            ),
          ),
          ListTile(
            title: Text("ログアウト"),
            trailing: IconButton(
                icon: Icon(Icons.logout),
                onPressed: () {
                  Navigator.of(context).pop();
                  _showCheckLogoutDialog();
                },
            ),
          ),
        ]),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            child: Padding(
                padding: EdgeInsets.all(20),
                child: SelectGradationButton(
                  buttonText: '給与データ登録',
                  lightColor: Colors.orange[300],
                  middleColor: Colors.orange[500],
                  darkColor: Colors.orange[700],
                  onPress: () {
                    Navigator.of(context).pushNamed(AddSalaryScreen.routeName);
                  },
                )
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: SelectGradationButton(
                buttonText: 'テストfirstScreen',
                lightColor: Colors.orange[300],
                middleColor: Colors.orange[500],
                darkColor: Colors.orange[700],
                // onPress: () => Navigator.of(context).pushNamed(FirstScreen.routeName),
              )
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Padding(
                padding: EdgeInsets.all(20),
                child: SelectGradationButton(
                  buttonText: '給与データを見る',
                  lightColor: Colors.orange[300],
                  middleColor: Colors.orange[500],
                  darkColor: Colors.orange[700],
                  onPress: () {
                    Navigator.of(context).pushNamed(CheckSalaryScreen.routeName);
                  },
                )
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Padding(
                padding: EdgeInsets.all(20),
                child: SelectGradationButton(
                  buttonText: 'ママを編集',
                  lightColor: Colors.orange[300],
                  middleColor: Colors.orange[500],
                  darkColor: Colors.orange[700],
                  onPress: () {
                    Navigator.of(context).pushNamed(EditMemberScreen.routeName);
                  },
                )
            ),
          )
        ],
      ),
    );
  }
}

