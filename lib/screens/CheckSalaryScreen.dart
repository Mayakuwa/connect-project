import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connect_project/screens/CheckSalaryDetailScreen.dart';
import 'package:flutter/material.dart';

class CheckSalaryScreen extends StatefulWidget {

  static const routeName = './check_salary_screen';

  @override
  _CheckSalaryScreenState createState() => _CheckSalaryScreenState();
}

class _CheckSalaryScreenState extends State<CheckSalaryScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('データ確認')
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            child: Text(
              'ママ一覧',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('members')
                  .snapshots(),
              builder: (context, snapshot) {
                if(snapshot.hasError) {
                  return Text('エラーが発生しました');
                }
                if(snapshot.hasData) {
                  final List<DocumentSnapshot> documents = snapshot.data.docs;
                  return ListView(
                    children: documents.map((document) {
                      return Card(
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                                context, CheckSalaryDetailScreen.routeName,
                                arguments: document['name']
                            );
                          },
                          child: ListTile(
                            title: Text(document['name']),
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
            )
          )
        ],
      ),
    );
  }
}
