import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connect_project/screens/EditSararyDetailScreen.dart';
import 'package:connect_project/widgets/LineGraph.dart';
import 'package:flutter/material.dart';
import 'package:connect_project/data/SalaryData.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:connect_project/data/SalesData.dart';
import 'package:intl/intl.dart';


class CheckSalaryDetailScreen extends StatefulWidget {

  static const routeName = './check_salary_detail_screen';

  @override
  _CheckSalaryDetailScreenState createState() => _CheckSalaryDetailScreenState();
}

class _CheckSalaryDetailScreenState extends State<CheckSalaryDetailScreen> {

  // nullpoを防ぐために初期値を入れておく
  String _mamaName = '';
  String _mamaId = 'none';
  List<SalaryData> _salaryData = [
    SalaryData(date: '2015年5月', salary: '5000')
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future(() async {
      _mamaName = ModalRoute.of(context).settings.arguments;
      final mamaRef = await FirebaseFirestore.instance.
        collection('members').where('name', isEqualTo: _mamaName).
        get().then((value) => value.docs.reversed.first.id);
        setState(() {
          _mamaId = mamaRef;
        });

      DateFormat outPutYear = DateFormat('yyyy');
      DateFormat outPutMonth = DateFormat('MM');

      QuerySnapshot salaryData = await FirebaseFirestore.instance.
      collection('salaries').doc(_mamaId).collection('all-salary').get();
      for(var i = 0; i < salaryData.docs.length; i++) {
        _salaryData.add(
            SalaryData(
            date: salaryData.docs[i].data()['date'],
            salary: salaryData.docs[i].data()['salary'],
            dateTime: DateTime(
                int.parse(outPutYear.format(
                salaryData.docs[i].data()['dateTime'].toDate())),
                int.parse(outPutMonth.format(
                salaryData.docs[i].data()['dateTime'].toDate()))
            )
        ));
        // print(salaryData.docs[i].data()['date'],);
        // print(salaryData.docs[i].data()['salary'],);
        // print(salaryData.docs[i].data()['dateTime']);
        // print(DateTime(
        //     int.parse(outPutYear.format(
        //         salaryData.docs[i].data()['dateTime'].toDate())),
        //     int.parse(outPutMonth.format(
        //         salaryData.docs[i].data()['dateTime'].toDate()))
        // ));
      }

      //テスト
      // final test = FirebaseFirestore.instance.
      // collection('salaries').doc(_mamaId).collection('all-salary').orderBy('dateTime', descending: true).snapshots();
      // test.forEach((element) {
      //   element.docs.reversed.forEach((e) {
      //     print(e.data());
      //   });
      // }
      // );
    });
  }


  void getMamaIdFromFirestore() async {
      final String mamaRef =  await FirebaseFirestore.instance.
                    collection('members').where('name', isEqualTo: _mamaName).
                    get().then((value) => value.docs.reversed.first.id);
      setState(() {
        _mamaId = mamaRef;
      });
    }

    //年と月を分割し、listとして返す。
    List<String> getMonthAndYearToInt(String date) {
      RegExp exp = new RegExp(r'^(.+)年(.+)月$');
      Match match = exp.firstMatch(date);
      List<String> yearMonth = [match.group(1), match.group(2)];
      return yearMonth;
    }
    
    //給料データ(String)から数値のみを取り出す。
    int getOnlyDigitSalary(String salary) {
      RegExp exp = new RegExp(r'^(.+)円$');
      Match match = exp.firstMatch(salary);
      String intSalary = match.group(1);
      return int.parse(intSalary);
    }


  final data = [
    new SalesData(0, 1500000),
    new SalesData(1, 1735000),
    new SalesData(2, 1678000),
    new SalesData(3, 1890000),
    new SalesData(4, 1907000),
    new SalesData(5, 2300000),
    new SalesData(6, 2360000),
    new SalesData(7, 1980000),
    new SalesData(8, 2654000),
    new SalesData(9, 2789070),
    new SalesData(10, 3020000),
    new SalesData(11, 3245900),
    new SalesData(12, 4098500),
    new SalesData(13, 4500000),
    new SalesData(14, 4456500),
    new SalesData(15, 3900500),
    new SalesData(16, 5123400),
    new SalesData(17, 5589000),
    new SalesData(18, 5940000),
    new SalesData(19, 6367000),
  ];

  _getSeriesData() {
    List<charts.Series<SalaryData, int>> series = [
      charts.Series(
          id: "Sales",
          data: _salaryData,
          //横軸
          domainFn: (SalaryData series, _) => int.parse(getMonthAndYearToInt(series.date)[1]),
          //縦軸
          measureFn: (SalaryData series, _) => int.parse(series.salary),
          colorFn: (SalaryData series, _) => charts.MaterialPalette.blue.shadeDefault
      )
    ];
    return series;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('$_mamaNameの給与詳細')),
      body: Column(
        children: [
          // show graph
          // Container(
          //   width: 400,
          //   height: 400,
          //   child: Card(
          //     child: Container(
          //       padding: EdgeInsets.all(10),
          //       child: LineGraph.withDate(
          //           FirebaseFirestore.instance
          //               .collection('salaries').doc(_mamaId).collection('all-salary')
          //               .orderBy('dateTime', descending: true).snapshots()),
          //     ),
          //   )
          //     // child: new charts.LineChart(
          //     //   _getSeriesData(),
          //     //   animate: true,
          //     // ),
          // ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.
                      collection('salaries').doc(_mamaId).collection('all-salary').orderBy('dateTime', descending: true).snapshots(),
              builder: (context, snapshot) {
                if(snapshot.hasError) {
                  return Text('エラーが発生しました');
                }
                if(snapshot.hasData) {
                  final List<DocumentSnapshot> documents = snapshot.data.docs;
                  return ListView(
                    children: documents.map((document) {
                      return Card(
                          child: ListTile(
                            title: Text(document['date']),
                            subtitle: Text('${document['salary']}円'),
                            trailing: IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                List<String> yearMonth = getMonthAndYearToInt(document['date']);
                                getMonthAndYearToInt(document['date']);
                                Navigator.pushNamed(
                                    context,
                                    EditSalaryDetailScreen.routeName,
                                    arguments: SalaryData(
                                        mamaName: _mamaName,
                                        date: document['date'],
                                        salary: document['salary'],
                                        year: int.parse(yearMonth[0]),
                                        month: int.parse(yearMonth[1])
                                    )
                                );
                              },
                            ),
                          ),
                      );
                    }).toList(),
                  );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
