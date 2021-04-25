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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('メンバーを追加'),
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
                autofocus: true,
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
                onPress: () {
                  print('追加');
                },
              ),
            )
          ],
        ),
      )
    );
  }
}
