import 'package:flutter/material.dart';
import 'package:wikihuh/buttons/main_button.dart';
import 'package:wikihuh/buttons/third_button.dart';
import 'package:wikihuh/game_state.dart';
import 'package:wikihuh/image.dart';
import 'package:wikihuh/pages/make_caption.dart';
import 'package:wikihuh/widgets/round_counter.dart';

class PlayOrSkipPage extends StatefulWidget {
  @override
  _PlayOrSkipPageState createState() => _PlayOrSkipPageState();
}

class _PlayOrSkipPageState extends State<PlayOrSkipPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RoundCounter(1),
              WikiImage(CurrentGame.of(context).imageUrl),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: MainButton(text: 'Play!', onPressed: () {
                  CurrentGame.of(context).send('play', {});
                },),
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: ThirdButton(text: 'Skip', onPressed: () {
                  CurrentGame.of(context).send('skip', {});
                }),
              )
            ],
          ),
        ),
      ),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}