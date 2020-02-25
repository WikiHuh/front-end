import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wikihuh/sockets.dart';
import 'package:wikihuh/widgets/round_counter.dart';

class WaitingPage extends StatefulWidget {
  @override
  _WaitingPageState createState() => _WaitingPageState();
}

class _WaitingPageState extends State<WaitingPage> {
  Timer _timer;
  bool _ready;

  @override
  void initState() {
    _ready = false;
    _timer = Timer.periodic(Duration(milliseconds: 100), timerComplete);

    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    
    super.dispose();
  }

  void timerComplete(Timer t) {
    setState(() {
      _timer.cancel();
      _ready = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _ready ? Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          RoundCounter(CurrentGame.of(context).round + 1),
          Padding(
            padding: EdgeInsets.only(bottom: 40),
            child: Text('Waiting for others', style: Theme.of(context).textTheme.body1,),
          ),
          CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).textTheme.display2.color))
        ],
      ),
    ) : Container();
  }
}