import 'dart:math';

import 'package:flutter/material.dart';
import 'package:wikihuh/buttons/main_button.dart';
import 'package:wikihuh/game_state.dart';

class ScoreboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(30, 50, 30, 0),
                    alignment: Alignment.center,
                    child: Text('Leaderboard', style: Theme.of(context).textTheme.display2, textAlign: TextAlign.center,),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(30, 50, 30, 0),
                    alignment: Alignment.centerLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[],
                    ),
                  ),
                ],
              ),
              for (var p in CurrentGame.of(context).players..sort((p1, p2) => p1.score - p2.score)..sublist(0, min(2, CurrentGame.of(context).players.length)))
                Text(p.name, style: Theme.of(context).textTheme.display2.copyWith(color: Colors.white), textAlign: TextAlign.center,),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 40),
                child: MainButton(text: 'Continue', onPressed: () {
                  CurrentGame.of(context).send('start game', {
                    'gameKey': CurrentGame.of(context).gameKey,
                    'playerKey': CurrentGame.of(context).playerKey
                  });
                },),
              ),
            ],
          ),
        ),
      ),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}