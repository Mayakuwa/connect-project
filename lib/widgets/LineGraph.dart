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

  //firestoreから受けとったデータの配列を入れる。
  static List<charts.Series<SalaryData, DateTime>> _createData(Stream<QuerySnapshot> snapshot) {
    final data = [
      new SalaryData(dateTime: new DateTime(2020, 7, 19), salary: '100'),
      new SalaryData(dateTime: new DateTime(2020, 8,20), salary: '200'),
      new SalaryData(dateTime: new DateTime(2020, 9,21), salary: '300'),
      new SalaryData(dateTime: new DateTime(2020, 10,22), salary: '400'),
    ];

    // snapshot.forEach((element) {
    //   element.docs.reversed.forEach((e) {
    //     //タイムスタンプを日付に変換
    //     if(e.data()['dateTime'] is Timestamp) {
    //       DateTime dateTime = e.data()['dateTime'].toDate();
    //       DateFormat outPutDate = DateFormat('yyyy-MM');
    //       String formalTime = outPutDate.format(dateTime);
    //       print(dateTime);
    //       print(formalTime);
    //       data.add(
    //           SalaryData(
    //               date: formalTime,
    //               salary: e.data()['salary']
    //         ));
    //       // print(data.reversed.first.date);
    //     }
    //   });
    //   print(data);
    // });

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


