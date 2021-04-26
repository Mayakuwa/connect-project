import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class AddMemberSuccessScreen extends StatelessWidget {
  static const routeName = './add_member_success_member';

  //戻るボタンをつけないよにする。
  @override
  Widget build(BuildContext context) {
    final mamaName = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(title: Text('メンバー追加02')),
      body: Column(
        children: [
          SizedBox(
            height: 100,
            child: FlareActor(
                'images/SuccessCheck.flr',
                alignment: Alignment.center,
                animation: 'Untitled',
                fit: BoxFit.contain
            ),
          ),
          Text(
            '$mamaNameが\n追加されました😍',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          )
        ],
      )
    );
  }
}
