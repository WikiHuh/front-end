import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wikihuh/objects.dart';
import 'package:wikihuh/pages/waiting.dart';
import 'package:wikihuh/sockets.dart';
import 'package:wikihuh/widgets/buttons.dart';
import 'package:wikihuh/widgets/leaderboard.dart';
import 'package:wikihuh/widgets/shadows.dart';
import 'package:wikihuh/widgets/wiki_image.dart';

enum CurrentPage {
  winner,
  scoreboard,
  submitted
}

class ResultsPage extends StatefulWidget {
  final AnimationController animation;

  ResultsPage({this.animation});

  @override
  _ResultsPageState createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  CurrentPage _currentPage = CurrentPage.winner;
  ConfettiController _confettiController;

  @override
  void initState() {
    _confettiController = ConfettiController(duration: Duration(milliseconds: 200));

    super.initState();
  }

  @override
  void dispose() {
    _confettiController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    switch (_currentPage) {
      case CurrentPage.winner:
        Player _winner = sortPlayers(CurrentGame.of(context).players)[0];

        _confettiController.play();

        return Stack(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
                  alignment: Alignment.center,
                  child: Text('Winner', style: Theme.of(context).textTheme.display3, textAlign: TextAlign.center,),
                ),
                Expanded(
                  child: WikiImage(CurrentGame.of(context).imageUrl)
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 20),
                  child: AutoSizeText(_winner.response, maxLines: 2, style: Theme.of(context).textTheme.body1.copyWith(fontSize: 24, color: Colors.black), textAlign: TextAlign.center,),
                ),
                Text(_winner.name,style: Theme.of(context).textTheme.display1.copyWith(fontSize: 20, color: Colors.black87),),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 40),
                  child: Button1(text: 'Continue', onPressed: () {
                    setState(() {
                      _currentPage = CurrentPage.scoreboard;
                      this.widget.animation.reset();
                      this.widget.animation.forward();
                    });
                  },),
                ),
              ],
            ),
            SizedBox.expand(
              child: Align(
                alignment: Alignment.topLeft,
                child: ConfettiWidget(
                  confettiController: _confettiController,
                  blastDirection: 0,
                  emissionFrequency: 0.8,
                  numberOfParticles: 10,
                  maxBlastForce: 10,
                ),
              ),
            ),
            SizedBox.expand(
              child: Align(
                alignment: Alignment.topRight,
                child: ConfettiWidget(
                  confettiController: _confettiController,
                  blastDirection: pi,
                  emissionFrequency: 0.8,
                  numberOfParticles: 10,
                  maxBlastForce: 10,
                ),
              ),
            ),
          ],
        );
      case CurrentPage.scoreboard:
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(15),
              child: SvgPicture.asset('assets/trophy.svg', width: 60,),
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
                  _currentPage = CurrentPage.submitted;
                });
              },),
            ),
          ],
        );
      case CurrentPage.submitted: return WaitingPage();
    }
  }
}