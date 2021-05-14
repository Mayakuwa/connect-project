import 'package:flutter/material.dart';

class CheckSalaryDetailScreen extends StatefulWidget {

  static const routeName = './check_salary_detail_screen';

  @override
  _CheckSalaryDetailScreenState createState() => _CheckSalaryDetailScreenState();
}

class _CheckSalaryDetailScreenState extends State<CheckSalaryDetailScreen> {

  @override
  Widget build(BuildContext context) {
    final mamaName = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(title: Text('$mamaNameの給与詳細')),
    );
  }
}
