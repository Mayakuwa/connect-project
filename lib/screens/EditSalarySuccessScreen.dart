import 'package:connect_project/screens/CheckSalaryScreen.dart';
import 'package:connect_project/screens/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:connect_project/data/SalaryData.dart';
import 'package:connect_project/widgets/SelectGradationButton.dart';
import 'package:flare_flutter/flare_actor.dart';


class EditSalarySuccessScreen extends StatelessWidget {

  static const routeName = './edit_salary_success_screen';

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
              '給与データを編集しました😀',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
                '${data.mamaName}のデータ\n年月：${data.date}\n給与：${data.salary}円',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
              ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: SelectGradationButton(
              buttonText: '他の給与を編集',
              lightColor: Colors.orange[300],
              middleColor: Colors.orange[500],
              darkColor: Colors.orange[700],
              onPress: () {
                Navigator.popUntil(context, ModalRoute.withName(CheckSalaryScreen.routeName));
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
