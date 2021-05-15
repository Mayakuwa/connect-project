import 'package:connect_project/data/SalaryData.dart';
import 'package:flutter/material.dart';

class EditSalaryDetailScreen extends StatelessWidget {

  static const routeName = './edit_salary_detail_screen';

  @override
  Widget build(BuildContext context) {
    final SalaryData data = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(title: Text('${data.mamaName}の給与情報編集')),
      body: Center(
        child: Text('${data.salary}円'),
      ),
    );
  }
}
