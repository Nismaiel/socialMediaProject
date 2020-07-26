import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:social_media/models/userModel.dart';
import 'fireStoreService.dart';
class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FireStoreService _db=FireStoreService();
  UserModel _currentUser;
  UserModel get currentUser=>_currentUser;

  Future loginWithEmail({@required String email, @required password}) async {
    try {
      var authResult = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      await _populateCurrentUser(authResult.user);
      return authResult.user != null;
    } catch (e) {
      return e.message;
    }
  }

  Future signUpWithEmail({
    @required String email,
    @required password,
    @required name,

  }) async {
    try {
      var authResult = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // CREATE NEW USER PROFILE
      _currentUser=UserModel( id: authResult.user.uid,
        email: email,
        name: name,
       );

      await  _db.createUser(_currentUser);

      return authResult.user != null;
    } catch (e) {
      return e.message;
    }
  }

  Future<bool> isUserLoggedIn() async {
    var user = await _firebaseAuth.currentUser();
    await _populateCurrentUser(user);
    return user != null;
  }

  Future _populateCurrentUser(user)async{
    if(user !=null){
      _currentUser=await _db.getUser();
    }
  }
}