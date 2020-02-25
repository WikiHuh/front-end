import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wikihuh/widgets/shadows.dart';

class Countdown extends StatefulWidget {
  final int start;
  final Function onFinish;

  Countdown(this.start, {this.onFinish});

  @override
  _CountdownState createState() => _CountdownState();
}

class _CountdownState extends State<Countdown> {
  Timer timer;
  int t;
  int startMs;

  @override
  void initState() {
    startMs = this.widget.start * 1000;
    t = startMs;
    timer = Timer.periodic(Duration(milliseconds: 1), updateTime);

    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();

    super.dispose();
  }

  void updateTime(Timer newTimer) {
    if (newTimer.tick <= this.startMs) {
      setState(() {
        t = this.startMs - newTimer.tick;
      });
    } else {
      this.timer.cancel();
      this.widget.onFinish();
    }
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.display2;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30),
      padding: EdgeInsets.all(3),
      height: 18,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          DropShadow(),
        ]
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: LinearProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(textStyle.color),
          backgroundColor: Colors.transparent,
          value: this.t / this.startMs,),
      ),
    );
  }
}