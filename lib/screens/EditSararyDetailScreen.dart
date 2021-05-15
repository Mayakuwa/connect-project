import 'package:connect_project/data/SalaryData.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:connect_project/data/YearMonthList.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connect_project/widgets/SelectGradationButton.dart';

enum TextFieldType {
  YEAR,
  MONTH,
  MONEY,
  OTHER
}

class EditSalaryDetailScreen extends StatefulWidget {

  static const routeName = './edit_salary_detail_screen';

  @override
  _EditSalaryDetailScreenState createState() => _EditSalaryDetailScreenState();
}

class _EditSalaryDetailScreenState extends State<EditSalaryDetailScreen> {

  int _selectedYear;
  int _selectedMonth;
  String _inputMoney = '';
  String _firstInputMoney = '0';
  String _firstSelectedDate = '2021年5月';
  final TextEditingController _textEditingControllerToYear = TextEditingController();
  final TextEditingController _textEditingControllerToMonth = TextEditingController();
  final TextEditingController _textEditingControllerToMoney = TextEditingController();
  final FocusNode _nodeText = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future(() async {
      final SalaryData dataRef = ModalRoute.of(context).settings.arguments;
      setState(() {
        _firstInputMoney = dataRef.salary;
        _firstSelectedDate = dataRef.date;
        _textEditingControllerToMoney.text = _firstInputMoney;
      });
    });
  }

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

  String getInputYearMonth() {
    return '${_textEditingControllerToYear.text}年${_textEditingControllerToMonth.text}月';
  }

  @override
  Widget build(BuildContext context) {
    print(_firstSelectedDate);
    print(_firstInputMoney);
    final SalaryData data = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(title: Text('${data.mamaName}の給与情報編集')),
      body: KeyboardActions(
        config: _buildConfig(context),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  '${data.mamaName}',
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
                    buttonText: 'データを更新',
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
                        collection('members').where('name',isEqualTo: data.mamaName).get().then((value) => value.docs.reversed.first.id);
                        
                        //all-salaryの既存のidゲット
                        final salaryRef = await FirebaseFirestore.instance.
                        collection('salaries').doc(mamaRef).collection('all-salary').
                        where('date', isEqualTo: _firstSelectedDate).where('salary', isEqualTo: _firstInputMoney).
                        get().then((value) => value.docs.reversed.first.id);

                        print('給料のIDは、$salaryRef');

                        // //給与データ更新
                        // await FirebaseFirestore.instance.collection('salaries').doc(mamaRef)
                        //     .collection('all-salary').doc().set({
                        //   'salary': _inputMoney,
                        //   'date': getInputYearMonth()
                        // }).then((value) =>
                        //     print('dateを追加しました。')
                        //     Navigator.pushNamed(
                        //     context,
                        //     AddSalarySuccessScreen.routeName,
                        //     arguments: SalaryData(mamaName: mamaName.toString(), date: getInputYearMonth(), salary: _inputMoney)
                        // ).catchError((error) => _showErrorSnackBar());
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
