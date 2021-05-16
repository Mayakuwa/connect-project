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
    return LineGraph(
      _createData(snapshot),
      animate: false
    );
  }

  //firestoreから受けとったデータの配列を入れる。
  static List<charts.Series<SalaryData, int>> _createData(Stream<QuerySnapshot> snapshot) {
    List<SalaryData> data = [];

    snapshot.forEach((element) {
      element.docs.reversed.forEach((e) {
        //タイムスタンプを日付に変換
        if(e.data()['dateTime'] is Timestamp) {
          DateTime dateTime = e.data()['dateTime'].toDate();
          DateFormat outPutDate = DateFormat('yyyy-MM');
          String formalTime = outPutDate.format(dateTime);
          data.add(
              new SalaryData(
                  date: e.data()['date'],
                  salary: e.data()['salary']
            ));
          print(data.reversed.first.date);
        }
      });
    });

    
    return [
      new charts.Series<SalaryData, int>(
          id: 'Salary',
          colorFn: (_, __) => charts.MaterialPalette.deepOrange.shadeDefault,
          measureFn: (SalaryData dates, _) => int.parse(dates.salary),
          domainFn: (SalaryData dates, _) => int.parse(dates.date),
          data: data,
      )
    ];
  }


  @override
  Widget build(BuildContext context) {
    return new charts.LineChart(
      seriesList,
      animate: animate,
    );
  }
}


