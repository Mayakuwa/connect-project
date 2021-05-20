import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connect_project/data/SalaryData.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:intl/intl.dart';

//ファクトリーを使わず書き換えてみる。
class LineGraph extends StatelessWidget {

  final List<charts.Series> seriesList;
  final bool animate;

  LineGraph(this.seriesList, {this.animate});

  //factory methodを使う
  factory LineGraph.withDate(Stream<QuerySnapshot> snapshot) {
    return new LineGraph(
      _createData(snapshot),
      animate: false
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

    List<SalaryData> data = [];


    snapshot.forEach((element) {
      element.docs.reversed.forEach((e) {
        //タイムスタンプを日付に変換
        if(e.data()['dateTime'] is Timestamp) {
          DateTime dateTime = e.data()['dateTime'].toDate();

          DateFormat outPutDateYearMonth = DateFormat('yyyy-MM');

          DateFormat outPutDateYear = DateFormat('yyyy');

          DateFormat outPutDateMonth = DateFormat('MM');

          String formalTime = outPutDateYearMonth.format(dateTime);
          // 年
          // print(int.parse(outPutDateYear.format(dateTime)));
          // 月
          // print(int.parse(outPutDateMonth.format(dateTime)));
          // 年と月
          // print(formalTime);
          data.add(
              SalaryData(
                  dateTime: DateTime(int.parse(outPutDateYear.format(dateTime)), int.parse(outPutDateMonth.format(dateTime))),
                  salary: e.data()['salary']
            ));
          print(data.reversed.first.dateTime);
        }
      });
      print(data.reversed.first.date);
    });

    // print(data);
    
    // _getAllData() {
    //   List<charts.Series<SalaryData, String>> series = [
    //     charts.Series(
    //       id: 'Salary',
    //       data: data,
    //       measureFn: (SalaryData dates, _) => int.parse(dates.salary),
    //       domainFn: (SalaryData dates, _) => dates.date,
    //       colorFn: (_, __) => charts.MaterialPalette.deepOrange.shadeDefault,
    //     )
    //   ];
    //   return series;
    // }

    
    return [
      new charts.Series<SalaryData, DateTime>(
          id: 'Salary',
          colorFn: (_, __) => charts.MaterialPalette.deepOrange.shadeDefault,
          domainFn: (SalaryData dates, _) => dates.dateTime,
          measureFn: (SalaryData dates, _) => int.parse(dates.salary),
          data: data,
      )
    ];
  }


  @override
  Widget build(BuildContext context) {
    return new charts.TimeSeriesChart(
      seriesList,
      animate: animate,
      dateTimeFactory: const charts.LocalDateTimeFactory(),
    );
  }
}


