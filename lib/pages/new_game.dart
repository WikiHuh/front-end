import 'package:flutter/material.dart';
import 'package:wikihuh/buttons/main_button.dart';
import 'package:wikihuh/game_state.dart';

class NewGamePage extends StatefulWidget {
  @override
  _NewGamePageState createState() => _NewGamePageState();
}

class _NewGamePageState extends State<NewGamePage> {
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
                    alignment: Alignment.centerLeft,
                    child: Text('Game PIN', style: Theme.of(context).textTheme.display4, textAlign: TextAlign.center,),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(30, 50, 30, 0),
                    alignment: Alignment.centerLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        for (var c in CurrentGame.of(context).pin.split(''))
                          Text(c, style: Theme.of(context).textTheme.display2, textAlign: TextAlign.center,),
                      ],
                    ),
                  ),
                ],
              ),
              for (var p in CurrentGame.of(context).players)
                Text(p.name, style: Theme.of(context).textTheme.display2.copyWith(color: Colors.white), textAlign: TextAlign.center,),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 40),
                child: MainButton(text: 'Start Game', onPressed: () {
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