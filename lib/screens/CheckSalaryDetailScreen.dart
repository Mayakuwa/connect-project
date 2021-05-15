import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CheckSalaryDetailScreen extends StatefulWidget {

  static const routeName = './check_salary_detail_screen';

  @override
  _CheckSalaryDetailScreenState createState() => _CheckSalaryDetailScreenState();
}

class _CheckSalaryDetailScreenState extends State<CheckSalaryDetailScreen> {

  String mamaName = '';
  String mamaId = 'none';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future(() async {
      mamaName = ModalRoute.of(context).settings.arguments;
      final mamaRef = await FirebaseFirestore.instance.
        collection('members').where('name', isEqualTo: mamaName).
        get().then((value) => value.docs.reversed.first.id);
        setState(() {
          mamaId = mamaRef;
        });
    });
  }

  void getDate() async {
      print('$mamaNameです');
      final String mamaRef =  await FirebaseFirestore.instance.
                    collection('members').where('name', isEqualTo: mamaName).
                    get().then((value) => value.docs.reversed.first.id);
      setState(() {
        mamaId = mamaRef;
      });
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('$mamaNameの給与詳細')),
      body: Column(
        children: [
          GestureDetector(
            onTap: () {
              getDate();
            },
            child: Text('タップしてください'),
          ),
          Text(mamaId),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.
                      collection('salaries').doc(mamaId).collection('all-salary').snapshots(),
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
                            print('hello');
                          },
                          child: ListTile(
                            title: Text(document['date']),
                            subtitle: Text('${document['salary']}円'),
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
