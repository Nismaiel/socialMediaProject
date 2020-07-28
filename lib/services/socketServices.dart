import 'dart:io';

import 'package:adhara_socket_io/adhara_socket_io.dart';
import 'package:social_media/models/userModel.dart';

class SocketService {
  static String _serverIp =
      Platform.isIOS ? 'http://localhost' : 'http://10.0.2.2';
  static const int server_port = 6000;
  static String _connectUrl = '$_serverIp:$server_port';

  //EVENTS
  static const String _onMessageReviced = 'recived_Message';
  static const String _isUserONline = 'check_online';

//status
  static const int messageNotSent = 10001;
  static const int messageSent = 10002;

//TypeOfChat
  static const String singeChat = 'single chat';

  UserModel user;
  SocketIO _socket;
  SocketIOManager _manager;

  initSocket(name) async {

    print('connecting ..${name}');
  }

  init() async {
    _manager = SocketIOManager();
    _socket = await _manager.createInstance(_socketOptions());
  }

  connectToSocket()async{
    if(_socket==null){
      print('socket is null');
      return;
    }_socket.connect();
  }

  _socketOptions() {
    final Map<String, String> userMap = {
      'from': user.id.toString(),
    };
    return SocketOptions(_connectUrl,
        enableLogging: true,
        transports: [Transports.WEB_SOCKET],
        query: userMap);
  }

  setConnectListener(Function onConnect) async {
    _socket.onConnect((data) {
      onConnect(data);
    });
  }

  setTimeOutListener(Function onConnectionTimeOut) async {
    _socket.onConnectTimeout((data) {
      onConnectionTimeOut(data);
    });
  }

  setOnConnectionErrorListener(Function onConnectionError) {
    _socket.onConnectError((data) {
      onConnectionError(data);
    });
  }

  setOnErrorListener(Function onError) {
    _socket.onError((data) {
      onError(data);
    });
  }

  setOnDisconnectListener(Function onDisconnect) {
    _socket.onDisconnect((data) {
      onDisconnect(data);
    });
  }

  closeConnection() {
    if (null != _socket) {
      print('Closing Connection');
      _manager.clearInstance(_socket);
    }
  }
}
