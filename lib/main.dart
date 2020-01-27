import 'package:flutter/material.dart';
import 'package:firebase/firebase.dart' as Firebase;
import 'package:linktree_demo_clone/firebase_storage_demo.dart';
import 'package:linktree_demo_clone/linktree.dart';
// import 'package:linktree_demo_clone/settings.dart';

Future<void> main() async {
  if (Firebase.apps.isEmpty) {
    print(Firebase.apps);
    Firebase.initializeApp(
      apiKey: "AIzaSyC2qGleXKppcJGgoU57kwBCwdahnSpOPoA",
      authDomain: "linktree-cc099.firebaseapp.com",
      databaseURL: "https://linktree-cc099.firebaseio.com",
      projectId: "linktree-cc099",
      storageBucket: "linktree-cc099.appspot.com",
      messagingSenderId: "663269461657",
      appId: "1:663269461657:web:9d75f59d7e2e4a884af208",
    );
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Linktree Clone',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/settings',
      routes: {
        '/': (context) => Linktree(),
        '/settings': (context) => Settings(),
      },
    );
  }
}
