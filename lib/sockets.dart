import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wikihuh/objects.dart';
import 'package:wikihuh/pages/home.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:wikihuh/theme.dart';

class SocketLoader extends StatefulWidget {
  @override
  _SocketLoaderState createState() => _SocketLoaderState();
}

class _SocketLoaderState extends State<SocketLoader> {
  GameState _gameState;

  @override
  void initState() {
    IO.Socket socket = IO.io('http://wikihuh.kirp.al', <String, dynamic>{
      'transports': ['websocket'],
    });

    _gameState = GameState(
      players: {},
      send: (String m, Map<String, dynamic> o) {
        print(m + ': ' + jsonEncode(o));

        socket.emit(m, o);
      }
    );

    socket.on('connect', (_) {
      print('connect');
    });
    
    socket.on('disconnect', (_) => print('disconnect'));
    
    socket.on('set-player', (player) => {
      setState(() {
        _gameState.you = Player.fromJson(player);
      })
    });

    socket.on('new-game', (data) => {
      setState(() {
        _gameState = _gameState.updateWith(data);
      })
    });

    socket.on('update', (data) {
      setState(() {
        _gameState.updateWith(data);
      });
    });

    socket.on('err', (err) => print(err));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CurrentGame(
      state: _gameState,
      child: MaterialApp(
        color: Color(0xff94B874),
        debugShowCheckedModeBanner: false,
        title: 'wikiHUH?',
        theme: wikiHuhTheme,
        home: HomePage(),
      )
    );
  }
}

class CurrentGame extends InheritedWidget {
  final GameState state;
  
  CurrentGame({
    @required this.state,
    @required Widget child,
  }) : super(child: child);

  static GameState of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CurrentGame>().state;
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;
}