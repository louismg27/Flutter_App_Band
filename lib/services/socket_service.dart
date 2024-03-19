import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus {
  Online,
  Offline,
  Connecting,
}

class SocketService with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.Connecting;
  late IO.Socket _socket; // Cambio aquí: Utilizo late para diferir la inicialización.

  get serverStatus => _serverStatus;

  SocketService() {
    _initConfig(); // Cambio aquí: Retiré "this" porque no es necesario.
  }

  void _initConfig() {
    // Dart client
    _socket = IO.io('http://192.168.100.124:3000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true,
    });
    _socket.onConnect((_) {
      print('connect');
      _serverStatus = ServerStatus.Online;
      notifyListeners();
    });
    _socket.onDisconnect((_){
      _serverStatus = ServerStatus.Offline;
      print('disconnect');
    });
  }
}
