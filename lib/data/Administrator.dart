import 'package:flutter/cupertino.dart';

class Administrator {
  String name;
  String email;
  String password;

  Administrator({
    @required this.name,
    @required this.email,
    this.password
  });
}