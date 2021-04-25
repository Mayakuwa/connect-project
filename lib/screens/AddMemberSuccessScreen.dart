import 'package:flutter/material.dart';

class AddMemberSuccessScreen extends StatelessWidget {
  static const routeName = './add_member_success_member';

  @override
  Widget build(BuildContext context) {
    final mamaName = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(title: Text('メンバー追加02')),
      body: Column(
        children: [
          Text(mamaName)
        ],
      )
    );
  }
}
