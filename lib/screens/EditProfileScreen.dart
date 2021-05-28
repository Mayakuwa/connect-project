import 'package:connect_project/data/Administrator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:connect_project/widgets/SelectGradationButton.dart';

class EditProfileScreen extends StatefulWidget {

  static const routeName = './edit_profile_screen';

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {

  String name = "";
  String email = "";
  final FirebaseAuth auth = FirebaseAuth.instance;

  _EditProfileScreenState({this.email, this.name});

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      final Administrator dataRef = ModalRoute.of(context).settings.arguments;
      setState(() {
        name = dataRef.name;
        email = dataRef.email;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final Administrator arg = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(title: Text('プロフィール編集')
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: TextField(
                controller: TextEditingController(text: name),
                onChanged: (value) {
                  name = value;
                },
                textAlign: TextAlign.center,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: TextField(
                controller: TextEditingController(text: email),
                onChanged: (value) {
                  email = value;
                },
                textAlign: TextAlign.center,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Padding(
                padding: EdgeInsets.all(20),
                child: SelectGradationButton(
                  buttonText: '編集',
                  lightColor: Colors.orange[300],
                  middleColor: Colors.orange[500],
                  darkColor: Colors.orange[700],
                  onPress: () {
                    try {
                      //メールアドレスと、名前を変更する。
                      final currentUser = auth.currentUser;
                      currentUser.updateEmail(email).then(
                              (value) => print('success')
                      ).catchError((e) => print(e));
                    } catch(e) {

                    }
                  },
                )
            ),
          ),
        ],
      ),
    );
  }
}
