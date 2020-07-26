import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_media/auth/signUpView.dart';
import 'package:social_media/screens/home.dart';
import 'package:social_media/services/authService.dart';

class LoginViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();

  Future login(
    context, {
    @required String email,
    @required String password,
  }) async {

    var result = await _authService.loginWithEmail(
      email: email,
      password: password,
    );
    if (result is bool) {
      if (result) {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (ctx) => Home()));
      } else {
        FToast(context).showToast(
            toastDuration: Duration(seconds: 2),
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
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
                  Text('login Failed try again later'),
                ],
              ),
            ));
      }
    } else {
      FToast(context).showToast(
          toastDuration: Duration(seconds: 2),
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
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
                Text('login Failure'),
              ],
            ),
          ));
    }
  }

  void navigateToSignUp(context) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (ctx) => SignUpView()));
  }
}
