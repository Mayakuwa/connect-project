import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {

  static const routeName = './home_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Container(
            child: Text('Hello'),
          ),
        ],
      ),
    );
  }
}
