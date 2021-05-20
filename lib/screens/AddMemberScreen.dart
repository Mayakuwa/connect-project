import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connect_project/screens/AddMemberSuccessScreen.dart';
import 'package:flutter/material.dart';
import 'package:connect_project/widgets/SelectGradationButton.dart';

class AddMemberScreen extends StatefulWidget {

  static const routeName = '/add_member_screen';

  @override
  _AddMemberScreenState createState() => _AddMemberScreenState();
}

class _AddMemberScreenState extends State<AddMemberScreen> {

  String _text = "";
  void _changeText(String e) {
    setState(() {
      _text = e;
    });
  }

  void _showSnackBar () {
    final snackBar = SnackBar(
        content: Text('ママの名前が記入されてません😭'),
        action: SnackBarAction(
            label: 'OK',
            onPressed: () {

            }));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ママを追加'),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                  '追加するママの名前を入力してください😀',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 17),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                '$_textママ',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: TextField(
                textAlign: TextAlign.center,
                onChanged: _changeText,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: SelectGradationButton(
                buttonText: 'メンバー登録',
                lightColor: Colors.orange[300],
                middleColor: Colors.orange[500],
                darkColor: Colors.orange[700],
                onPress: () async {
                  if (_text == "") {
                    _showSnackBar();
                  } else {
                    await FirebaseFirestore.instance.
                    collection('members').doc().set({
                      'name': '$_textママ'
                    });
                    Navigator.pushNamed(
                        context,
                        AddMemberSuccessScreen.routeName,
                        arguments: '$_textママ'
                    );
                  }
                },
              ),
            )
          ],
        ),
      )
    );
  }
}
