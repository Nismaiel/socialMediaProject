import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media/auth/loginView.dart';
import 'package:social_media/models/userDataModel.dart';
import 'package:social_media/models/userModel.dart';
import 'package:social_media/screens/chat.dart';
import 'package:social_media/services/authService.dart';
import 'package:social_media/services/fireStoreService.dart';
import 'package:social_media/services/socketServices.dart';

class Home extends StatelessWidget {
  var  user;
  final db=FireStoreService();
//  final auth=FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
//    var user=Provider.of<FirebaseUser>(context);

    return       StreamProvider<List<UserData>>.value(value:  db.getFriends(),child: Friends(),);

  }
}




class Friends extends StatefulWidget {
  @override
  _FriendsState createState() => _FriendsState();
}

class _FriendsState extends State<Friends> {
  final FireStoreService _db = FireStoreService();
  final SocketService _socket=SocketService();
  bool connectedToSocket;
  String _connectMessage;

@override
  void initState() {
    // TODO: implement initState
    super.initState();
  _db.getUserData();
    connectedToSocket=false;
    _connectMessage='Connecting...';
    _connectToSocket();
  }
  UserData _user;
  _connectToSocket()async{
    var user=await FirebaseAuth.instance.currentUser();
    var userId=user.uid;
     print('Connecting ${userId}');
        _db.initSocket();
    _socket.initSocket(userId);
    _socket.connectToSocket();
    _socket.setConnectListener(onConnect);
    _socket.setOnConnectionErrorListener(onConnectionError);
    _socket.setTimeOutListener(onConnectionTimeOut);
    _socket.setOnDisconnectListener(onDisconnect);
    _socket.setOnErrorListener(onError);

  }
  onConnect(data){
    setState(() {
      connectedToSocket=true;
      _connectMessage='Connected';
    });
  }
  onConnectionError(data){
    setState(() {
      connectedToSocket=false;
      _connectMessage='Connection Error!!';
    });
  }
  onConnectionTimeOut(data){
    setState(() {
      connectedToSocket=false;
      _connectMessage='Connection TimeOut!!';
    });
  }
  onDisconnect(data){
    setState(() {
      connectedToSocket=false;
      _connectMessage='Disconnected!!';
    });
  }
  onError(data){
    setState(() {
      connectedToSocket=false;
      _connectMessage='Error!!';
    });
  }
  

  @override
  Widget build(BuildContext context) {
//    var user=Provider.of<FirebaseUser>(context);
    List friend=[];
    friend=Provider.of<List<UserData>>(context);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Home'),
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
body:friend==null?Center(child: CircularProgressIndicator(),): ListView.builder(
    shrinkWrap: true,
    itemCount: friend.length,
    itemBuilder: (ctx, index) {
      var fr = friend[index];
      return GestureDetector(
          onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => Chat(name:fr.name,),));},
          child: Card(
              child: ListTile(
                leading: Text(fr.name),
                subtitle: Text(fr.id),
              )));
    }),
//        body: StreamBuilder(
//            stream:
//                Firestore.instance.collection('user').getDocuments().asStream(),
//            builder: (context, snapshot) {
//              return ListView.builder(
//                  shrinkWrap: true,
//                  itemCount: snapshot.data.documents.length,
//                  itemBuilder: (ctx, index) {
//                    var friend = snapshot.data.documents[index];
//                    return GestureDetector(
//                      onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => Chat(name: friend['name'],),));},
//                        child: Card(
//                            child: ListTile(
//                      leading: Text(friend['name']),
//                      subtitle: Text(friend['email']),
//                    )));
//                  });
//            })

    );
  }
}
