import 'package:example/main_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp();
    return MaterialApp(
      title: 'DashChat Example',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: DashChatPage(),
    );
  }
}
