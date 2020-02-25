import 'package:flutter/material.dart';
import 'package:wikihuh/sockets.dart';
import 'package:wikihuh/widgets/buttons.dart';

class NewGamePage extends StatefulWidget {
  final Animation<double> animation;

  NewGamePage({this.animation});

  @override
  _NewGamePageState createState() => _NewGamePageState();
}

class _NewGamePageState extends State<NewGamePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.fromLTRB(30, 50, 30, 0),
          alignment: Alignment.center,
          child: Text('Game PIN', style: Theme.of(context).textTheme.display3, textAlign: TextAlign.center,),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 40),
          alignment: Alignment.centerLeft,
          child: Center(
            child: (CurrentGame.of(context).pin?? '').length > 0 ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                for (var c in CurrentGame.of(context).pin.split(''))
                  Text(c, style: Theme.of(context).textTheme.display3, textAlign: TextAlign.center,),
              ],
            ) : CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).textTheme.display2.color)),
          ),
        ),
        Expanded(
          child: ListView(
            children: [
              for (var p in CurrentGame.of(context).players.values)
                Text(p.name, style: Theme.of(context).textTheme.display2.copyWith(color: Colors.white), textAlign: TextAlign.center,),
            ]
          )
        ),
        if (CurrentGame.of(context).owner)
          Padding(
            padding: EdgeInsets.only(top: 40, bottom: 10),
            child: Button1(text: 'Start Game', onPressed: () {
              CurrentGame.of(context).send('start-game', {});
            },),
          )
        else
          Padding(
            padding: EdgeInsets.all(20),
            child: Text('Waiting for owner to start...', style: Theme.of(context).textTheme.display1.copyWith(fontSize: 20),),
          )
      ],
    );
  }
}