import 'package:flutter/material.dart';

class SelectGradationButton extends StatelessWidget {

  @required String buttonText;
  @required Color lightColor;
  @required Color middleColor;
  @required Color darkColor;
  @required Function onPress;

  SelectGradationButton({
    this.buttonText,
    this.lightColor,
    this.middleColor,
    this.darkColor,
    this.onPress
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Container(
        alignment: Alignment.center,
        width: 300,
        height: 50,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: <Color>[
                lightColor,
                middleColor,
                darkColor
              ]
          ),
        ),
        padding: const EdgeInsets.all(10),
        child: Text(buttonText, style: TextStyle(color: Colors.white, fontSize: 20)),
      ),
      style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(0)
      ),
      onPressed: onPress,
    );
  }
}