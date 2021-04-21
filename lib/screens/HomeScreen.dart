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
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: ElevatedButton(
                child: Container(
                  alignment: Alignment.center,
                  width: 300,
                  height: 50,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: <Color>[
                        Colors.orange[300],
                        Colors.orange[500],
                        Colors.orange[700]
                      ]
                    ),
                  ),
                  padding: const EdgeInsets.all(10),
                  child: const Text('Gradient Button', style: TextStyle(color: Colors.white)),
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(0)
                ),
              )
              
            ),
          )
        ],
      ),
    );
  }
}
