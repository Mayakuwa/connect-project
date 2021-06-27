import 'package:connect_project/widgets/SelectGradationButton.dart';
import 'package:flutter/material.dart';

class AddProfileImageScreen extends StatefulWidget {

  static const routeName = './add_profile_image_screen';

  @override
  _AddProfileImageScreenState createState() => _AddProfileImageScreenState();
}

class _AddProfileImageScreenState extends State<AddProfileImageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('写真を変更'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage("https://applimura.com/wp-content/uploads/2019/08/twittericon13.jpg"),
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: SelectGradationButton(
                buttonText: '画像をアップロード',
                lightColor: Colors.orange[300],
                middleColor: Colors.orange[500],
                darkColor: Colors.orange[700],
                onPress: () => print('hello'),
              )
            ),
          )
        ],
      )
    );
  }
}
