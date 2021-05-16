import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connect_project/screens/EditSararyDetailScreen.dart';
import 'package:flutter/material.dart';
import 'package:connect_project/data/SalaryData.dart';
import 'package:intl/intl.dart';


class CheckSalaryDetailScreen extends StatefulWidget {

  static const routeName = './check_salary_detail_screen';

  @override
  _CheckSalaryDetailScreenState createState() => _CheckSalaryDetailScreenState();
}

class _CheckSalaryDetailScreenState extends State<CheckSalaryDetailScreen> {

  // nullpoを防ぐために初期値を入れておく
  String _mamaName = '';
  String _mamaId = 'none';
  List<SalaryData> _salaryData = [
    SalaryData(date: '2015年5月', salary: '5000円')
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future(() async {
      _mamaName = ModalRoute.of(context).settings.arguments;
      final mamaRef = await FirebaseFirestore.instance.
        collection('members').where('name', isEqualTo: _mamaName).
        get().then((value) => value.docs.reversed.first.id);
        setState(() {
          _mamaId = mamaRef;
        });

      QuerySnapshot salaryData = await FirebaseFirestore.instance.
      collection('salaries').doc(_mamaId).collection('all-salary').get();
      for(var i = 0; i < salaryData.docs.length; i++) {
        _salaryData.add(
            SalaryData(
            date: salaryData.docs[i].data()['date'],
            salary: salaryData.docs[i].data()['salary']
        ));
      }

      //テスト並び替え
      final test = FirebaseFirestore.instance.
      collection('salaries').doc(_mamaId).collection('all-salary').snapshots();
      test.forEach((element) {
        element.docs.reversed.forEach((e) {
          print(e.data());
        });
      }
      );
    });
  }

  // Stream<QuerySnapshot> sortDataByDate (Stream<QuerySnapshot> data) {
  //   //年と月を取り出す
  //   return
  // }

  void getMamaIdFromFirestore() async {
      final String mamaRef =  await FirebaseFirestore.instance.
                    collection('members').where('name', isEqualTo: _mamaName).
                    get().then((value) => value.docs.reversed.first.id);
      setState(() {
        _mamaId = mamaRef;
      });
    }

    //年と月を分割し、listとして返す。
    List<String> getMonthAndYearToInt(String date) {
      RegExp exp = new RegExp(r'^(.+)年(.+)月$');
      Match match = exp.firstMatch(date);
      List<String> yearMonth = [match.group(1), match.group(2)];
      return yearMonth;
    }

  @override
  Widget build(BuildContext context) {
    final date = DateTime(2019, 6);
    print('${date.year}年${date.month}月');
    return Scaffold(
      appBar: AppBar(title: Text('$_mamaNameの給与詳細')),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.
                      collection('salaries').doc(_mamaId).collection('all-salary').snapshots(),
              builder: (context, snapshot) {
                if(snapshot.hasError) {
                  return Text('エラーが発生しました');
                }
                if(snapshot.hasData) {
                  final List<DocumentSnapshot> documents = snapshot.data.docs;
                  return ListView(
                    children: documents.map((document) {
                      return Card(
                          child: ListTile(
                            title: Text(document['date']),
                            subtitle: Text('${document['salary']}円'),
                            trailing: IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                List<String> yearMonth = getMonthAndYearToInt(document['date']);
                                getMonthAndYearToInt(document['date']);
                                Navigator.pushNamed(
                                    context,
                                    EditSalaryDetailScreen.routeName,
                                    arguments: SalaryData(
                                        mamaName: _mamaName,
                                        date: document['date'],
                                        salary: document['salary'],
                                        year: int.parse(yearMonth[0]),
                                        month: int.parse(yearMonth[1])
                                    )
                                );
                              },
                            ),
                          ),
                      );
                    }).toList(),
                  );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
