import 'dart:async';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:firebase/firebase.dart' as fb;
import 'package:firebase/firestore.dart' as fs;
import 'package:linktree_demo_clone/linktree.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  fb.UploadTask _uploadTask;

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
            ),
            Spacer(),
            StreamBuilder<fb.UploadTaskSnapshot>(
              stream: _uploadTask?.onStateChanged,
              builder: (context, snapshot) {
                final event = snapshot?.data;

                // Default as 0
                double progressPercent = event != null
                    ? event.bytesTransferred / event.totalBytes * 100
                    : 0;

                switch (event?.state) {
                  case fb.TaskState.RUNNING:
                    return LinearProgressIndicator(
                      value: progressPercent,
                    );
                  case fb.TaskState.SUCCESS:
                    return Text('Success 🎊');

                  case fb.TaskState.ERROR:
                    return Text('Has error 😢');

                  default:
                    // Show empty when not uploading
                    return SizedBox();
                }
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'picker',
        elevation: 0,
        backgroundColor: Colors.tealAccent[400],
        hoverElevation: 0,
        label: Row(
          children: <Widget>[
            Icon(Icons.file_upload),
            SizedBox(width: 10),
            Text('Upload Image')
          ],
        ),
        onPressed: () => uploadImage(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  /// Upload file to firebase storage and updates [_uploadTask] to the latest
  /// file upload
  uploadToFirebase(File imageFile) async {
    final filePath = 'images/${DateTime.now()}.png';
    setState(() {
      _uploadTask = fb
          .storage()
          .refFromURL('gs://linktree-cc099.appspot.com')
          .child(filePath)
          .put(imageFile);
    });
  }

  /// A "select file/folder" window will appear. User will have to choose a file.
  /// This file will be then read, and uploaded to firebase storage;
  uploadImage() async {
    // HTML input element
    InputElement uploadInput = FileUploadInputElement();
    uploadInput.click();

    uploadInput.onChange.listen(
      (changeEvent) {
        final file = uploadInput.files.first;
        final reader = FileReader();
        // The FileReader object lets web applications asynchronously read the
        // contents of files (or raw data buffers) stored on the user's computer,
        // using File or Blob objects to specify the file or data to read.
        // Source: https://developer.mozilla.org/en-US/docs/Web/API/FileReader

        reader.readAsDataUrl(file);
        // The readAsDataURL method is used to read the contents of the specified Blob or File.
        //  When the read operation is finished, the readyState becomes DONE, and the loadend is
        // triggered. At that time, the result attribute contains the data as a data: URL representing
        // the file's data as a base64 encoded string.
        // Source: https://developer.mozilla.org/en-US/docs/Web/API/FileReader/readAsDataURL

        reader.onLoadEnd.listen(
          // After file finiesh reading and loading, it will be uploaded to firebase storage
          (loadEndEvent) async {
            uploadToFirebase(file);
          },
        );
      },
    );
  }
}

// Stream that returns list of links docs
Stream<List<Map<String, dynamic>>> userLinks(fs.Firestore firestore) {
  return firestore
      .collection('links')
      .onSnapshot
      .map((data) => data.docs.map((doc) => doc.data()).toList());
}
