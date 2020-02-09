import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wikihuh/pages/enter_pin.dart';
import 'package:wikihuh/pages/home.dart';
import 'package:wikihuh/pages/make_caption.dart';
import 'package:wikihuh/pages/new_game.dart';
import 'package:wikihuh/pages/play_or_skip.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:wikihuh/pages/scoreboard.dart';

class SocketLoader extends StatefulWidget {
  @override
  _SocketLoaderState createState() => _SocketLoaderState();
}

class _SocketLoaderState extends State<SocketLoader> {
  GameState _gameState;
  Widget _homePage;

  @override
  void initState() {
    IO.Socket socket = IO.io('https://powerful-shelf-91827.herokuapp.com/', <String, dynamic>{
      'transports': ['websocket'],
      //'extraHeaders': {'foo': 'bar'} // optional
    });

    _gameState = GameState(
      // imageUrl: 'http://deelay.me/1000/https://www.wikihow.com/images/thumb/0/00/Avoid-or-Escape-a-Bull-Step-4-Version-2.jpg/aid205176-v4-728px-Avoid-or-Escape-a-Bull-Step-4-Version-2.jpg.webp',
      // gameKey: '123456',
      players: [],
      send: (String m, Map<String, dynamic> o) {
        if (m == 'join game') {
          setState(() {
            _gameState.pin = o['pin'];
          });
        }

        socket.emit(m, o);
      }
    );

    _homePage = HomePage(setName: (String name) {
      setState(() {
        _gameState.playerName = name;
      });
    },);

    socket.on('connect', (_) {
     print('connect');
     socket.emit('msg', 'test');
    });
    socket.on('event', (data) => print(data));
    socket.on('disconnect', (_) => print('disconnect'));
    socket.on('fromServer', (_) => print(_));
    socket.on('create game', (data) => print(data));
    socket.on('new player', (playerKey) => {
      setState(() {
        _gameState.playerKey = playerKey;
      })
    });
    socket.on('new game', (data) => {
      setState(() {
        _gameState.gameKey = data['key'];
        _gameState.pin = data['pin'];
        _gameState.players.add(Player(name: _gameState.playerName));
        _homePage = NewGamePage();
      })
    });
    socket.on('playerKey', (playerKey) => {
      setState(() {
        _gameState.playerKey = playerKey;
      })
    });
    socket.on('new players in game', (players) => {
      setState(() {
        _gameState.players = players.map((p) => Player(name: p));
      })
    });
    socket.on('dammit kirpal', (err) => print(err));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CurrentGame(
      state: _gameState,
      child: MaterialApp(
        title: 'wikiHUH?',
        theme: ThemeData(
          primaryColor: Color(0xff94B874),
          accentColor: Color(0xffF8EFD2),
          textTheme: Typography.whiteMountainView.copyWith(
            button: GoogleFonts.iBMPlexSans(
              fontSize: 30,
              color: Color(0xff334455),
              fontWeight: FontWeight.w800
            ),
            body1: GoogleFonts.iBMPlexSans(
              fontSize: 20,
              color: Color(0xff334455),
              fontWeight: FontWeight.w800
            ),
            display1: GoogleFonts.merriweather(
              fontSize: 30,
              color: Color(0xff222233),
              fontWeight: FontWeight.w900
            ),
            display2: GoogleFonts.merriweather(
              fontSize: 36,
              color: Color(0xff222233),
              fontWeight: FontWeight.w800
            ),
            display3: GoogleFonts.merriweather(
              fontSize: 60,
              color: Color(0xff222233),
              fontWeight: FontWeight.w900
            ),
            display4: GoogleFonts.merriweather(
              fontSize: 72,
              color: Color(0xff222233),
              fontWeight: FontWeight.w900
            )
          ),
          accentTextTheme: Typography.whiteMountainView.copyWith(
            button: GoogleFonts.iBMPlexSans(
              fontSize: 20,
              color: Color(0xff334455),
              fontWeight: FontWeight.w600
            )
          )
        ),
        home: _homePage,
      )
    );
  }
}

class Player {
  String name;
  int score;

  Player({
    @required this.name,
    this.score = 0
  });
}

class GameState {
  int timer;
  String imageUrl;
  List<Player> players;
  String currentPage;
  String gameKey;
  String playerKey;
  String playerName;
  String pin;
  Function(String, Map<String, dynamic>) send;

  GameState({
    this.timer = 0,
    this.imageUrl = '',
    this.currentPage = 'home',
    this.gameKey = '',
    this.playerKey = '',
    this.playerName = 'asdfa',
    @required this.players,
    @required this.send
  });
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