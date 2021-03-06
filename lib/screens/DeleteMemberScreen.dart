import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class DeleteMemberScreen extends StatelessWidget {

  static const routeName = './delete_member_screen';

  @override
  Widget build(BuildContext context) {

    void _showSnackBar (String mamaName) {
      final snackBar = SnackBar(
          content: Text('$mamaNameが削除されました'),
          action: SnackBarAction(
              label: 'OK',
              onPressed: () {

              }));

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    //確認
    Future<void> _showCheckDeleteDialog(DocumentReference documentId, String mamaName) async {
      await showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              title: Text("削除"),
              content: Text("本当に削除しますか？"),
              actions: <Widget>[
                // ボタン領域
                TextButton(
                  child: Text("削除する", style: TextStyle(color: Colors.redAccent)),
                  onPressed: () {
                    documentId.delete();
                    Navigator.pop(context);
                    _showSnackBar(mamaName);
                  },
                ),
                TextButton(
                  child: Text("キャンセル"),
                  onPressed: () {
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
        title: Text('ママ削除'),
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
                                  final documentId = FirebaseFirestore.instance
                                      .collection('members').doc(document.id);
                                  final mamaName = documentId.collection(document['name']).id;
                                  await _showCheckDeleteDialog(documentId, mamaName);
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
