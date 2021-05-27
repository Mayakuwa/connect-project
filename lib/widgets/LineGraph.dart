import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connect_project/data/SalaryData.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:intl/intl.dart';


//ファクトリーを使わず書き換えてみる。(staticにしてみる？)
class LineGraph extends StatefulWidget  {

  @override
  _LineGraphState createState() => _LineGraphState();

  final List<charts.Series> seriesList;
  final bool animate;


  LineGraph(this.seriesList, {this.animate});

  //factory methodを使う
  factory LineGraph.withDate(Stream<QuerySnapshot> snapshot) {
    return new LineGraph(
      _createData(snapshot),
      animate: false,
    );
  }


  //firestoreから受けとったデータの配列を入れる。　引数をQuerySnapShotにしてみる
  static List<charts.Series<SalaryData, DateTime>> _createData(Stream<QuerySnapshot> snapshot) {

    //テストデータ
    final testdata = [
      new SalaryData(dateTime: new DateTime(2020, 7), salary: '100'),
      new SalaryData(dateTime: new DateTime(2020, 8), salary: '200'),
      new SalaryData(dateTime: new DateTime(2020, 9), salary: '300'),
      new SalaryData(dateTime: new DateTime(2020, 10), salary: '400'),
    ];


    List<SalaryData> _createList(Stream<QuerySnapshot> snapshot)  {
      List<SalaryData> data = [];
      snapshot.forEach((element) {
        List<SalaryData> test = [];
        element.docs.reversed.forEach((e) {
          //タイムスタンプを日付に変換
          if(e.data()['dateTime'] is Timestamp) {
            DateTime dateTime = e.data()['dateTime'].toDate();

            DateFormat outPutDateYearMonth = DateFormat('yyyy-MM');

            DateFormat outPutDateYear = DateFormat('yyyy');

            DateFormat outPutDateMonth = DateFormat('MM');

            test.add(SalaryData(
                dateTime: DateTime(int.parse(outPutDateYear.format(dateTime)),
                    int.parse(outPutDateMonth.format(dateTime))),
                salary: e.data()['salary']
            ));
          }
        });
        print(test.reversed.first.dateTime);
        print(test.reversed.first.salary);

        data = test;

        print(data.reversed.first.dateTime);
        print(data.reversed.first.salary);
        print('配列${data.length}個');
      });
      print('配列${data.length}個');
      return data;
    }

    // snapshot.forEach((element) {
    //   List<SalaryData> ref = [];
    //   element.docs.reversed.forEach((e) {
    //     //タイムスタンプを日付に変換
    //     if(e.data()['dateTime'] is Timestamp) {
    //       DateTime dateTime = e.data()['dateTime'].toDate();
    //
    //       DateFormat outPutDateYearMonth = DateFormat('yyyy-MM');
    //
    //       DateFormat outPutDateYear = DateFormat('yyyy');
    //
    //       DateFormat outPutDateMonth = DateFormat('MM');
    //
    //       ref.add(SalaryData(
    //           dateTime: DateTime(int.parse(outPutDateYear.format(dateTime)),
    //               int.parse(outPutDateMonth.format(dateTime))),
    //           salary: e.data()['salary']
    //       ));
    //     }
    //   });
    //   print(ref.reversed.first.dateTime);
    //   print(ref.reversed.first.salary);
    // });


    return [
      new charts.Series<SalaryData, DateTime>(
          id: 'Salary',
          colorFn: (_, __) => charts.MaterialPalette.deepOrange.shadeDefault,
          domainFn: (SalaryData dates, _) => dates.dateTime,
          measureFn: (SalaryData dates, _) => int.parse(dates.salary),
          data: _createList(snapshot),
      )
    ];
  }
}

class _LineGraphState extends State<LineGraph> {

  @override
  Widget build(BuildContext context) {
    return new charts.TimeSeriesChart(
      widget.seriesList,
      animate: widget.animate,
      dateTimeFactory: const charts.LocalDateTimeFactory(),
    );
  }
}


