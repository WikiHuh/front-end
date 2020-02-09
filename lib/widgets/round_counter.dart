import 'package:flutter/material.dart';

class RoundCounter extends StatelessWidget {
  final int round;

  RoundCounter(this.round);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Round', style: Theme.of(context).textTheme.display1,),
        Text(this.round.toString(), style: Theme.of(context).textTheme.display4,)
      ],
    );
  }
}