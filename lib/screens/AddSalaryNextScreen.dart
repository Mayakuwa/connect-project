import 'package:connect_project/screens/AddSalarySuccessScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:connect_project/widgets/SelectGradationButton.dart';
import 'package:connect_project/data/YearMonthList.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:connect_project/data/SalaryData.dart';


enum TextFieldType {
  YEAR,
  MONTH,
  MONEY,
  OTHER
}

class AddSalaryNextScreen extends StatefulWidget {

  static const routeName = './add_salary_next_screen';

  @override
  _AddSalaryNextScreenState createState() => _AddSalaryNextScreenState();
}

class _AddSalaryNextScreenState extends State<AddSalaryNextScreen> {

  int _selectedYear;
  int _selectedMonth;
  String _inputMoney = '';
  final TextEditingController _textEditingControllerToYear = TextEditingController();
  final TextEditingController _textEditingControllerToMonth = TextEditingController();
  final TextEditingController _textEditingControllerToMoney = TextEditingController();
  final FocusNode _nodeText = FocusNode();
  KeyboardActionsConfig  _buildConfig(BuildContext context) {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
      keyboardBarColor: Colors.grey[200],
      actions: [
        KeyboardActionsItem(
          focusNode: _nodeText,
          onTapAction: () {
            if(_inputMoney != '') {
              int calculateMoney;
              calculateMoney = (double.parse(_inputMoney) * 0.2).floor();
              setState(() {
                _inputMoney = calculateMoney.toString();
                //テキストフィールドの金額も20%に計算する
                _textEditingControllerToMoney.text = _inputMoney;
              });
            }
          }
        ),
      ]
    );
  }

  void _handlingMoneyField (String d) {
    setState(() {
      _inputMoney = d;
    });
  }

  void _selectYear(BuildContext context) async {
    int pickedYear = await showModalBottomSheet<int>(
        context: context,
        builder: (BuildContext context) {
          //デフォルト値を設定
          int tempPickedYear = 2021;
          return Container(
            height: MediaQuery.of(context).size.height / 3,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop(tempPickedYear);
              },
              child: CupertinoPicker(
                itemExtent: 25,
                children: yearList.map(_pickerItem).toList(),
                onSelectedItemChanged: (int index) {
                  tempPickedYear = yearList[index];
                },
              ),
            ),
          );
        }
    );

    if(pickedYear != null && pickedYear != _selectedYear) {
      setState(() {
        _selectedYear = pickedYear;
        _textEditingControllerToYear.text = pickedYear.toString();
      });
    }
  }

  void _selectMonth(BuildContext context) async {
    int pickedMonth = await showModalBottomSheet<int>(
        context: context,
        builder: (BuildContext context) {
          //デフォルト値を設定
          int tempPickedMonth = 1;
          return Container(
            height: MediaQuery.of(context).size.height / 3,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop(tempPickedMonth);
              },
              child: CupertinoPicker(
                itemExtent: 30,
                children: monthList.map(_pickerItem).toList(),
                onSelectedItemChanged: (int index) {
                  tempPickedMonth = monthList[index];
                },
              ),
            ),
          );
        }
    );

    if(pickedMonth != null && pickedMonth != _selectedMonth) {
      setState(() {
        _selectedMonth = pickedMonth;
        _textEditingControllerToMonth.text = pickedMonth.toString();
      });
    }
  }

  void _selectSnackBar(TextFieldType type) {
    switch(type) {
      case TextFieldType.YEAR:
        _showSnackBar('年');
        break;
      case TextFieldType.MONTH:
        _showSnackBar('月');
        break;
      case TextFieldType.MONEY:
        _showSnackBar('金額');
        break;
      case TextFieldType.OTHER:
        _showSnackBar('全ての項目を');
        break;
    }
  }

  void _showSnackBar(String message) {
    final snackBar = SnackBar(
      content:  Text('$messageを入力してください'),
      action: SnackBarAction(
          label: 'OK',
          onPressed: () {}),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _showErrorSnackBar() {
    final snackBar = SnackBar(
        content: Text('エラーが発生しました'),
        action: SnackBarAction(
          label: 'OK',
          onPressed: () {},
        ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Widget _pickerItem(int year) {
    return Text(
      '$year',
      style: TextStyle(fontSize: 15),
    );
  }

  //現在年月取得
  String getDate() {
    initializeDateFormatting('ja');
    var now= new DateTime.now();
    var formatter= new DateFormat.yMMM('ja');
    String month= formatter.format(now).toString();
    return month;
  }

  @override
  Widget build(BuildContext context) {
    //ママの名前取得
    final mamaName = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
          title: Text('給与追加'),
      ),
      body: KeyboardActions(
        config: _buildConfig(context),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  '$mamaName',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width/ 5,
                      child: GestureDetector(
                        onTap: () => _selectYear(context),
                        child: AbsorbPointer(
                          child: TextField(
                            controller: _textEditingControllerToYear,
                            decoration: InputDecoration(hintText: 'Year'),
                          ),
                        ),
                      ),
                    ),
                    Text('年'),
                    Container(
                      width: MediaQuery.of(context).size.width/ 5,
                      child: GestureDetector(
                        onTap: () => _selectMonth(context),
                        child: AbsorbPointer(
                          child: TextField(
                            controller: _textEditingControllerToMonth,
                            decoration: InputDecoration(hintText: 'Month'),
                          ),
                        ),
                      ),
                    ),
                    Text('月'),
                  ],
                )
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                      Container(
                          width: MediaQuery.of(context).size.width/ 2,
                          child: TextField(
                            controller: _textEditingControllerToMoney,
                            enabled: true,
                            focusNode: _nodeText,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(hintText: '値段を入力'),
                            onChanged: _handlingMoneyField,
                          ),
                        ),
                    Text('円'),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: SelectGradationButton(
                    buttonText: '次へ',
                    lightColor: Colors.orange[300],
                    middleColor: Colors.orange[500],
                    darkColor: Colors.orange[700],
                    onPress: () async {
                      if (_selectedYear == null &&
                          _selectedMonth == null &&
                          _inputMoney == '') {
                        _selectSnackBar(TextFieldType.OTHER);
                      // ignore: unrelated_type_equality_checks
                      } else if (_selectedYear == null) {
                        _selectSnackBar(TextFieldType.YEAR);
                      } else if(_selectedMonth == null) {
                        _selectSnackBar(TextFieldType.MONTH);
                      } else if(_inputMoney == '') {
                        _selectSnackBar(TextFieldType.MONEY);
                      } else {

                        //ママのdocument idゲット
                        final mamaRef = await FirebaseFirestore.instance.
                        collection('members').where('name',isEqualTo: mamaName).get().then((value) => value.docs.reversed.first.id);

                        //給与データ追加
                        await FirebaseFirestore.instance.collection('salaries').doc(getDate())
                            .collection('all-salary').add({
                          'salary': _inputMoney,
                          'userId': mamaRef
                        })
                        .then((value) => Navigator.pushNamed(
                            context,
                            AddSalarySuccessScreen.routeName,
                            arguments: SalaryData(mamaName: mamaName.toString(), date: getDate(), salary: _inputMoney)
                        ))
                        .catchError((error) => _showErrorSnackBar());
                      }
                    }
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
