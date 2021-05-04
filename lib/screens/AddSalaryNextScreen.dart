import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:connect_project/widgets/SelectGradationButton.dart';
// import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
// import 'package:flutter/cupertino.dart';


class AddSalaryNextScreen extends StatefulWidget {

  static const routeName = './add_salary_next_screen';

  @override
  _AddSalaryNextScreenState createState() => _AddSalaryNextScreenState();
}

class _AddSalaryNextScreenState extends State<AddSalaryNextScreen> {

  DateTime _selectedDate;
  final TextEditingController _textEditingController = TextEditingController();

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

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
        _textEditingController.text = pickedDate.toString();
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    //ママの名前取得
    final mamaName = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
          title: Text('給与追加'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                '$mamaNameの',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: GestureDetector(
                onTap: () {
                  _selectDate(context);
                },
                child: AbsorbPointer(
                  child: TextField(
                    controller: _textEditingController,
                    decoration: InputDecoration(hintText: '月日'),
                  ),
                ),
              )
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
    );
  }
}
