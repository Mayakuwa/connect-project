import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connect_project/screens/AddSalaryNextScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:connect_project/widgets/SelectGradationButton.dart';


class AddSalaryScreen extends StatefulWidget {

  static const routeName = './add_salary_screen';

  @override
  _AddSalaryScreenState createState() => _AddSalaryScreenState();
}

class _AddSalaryScreenState extends State<AddSalaryScreen> {
  List<String>_mamaName = [];

  String _selectedMama = 'none';

  Widget _pickerItem(String text) {
    return Text(
      text,
      style: TextStyle(fontSize: 32),
    );
  }

  void _onSelectedItemChange(int index) {
    setState(() {
      _selectedMama = _mamaName[index];
    });
  }

  void _insertList() async {
    await FirebaseFirestore.instance.
          collection('members')
          .get().then((snapshot) =>
          snapshot.docs.forEach((doc) {
            _mamaName.add(doc['name']);
            //print(doc['name']);
          })
    );
  }

  void _showSnackBar () {
    final snackBar = SnackBar(
        content: Text('ママが選択されていません😭'),
        action: SnackBarAction(
            label: 'OK',
            onPressed: () {

            }));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  void initState() {
    super.initState();
    _insertList();
  }

  void _selectMamaPicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: MediaQuery.of(context).size.height / 3,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: CupertinoPicker(
                itemExtent: 40,
                children: _mamaName.map(_pickerItem).toList(),
                onSelectedItemChanged: _onSelectedItemChange
              ),
            ),
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('給与追加')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                  '給与追加するママを選んでください😀',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                  _selectedMama,
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700)
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: SelectGradationButton(
                  buttonText: 'ママを選ぶ',
                  lightColor: Colors.orange[300],
                  middleColor: Colors.orange[500],
                  darkColor: Colors.orange[700],
                  onPress: () => _selectMamaPicker(context)
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
                    _selectedMama == 'none' ?
                        _showSnackBar() :
                        Navigator.pushNamed(
                            context,
                            AddSalaryNextScreen.routeName,
                            arguments: _selectedMama
                        );
                  }
              ),
            )
          ],
        ),
      ),
    );
  }
}
