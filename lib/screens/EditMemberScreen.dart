import 'package:connect_project/screens/AddMemberScreen.dart';
import 'package:connect_project/screens/DeleteMemberScreen.dart';
import 'package:flutter/material.dart';
import 'package:connect_project/widgets/SelectGradationButton.dart';

class EditMemberScreen extends StatelessWidget {

  static const routeName = '/edit_member_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('メンバーを編集'),
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
                buttonText: 'メンバー登録',
                lightColor: Colors.red[300],
                middleColor: Colors.red[500],
                darkColor: Colors.red[700],
                onPress: () {
                  Navigator.of(context).pushNamed(AddMemberScreen.routeName);
                },
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: SelectGradationButton(
                buttonText: 'メンバー削除',
                lightColor: Colors.red[300],
                middleColor: Colors.red[500],
                darkColor: Colors.red[700],
                onPress: () {
                  Navigator.of(context).pushNamed(DeleteMemberScreen.routeName);
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
