import 'package:connect_project/screens/EditMemberScreen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {

  static const routeName = './home_screen';

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
                child: SelectButton(
                  buttonText: '給与データ登録',
                  lightColor: Colors.yellow[300],
                  middleColor: Colors.yellow[500],
                  darkColor: Colors.yellow[700],
                  onPress: () => print('good bye'),
                )
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: SelectButton(
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
                child: SelectButton(
                  buttonText: '給与データを見る',
                  lightColor: Colors.pink[300],
                  middleColor: Colors.pink[500],
                  darkColor: Colors.pink[700],
                  onPress: () => print('good bye'),
                )
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Padding(
                padding: EdgeInsets.all(20),
                child: SelectButton(
                  buttonText: 'メンバー編集',
                  lightColor: Colors.red[300],
                  middleColor: Colors.red[500],
                  darkColor: Colors.red[700],
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

class SelectButton extends StatelessWidget {

  @required String buttonText;
  @required Color lightColor;
  @required Color middleColor;
  @required Color darkColor;
  @required Function onPress;

  SelectButton({
    this.buttonText,
    this.lightColor,
    this.middleColor,
    this.darkColor,
    this.onPress
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Container(
        alignment: Alignment.center,
        width: 300,
        height: 50,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[
              lightColor,
              middleColor,
              darkColor
            ]
          ),
        ),
        padding: const EdgeInsets.all(10),
        child: Text(buttonText, style: TextStyle(color: Colors.white, fontSize: 20)),
      ),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(0)
      ),
      onPressed: onPress,
    );
  }
}
