import 'package:flutter/material.dart';

class AddSalaryNextScreen extends StatefulWidget {

  static const routeName = './add_salary_next_screen';

  @override
  _AddSalaryNextScreenState createState() => _AddSalaryNextScreenState();
}

class _AddSalaryNextScreenState extends State<AddSalaryNextScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('給与追加'),
      ),
    );
  }
}
