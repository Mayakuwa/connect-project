import 'package:flutter/material.dart';
import 'package:connect_project/widgets/SelectGradationButton.dart';

class FirstScreen extends StatelessWidget {

  static const routeName = './first_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Image.asset(
                  'images/connect_splash.png',
                  width: 200,
                  height: 200,
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
                  onPress: () {
                    // Navigator.of(context).pushNamed(AddSalaryScreen.routeName);
                  },
                )
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
                  onPress: () {
                    // Navigator.of(context).pushNamed(AddSalaryScreen.routeName);
                  },
                )
            ),
          ),
        ],
      ),
    );
  }
}
