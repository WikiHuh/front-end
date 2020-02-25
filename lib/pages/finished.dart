import 'package:flutter/material.dart';
import 'package:wikihuh/widgets/buttons.dart';
import 'package:wikihuh/widgets/leaderboard.dart';

class FinishedPage extends StatefulWidget {
  final Animation<double> animation;

  FinishedPage({@required this.animation});

  @override
  _FinishedPageState createState() => _FinishedPageState();
}

class _FinishedPageState extends State<FinishedPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.all(20),
          child: Text("GAME OVER!", style: Theme.of(context).textTheme.display3, textAlign: TextAlign.center,),
        ),
        Expanded(child: Leaderboard(this.widget.animation)),
        Button1(text: "Done", onPressed: () {
          Navigator.of(context).pop();
        },)
      ]
    );
  }
}