import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_media/models/FriendsModel.dart';
import 'package:social_media/models/userDataModel.dart';
import 'package:social_media/models/userModel.dart';
import 'socketServices.dart';

class FireStoreService {
  final _db = Firestore.instance;
  final _auth = FirebaseAuth.instance;
  static SocketService _utils;

  Future createUser(UserModel user) async {
    try {
      await Firestore.instance.collection('user').document(user.id).setData(
          user.toJson());
    } catch (e) {
      return e.message;
    }
  }

  Future getUser() async {
    var user = await FirebaseAuth.instance.currentUser();
    var userId = user.uid;
    try {
      var userData = await Firestore.instance.collection('user').document(
          userId).get();
      if (userData.data.isNotEmpty) {
        return UserModel.fromJson(userData.data);
      } else
        UserModel.fromJson(userData.data);
    } catch (e) {
      return e.message;
    }
  }


  Stream<List<UserData>> getFriends() {
    return _db
        .collection('user')
        .snapshots()
        .map((snap) =>
        snap.documents.map((doc) => UserData.fromJson(doc.data)).toList());
  }  Stream<List<UserData>> getTalker(id) {
    return _db
        .collection('user').where('id',isEqualTo: id)
        .snapshots()
        .map((snap) =>
        snap.documents.map((doc) => UserData.fromJson(doc.data)).toList());
  }

  getUserData() async {
    var user = await FirebaseAuth.instance.currentUser();
    var userId = user.uid;
    try {
      var userData = await Firestore.instance
          .collection('user')
          .where('id', isEqualTo: userId)
          .getDocuments();
      if (userData.documents.isNotEmpty) {
        return userData.documents
            .map((snap) => UserData.fromJson(snap.data))
            .toList();
      } else {
        return userData.documents
            .map((snap) => UserData.fromJson(snap.data))
            .toList();
      }
    } catch (e) {
      return e.message;
    }
  }

  initSocket() {
    if (_utils == null) {
      _utils = SocketService();
    }
  }

}