import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media/auth/loginView.dart';
import 'package:social_media/screens/chat.dart';
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
          title: Text('ChitChat'),
          backgroundColor: Colors.black,
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
        body: StreamBuilder(
            stream:
                Firestore.instance.collection('user').getDocuments().asStream(),
            builder: (context, snapshot) {
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (ctx, index) {
                    var friend = snapshot.data.documents[index];
                    return GestureDetector(
                      onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => Chat(name: friend['name'],),));},
                        child: Card(
                            child: ListTile(
                      leading: Text(friend['name']),
                      subtitle: Text(friend['email']),
                    )));
                  });
            }));
  }
}
