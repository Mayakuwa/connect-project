import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DeleteMemberScreen extends StatelessWidget {

  final _firestore = FirebaseFirestore.instance;
  static const routeName = './delete_member_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('メンバー削除'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
              child: FutureBuilder<QuerySnapshot>(
                future: FirebaseFirestore.instance
                    .collection('members')
                    .get(),
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
                            title: Text(document['name'])
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
