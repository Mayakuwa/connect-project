import 'package:connect_project/widgets/SelectGradationButton.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:connect_project/data/Administrator.dart';

class AddProfileImageScreen extends StatefulWidget {

  static const routeName = './add_profile_image_screen';

  @override
  _AddProfileImageScreenState createState() => _AddProfileImageScreenState();

}

class _AddProfileImageScreenState extends State<AddProfileImageScreen> {

  final _imagePicker = ImagePicker();
  File _image;
  String _imageUrl = "https://applimura.com/wp-content/uploads/2019/08/twittericon13.jpg";
  //asset image だったらtrue,default imageだったらfalse
  bool _checkCustomImage = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      final Administrator dataRef = ModalRoute.of(context).settings.arguments;
      setState(() {
        _imageUrl = dataRef.imageUrl;
        if(_imageUrl != "https://applimura.com/wp-content/uploads/2019/08/twittericon13.jpg") {
          _checkCustomImage = true;
        }
      });
    });
  }
  //permission check
  // Future<bool> checkAndRequestPermission() async {
  //   var permissionStatus = await Permission.photos.status;
  //   if(permissionStatus.isDenied) {
  //       print(true);
  //       return true;
  //   }
  //   return false;
  // }

  Future updateImageFromLibrary() async {

    var status = await Permission.photos.status;
    if (status == PermissionStatus.denied) {
      // 一度もリクエストしてないので権限のリクエスト.
      status = await Permission.photos.request();
    }
    // 権限がない場合の処理.
    if (status.isDenied ||
        status.isRestricted ||
        status.isPermanentlyDenied) {
      // 端末の設定画面へ遷移.
      await openAppSettings();
    }

    var pickedFile = await _imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _checkCustomImage = true;
      if (pickedFile != null) {
        _imageUrl = pickedFile.path;
        print(_imageUrl);
      } else {
        print('No image selected.');
      }
    });
    // File file = File(pickedFile.path);
    // print(file);
  }

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
              child: GestureDetector(
                onTap: () => print("hello"),
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: _checkCustomImage ? AssetImage(_imageUrl) : NetworkImage(_imageUrl),
                ),
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.all(20),
              // image picker pubgetを使う
              child: SelectGradationButton(
                buttonText: '画像をアップロード',
                lightColor: Colors.orange[300],
                middleColor: Colors.orange[500],
                darkColor: Colors.orange[700],
                onPress: () => updateImageFromLibrary(),
              )
            ),
          )
        ],
      )
    );
  }
}
