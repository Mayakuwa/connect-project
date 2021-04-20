import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
            title: const Text('Home'),
            actions: <Widget>[
            IconButton(
                icon: Icon(Icons.settings, color: Colors.white),
                onPressed: () {})
          ],
        ),
        body: Center(
          child: Text('This is the home')
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => print('hello'),
          tooltip: 'Hello world',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

