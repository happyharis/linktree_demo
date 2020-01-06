import 'package:flutter/material.dart';
import 'package:firebase/firebase.dart' as Firebase;
import 'package:linktree_demo_clone/linktree.dart';
import 'package:linktree_demo_clone/settings.dart';

Future<void> main() async {
  if (Firebase.apps.isEmpty) {
    print(Firebase.apps);
    Firebase.initializeApp(
      apiKey: "AIzaSyDHqC1COyDCQ5CqND3VaatVtbmUjgPXe8E",
      authDomain: "linktree-demo.firebaseapp.com",
      databaseURL: "https://linktree-demo.firebaseio.com",
      projectId: "linktree-demo",
      storageBucket: "linktree-demo.appspot.com",
      messagingSenderId: "787587337926",
      appId: "1:787587337926:web:48f146b45869fbaf3f11c7",
    );
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: {
        '/': (context) => Linktree(),
        '/settings': (context) => Settings()
      },
    );
  }
}
