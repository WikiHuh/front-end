import 'package:flutter/material.dart';
import 'package:wikihuh/objects.dart';
import 'package:wikihuh/pages/finished.dart';
import 'package:wikihuh/pages/make_caption.dart';
import 'package:wikihuh/pages/new_game.dart';
import 'package:wikihuh/pages/page_wrapper.dart';
import 'package:wikihuh/pages/scoreboard.dart';
import 'package:wikihuh/pages/vote.dart';
import 'package:wikihuh/sockets.dart';

class GamePlayNav extends StatefulWidget {
  final GameStatus status;

  GamePlayNav({@required this.status});

  @override
  _GamePlayNavState createState() => _GamePlayNavState();
}

class _GamePlayNavState extends State<GamePlayNav> with SingleTickerProviderStateMixin {
  GameStatus _status;
  AnimationController _controller;

  @override
  void initState() {
    _status = this.widget.status;
	  _controller = AnimationController(duration: Duration(milliseconds: 300), vsync: this,);

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget pageMap({GameStatus status, Animation<double> animation = const AlwaysStoppedAnimation(1)}) {
    switch (status) {
      case GameStatus.lobby: return NewGamePage(animation: animation);
      case GameStatus.writing: return MakeCaptionPage(animation: animation);
      case GameStatus.voting: return VotePage(animation: animation);
      case GameStatus.scoreboard: return ScoreboardPage(animation: animation);
      case GameStatus.finished: return FinishedPage(animation: animation,);
    }

    return Container();
  }

  @override
  Widget build(BuildContext context) {
    GameState _gameState = CurrentGame.of(context);
    if (_gameState.status == _status) {
      return PageWrapper(child: pageMap(status: _status));
    } else {
      setState(() {
        _status = _gameState.status;
      });
      _controller.reset();
      _controller.forward();
      return PageWrapper(child: pageMap(status: _status, animation: _controller));
    }
  }
}