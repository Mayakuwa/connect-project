import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:connect_project/widgets/SelectGradationButton.dart';
// import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
// import 'package:flutter/cupertino.dart';
import 'package:connect_project/data/yearMonthList.dart';
import 'package:flutter/services.dart';
import 'package:keyboard_actions/keyboard_actions.dart';


class AddSalaryNextScreen extends StatefulWidget {

  static const routeName = './add_salary_next_screen';

  @override
  _AddSalaryNextScreenState createState() => _AddSalaryNextScreenState();
}

class _AddSalaryNextScreenState extends State<AddSalaryNextScreen> {


  DateTime _selectedDate;
  int _selectedYear;
  int _selectedMonth;
  final TextEditingController _textEditingControllerToYear = TextEditingController();
  final TextEditingController _textEditingControllerToMonth = TextEditingController();

  final FocusNode _nodeText = FocusNode();

  KeyboardActionsConfig  _buildConfig(BuildContext context) {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
      keyboardBarColor: Colors.grey[200],
      actions: [
        KeyboardActionsItem(
          focusNode: _nodeText,
        ),
      ]
    );
  }

  void _selectDate(BuildContext context) async {
    DateTime pickedDate = await showModalBottomSheet<DateTime>(
        context: context,
        builder: (BuildContext context) {
          DateTime tempPickedDate;
          return Container(
            height: 250,
            child: Column(
                children: <Widget>[
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        CupertinoButton(
                          child: Text('キャンセル'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 5.0
                          ),
                        ),
                        CupertinoButton(
                          child: Text('追加'),
                          onPressed: () {
                            print(_selectedDate);
                            Navigator.of(context).pop(tempPickedDate);
                          },
                        )
                      ],
                    ),
                  ),
                  Divider(
                    height: 0,
                    thickness: 1,
                  ),
                  Expanded(
                      child: Container(
                        child: CupertinoDatePicker(
                    /// datePickerを日付のみの表示にする
                            mode: CupertinoDatePickerMode.date,
                            initialDateTime: _selectedDate,
                            onDateTimeChanged: (DateTime newDateTime) {
                                tempPickedDate = newDateTime;
                              },
                          ),
                      )
                  )
                ]
              ),
          );
        }
    );

    // if (pickedDate != null && pickedDate != _selectedDate) {
    //   setState(() {
    //     _selectedDate = pickedDate;
    //     _textEditingController.text = pickedDate.toString();
    //   });
    // }
  }

  void _selectYear(BuildContext context) async {
    int pickedYear = await showModalBottomSheet<int>(
        context: context,
        builder: (BuildContext context) {
          int tempPickedYear;
          return Container(
            height: MediaQuery.of(context).size.height / 3,
            child: GestureDetector(
              onTap: () {
                print(_selectedYear);
                print(tempPickedYear);
                Navigator.of(context).pop(tempPickedYear);
              },
              child: CupertinoPicker(
                itemExtent: 30,
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
          int tempPickedMonth;
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

  Widget _pickerItem(int year) {
    return Text(
      '$year',
      style: TextStyle(fontSize: 15),
    );
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
                            enabled: true,
                            focusNode: _nodeText,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(hintText: '値段を入力'),
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
                    onPress: () {
                      print('次へ');
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
