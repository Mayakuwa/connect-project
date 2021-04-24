import 'package:flutter/material.dart';

class AddMemberScreen extends StatefulWidget {

  static const routeName = '/add_member_screen';

  @override
  _AddMemberScreenState createState() => _AddMemberScreenState();
}

class _AddMemberScreenState extends State<AddMemberScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('メンバーを追加'),
      ),
      body: Column(
        
      ),
    );
  }
}
