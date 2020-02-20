import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wikihuh/pages/waiting.dart';
import 'package:wikihuh/sockets.dart';
import 'package:wikihuh/widgets/buttons.dart';
import 'package:wikihuh/widgets/leaderboard.dart';
import 'package:wikihuh/widgets/shadows.dart';

class ScoreboardPage extends StatefulWidget {
  final Animation<double> animation;

  ScoreboardPage({this.animation});

  @override
  _ScoreboardPageState createState() => _ScoreboardPageState();
}

class _ScoreboardPageState extends State<ScoreboardPage> {
  bool _submitted = false;

  @override
  Widget build(BuildContext context) {
    if (_submitted) {
      return WaitingPage();
    }
      
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(30),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(200),
            color: Color(0xfffcffaa),
            boxShadow: [
              DropShadow(),
            ]
          ),
          child: SvgPicture.asset('assets/trophy.svg', width: 50,),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
          alignment: Alignment.center,
          child: Text('Leaderboard', style: Theme.of(context).textTheme.display2, textAlign: TextAlign.center,),
        ),
        Expanded(child: Leaderboard(this.widget.animation)),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 40),
          child: Button1(text: 'Continue', onPressed: () {
            CurrentGame.of(context).send('ready', {});
            setState(() {
              _submitted = true;
            });
          },),
        ),
      ],
    );
  }
}