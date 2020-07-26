import 'package:flutter/material.dart';
import 'package:social_media/auth/signUpView.dart';
import 'package:social_media/screens/startUpView.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ChitChat',

      home: StartUpView(),
    );
  }
}

