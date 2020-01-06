import 'dart:html';

import 'package:flutter/material.dart';
import 'package:firebase/firebase.dart' as fb;
import 'package:firebase/firestore.dart' as fs;
import 'package:linktree_demo_clone/linktree.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final fs.Firestore firestore = fb.firestore();
    return Scaffold(
      body: Container(
        width: width,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 18.0),
              child: Text(
                'Mah Links',
                style: TextStyle(
                  fontFamily: 'Karla',
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            StreamBuilder(
              stream: userLinks(firestore),
              builder: (context, snapshot) {
                if (!snapshot.hasData)
                  return CircularProgressIndicator();
                else
                  return Container(
                    width: width > 698 ? width / 3 : width,
                    child: Column(
                      children: <Widget>[
                        for (var link in snapshot.data)
                          ButtonLink(
                            text: link['title'],
                            url: link['url'],
                          )
                      ],
                    ),
                  );
              },
            )
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          FloatingActionButton(
            heroTag: 'add',
            elevation: 0,
            child: Icon(Icons.add),
            onPressed: () {
              firestore.collection('links').add({
                'title': 'Tik Tok',
                'url': 'linkedInUrl',
              });
            },
          ),
          SizedBox(width: 10),
          FloatingActionButton(
            heroTag: 'update',
            elevation: 0,
            child: Icon(Icons.edit),
            onPressed: () {
              firestore
                  .collection('links')
                  .doc('6LPUksmcw6avwmO2LuR4')
                  .update(data: {'title': 'Tik Tok Tok'});
            },
          ),
          SizedBox(width: 10),
          FloatingActionButton(
            heroTag: 'delete',
            elevation: 0,
            child: Icon(Icons.delete),
            onPressed: () {
              firestore
                  .collection('links')
                  .doc('6LPUksmcw6avwmO2LuR4')
                  .delete();
            },
          ),
          FloatingActionButton(
            heroTag: 'delete',
            elevation: 0,
            child: Icon(Icons.delete),
            onPressed: () {
              String filePath = 'images/${DateTime.now()}.png';

              fb.storage().ref().child(filePath).put(file);
            },
          ),
        ],
      ),
    );
  }

  Stream<List<Map<String, dynamic>>> userLinks(fs.Firestore firestore) {
    return firestore
        .collection('links')
        .onSnapshot
        .map((data) => data.docs.map((doc) => doc.data()).toList());
  }

  _startFilePicker() async {
    InputElement uploadInput = FileUploadInputElement();
    uploadInput.click();

    uploadInput.onChange.listen((e) {
      // read file content as dataURL
      final files = uploadInput.files;
      if (files.length == 1) {
        final file = files[0];
        final reader = new FileReader();

        reader.onLoadEnd.listen((e) {
          // _handleResult(reader.result);
        });
        reader.readAsDataUrl(file);
      }
    });
  }

  Future<List<Map<String, dynamic>>> userLink(fs.Firestore firestore) {
    return firestore
        .collection('links')
        .get()
        .then((data) => data.docs.map((doc) => doc.data()).toList());
  }
}
