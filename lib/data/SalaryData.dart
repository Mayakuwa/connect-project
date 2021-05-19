import 'package:flutter/material.dart';

class SalaryData {
  final String mamaName;
  final String date;
  final String salary;
  final int year;
  final int month;
  final DateTime dateTime;

  const SalaryData({
    this.mamaName,
    this.date,
    @required this.salary,
    this.year,
    this.month,
    this.dateTime
  });
}