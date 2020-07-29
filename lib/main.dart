import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media/auth/signUpView.dart';
import 'package:social_media/screens/startUpView.dart';
import 'package:social_media/services/fireStoreService.dart';

void main() {
  runApp(MyApp());
}
FireStoreService _db = FireStoreService();

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider(create: (BuildContext context) => _db.getFriends()),
//    StreamProvider(create: (BuildContext context2)=>_db.getTalker(id)),
      ],
      child: MaterialApp(
        title: 'ChitChat',
        home: StartUpView(),
      ),
    );
  }
}
