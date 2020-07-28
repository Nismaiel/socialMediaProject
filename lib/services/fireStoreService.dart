import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_media/models/FriendsModel.dart';
import 'package:social_media/models/userModel.dart';
import 'socketServices.dart';
class FireStoreService{
  final _db=Firestore.instance;
  final _auth=FirebaseAuth.instance;
  static SocketService _utils;

Future createUser(UserModel user)async{
  try{
await Firestore.instance.collection('user').document(user.id).setData(user.toJson());
  }catch(e){
    return e.message;
  }
}

Future getUser()async{
  var user=await FirebaseAuth.instance.currentUser();
  var userId=user.uid;
try{
var userData=await Firestore.instance.collection('user').document(userId).get();
if(userData.data.isNotEmpty){
  return UserModel.fromJson(userData.data);
}
}catch(e){return e.message;}
}
//Future getFriends()async{
//  Firestore.instance.collection('users').getDocuments().then((snap) => snap.documents).then((docs) => FriendsModel.fromJson(docs.data));
//}
 initSocket(){
  if(_utils==null){
  _utils=SocketService();
  }
}

}