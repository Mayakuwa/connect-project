import 'package:connect_project/data/SalaryData.dart';
import 'package:connect_project/screens/AddSalaryScreen.dart';
import 'package:connect_project/screens/HomeScreen.dart';
import 'package:connect_project/widgets/SelectGradationButton.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class AddSalarySuccessScreen extends StatelessWidget {

  static const routeName = './add_salary_success_screen';

  @override
  Widget build(BuildContext context) {
    final SalaryData data = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('給与追加'),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: SizedBox(
              height: 100,
              child: FlareActor(
                'images/SuccessCheck.flr',
                alignment: Alignment.center,
                animation: 'Untitled',
                fit: BoxFit.contain
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
                '${data.mamaName}の\n${data.date}の給与\n${data.salary}円を追加しました😀',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: SelectGradationButton(
              buttonText: '他の給与を登録する',
              lightColor: Colors.orange[300],
              middleColor: Colors.orange[500],
              darkColor: Colors.orange[700],
              onPress: () {
                Navigator.popUntil(context, ModalRoute.withName(AddSalaryScreen.routeName));
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: SelectGradationButton(
              buttonText: 'ホームに戻る',
              lightColor: Colors.orange[300],
              middleColor: Colors.orange[500],
              darkColor: Colors.orange[700],
              onPress: () {
                Navigator.popUntil(context, ModalRoute.withName(HomeScreen.routeName));
              },
            ),
          )
        ],
      ),
    );
  }
}
