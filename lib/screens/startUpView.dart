

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media/auth/loginView.dart';
import 'package:social_media/models/userModel.dart';
import 'package:social_media/services/fireStoreService.dart';

import 'home.dart';

class StartUpView extends StatefulWidget {

  @override
  _StartUpViewState createState() => _StartUpViewState();
}

final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
final FireStoreService _db = FireStoreService();
UserModel _currentUser;

Future _populateCurrentUser(FirebaseUser user) async {
  if (user != null) {
    _currentUser = await _db.getUser();
  }
}


class _StartUpViewState extends State<StartUpView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    reRoute();
  }

  reRoute() async {
    var user = await _firebaseAuth.currentUser();
    _populateCurrentUser(user);
    user != null ? Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx)=>Home())) : Navigator
        .pushReplacement(
        context, MaterialPageRoute(builder: (ctx) => LoginView()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, body: Center(child: Column(
      mainAxisAlignment: MainAxisAlignment.center, children: [
      Flexible(
        child: Container(
          margin: EdgeInsets.only(bottom: 20.0),
          padding:
          EdgeInsets.symmetric(vertical: 8.0, horizontal: 94.0),

          decoration: BoxDecoration(
            borderRadius: new BorderRadius.all(Radius.elliptical(100, 50)),
            color: Colors.transparent,

          ),
//            child:CircleAvatar(backgroundImage: ExactAssetImage('assets/logo.jpg'),maxRadius: 90,minRadius: 80,)

        ),

      ),
      CircularProgressIndicator(),
    ],),),);
  }
}
