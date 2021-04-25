import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class DeleteMemberScreen extends StatelessWidget {

  static const routeName = './delete_member_screen';


  @override
  Widget build(BuildContext context) {

    Future<void> showCheckDeleteDialog(DocumentReference documentId) async {
      await showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              title: Text("削除"),
              content: Text("本当に削除しますか？"),
              actions: <Widget>[
                // ボタン領域
                FlatButton(
                  child: Text("Cancel"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                FlatButton(
                  child: Text("OK"),
                  onPressed: () {
                    documentId.delete();
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          }
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('メンバー削除'),
      ),
      body: Column(
        children: <Widget>[
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
                          child: ListTile(
                            title: Text(document['name']),
                            trailing: IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () async {
                                  await showCheckDeleteDialog(FirebaseFirestore.instance
                                      .collection('members').doc(document.id));
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
              )
          )
        ],
      ),
    );
  }
}
