
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_media/screens/home.dart';
import 'package:social_media/services/authService.dart';



class SignUpViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();

  Future signUp(context,
      {@required String email,
        @required String password,
        @required String name,

      }) async {
    var result = await _authService.signUpWithEmail(
        email: email,
        password: password,
        name: name,
    );
    if (result is bool) {
      if (result) {
Navigator.pushReplacement(context,MaterialPageRoute(builder:(ctx)=>Home()));
      } else {
        FToast(context).showToast(toastDuration: Duration(seconds: 2),child:  Container(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.0),
            color: Colors.greenAccent,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.check),
              SizedBox(
                width: 12.0,
              ),
              Text('Sign up Failed try again later'),              ],
          ),));

      }
    } else {
      FToast(context).showToast(toastDuration: Duration(seconds: 2),child:  Container(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          color: Colors.greenAccent,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.check),
            SizedBox(
              width: 12.0,
            ),
            Text('Sign Up Failure'),              ],
        ),));

    }
  }
}