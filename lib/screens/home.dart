import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media/auth/loginView.dart';
import 'package:social_media/services/authService.dart';
import 'package:social_media/services/fireStoreService.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final FireStoreService _db = FireStoreService();
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('ChitChat'),backgroundColor: Colors.green,
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.exit_to_app),
                onPressed: () {
                  FirebaseAuth.instance.signOut().then((value) =>
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (ctx) => LoginView())));
                })
          ],
        ),
        body: Center(
          child: Text('Hello'),
        ));
  }
}
