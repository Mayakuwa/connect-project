import 'package:connect_project/screens/AddSalaryScreen.dart';
import 'package:connect_project/screens/CheckSalaryScreen.dart';
import 'package:connect_project/screens/EditMemberScreen.dart';
import 'package:flutter/material.dart';
import 'package:connect_project/widgets/SelectGradationButton.dart';

class HomeScreen extends StatelessWidget {

  static const routeName = './home_screen';

  // それぞれのボタンを長押ししたら、snackBarを使って表記説明
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        //バックボタンを消す
        automaticallyImplyLeading: false,
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
                buttonText: '給与データ編集',
                lightColor: Colors.orange[300],
                middleColor: Colors.orange[500],
                darkColor: Colors.orange[700],
                onPress: () => print('good bye'),
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
                  buttonText: 'メンバー編集',
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

