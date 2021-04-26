import 'package:connect_project/screens/HomeScreen.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:connect_project/widgets/SelectGradationButton.dart';

class AddMemberSuccessScreen extends StatelessWidget {
  static const routeName = './add_member_success_member';

  //戻るボタンをつけないよにする。
  @override
  Widget build(BuildContext context) {
    final mamaName = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
          title: Text('メンバー追加02'),
          automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: SizedBox(
              height: 100,
              child: FlareActor(
                  'images/SuccessCheck.flr',
                  alignment: Alignment.center,
                  animation: 'Untitled',
                  fit: BoxFit.contain
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              '$mamaNameが\n追加されました😍',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: SelectGradationButton(
              buttonText: '戻る',
              lightColor: Colors.orange[300],
              middleColor: Colors.orange[500],
              darkColor: Colors.orange[700],
              onPress: () {
                Navigator.popUntil(context, ModalRoute.withName(HomeScreen.routeName));
              },
            ),
          )
        ],
      )
    );
  }
}
