import 'dart:math';

import 'package:flutter/material.dart';
import 'package:wikihuh/animations.dart';
import 'package:wikihuh/objects.dart';
import 'package:wikihuh/sockets.dart';
import 'package:wikihuh/widgets/shadows.dart';

List<Player> sortPlayers(Map<String, Player> players) {
  return players.values.toList()
    ..sort((p1, p2) => p2.score - p1.score)
    ..sublist(0, min(4, players.length));
}

class Leaderboard extends StatelessWidget {
  final Animation<double> animation;

  Leaderboard(this.animation);

  @override
  Widget build(BuildContext context) {
    List<Player> _leaderboard = sortPlayers(CurrentGame.of(context).players);

    return ListView(
      children: [
        for (var p in _leaderboard.asMap().entries)
          FlyIn(
            animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
              parent: this.animation,
              curve: Interval(
                0.1 * p.key, 1 - 0.1 * (3 - p.key),
                curve: Curves.easeInOutBack,
              ),
            )),
            child: Container(
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.symmetric(horizontal: 20.0 + (10 * p.key), vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  DropShadow(),
                  ShadowFrame(fgColor: Colors.white),
                ]
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text((p.key + 1).toString(), style: Theme.of(context).textTheme.display2),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text(p.value.name, style: Theme.of(context).textTheme.display1),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    decoration: BoxDecoration(
                      color: Color(0xffdddddd),
                      borderRadius: BorderRadius.circular(100),
                      boxShadow: [
                        BoxShadow(blurRadius: 10, color: Colors.black.withOpacity(0.1), offset: Offset(0, 5))
                      ]
                    ),
                    child: Text((p.value.score * 100).toString(), style: Theme.of(context).textTheme.body1.copyWith(fontSize: 16)),
                  ),
                ],
              ),
            ),
          ),
      ]
    );
  }
}