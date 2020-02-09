import 'dart:async';

import 'package:flutter/material.dart';

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
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(width: 100, height: 100, child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).textTheme.display2.color),
          strokeWidth: 8,
          value: this.t / this.startMs,)
        ),
        Text((t / 1000).ceil().toString(), style: Theme.of(context).textTheme.display2,),
      ],
    );
  }
}