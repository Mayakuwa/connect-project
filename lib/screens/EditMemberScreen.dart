import 'package:flutter/material.dart';

class EditMemberScreen extends StatelessWidget {

  static const routeName = '/edit_member_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('メンバーを編集'),
      ),
    );
  }
}
