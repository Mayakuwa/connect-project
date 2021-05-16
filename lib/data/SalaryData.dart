import 'package:flutter/material.dart';

class SalaryData {
  final String mamaName;
  final String date;
  final String salary;
  final int year;
  final int month;

  const SalaryData({
    this.mamaName,
    @required this.date,
    @required this.salary,
    this.year,
    this.month
  });
}