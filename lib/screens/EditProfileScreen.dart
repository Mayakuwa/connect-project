import 'package:connect_project/data/Administrator.dart';
import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {

  static const routeName = './edit_profile_screen';

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {

  @override
  Widget build(BuildContext context) {
    final Administrator arg = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(title: Text('プロフィール編集')
      ),
      body: Column(
        children: [
          Text(arg.name),
          Text(arg.email)
        ],
      ),
    );
  }
}
