import 'package:flutter/material.dart';
import 'package:wikihuh/animations.dart';
import 'package:wikihuh/objects.dart';
import 'package:wikihuh/pages/waiting.dart';
import 'package:wikihuh/sockets.dart';
import 'package:wikihuh/widgets/buttons.dart';
import 'package:wikihuh/widgets/shadows.dart';
import 'package:wikihuh/widgets/wiki_image.dart';

class VotePage extends StatefulWidget {
  final Animation<double> animation;

  VotePage({this.animation});

  @override
  _VotePageState createState() => _VotePageState();
}

class _VotePageState extends State<VotePage> {
  String _response = '';
  bool _submitted = false;

  @override
  Widget build(BuildContext context) {
    if (_submitted) {
      return WaitingPage();
    }

    List<MapEntry<int, Player>> _options = CurrentGame.of(context).players.values.toList().asMap().entries.toList();

    return Column(
      children: [
        Expanded(
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 80),
                child: WikiImage(CurrentGame.of(context).imageUrl)
              ),
              Container(
                padding: EdgeInsets.fromLTRB(30, 0, 30, 20),
                alignment: Alignment.center,
                child: Text('Choose One', style: Theme.of(context).textTheme.display2, textAlign: TextAlign.center,),
              ),
              for (var p in _options)
                FlyIn(
                  animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
                    parent: this.widget.animation,
                    curve: Interval(
                      0.1 * p.key, 1 - 0.1 * (_options.length - p.key),
                      curve: Curves.easeInOutBack,
                    ),
                  )),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _response = p.value.id;
                      });
                    },
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 100),
                      padding: EdgeInsets.all(20),
                      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: _response == p.value.id ? Colors.white : Colors.white,
                        boxShadow: [
                          DropShadow(),
                          ShadowFrame(fgColor: Colors.white),
                        ]
                      ),
                      child: Text(p.value.response,
                        style: _response == p.value.id ? Theme.of(context).textTheme.body1.copyWith(fontSize: 20) : Theme.of(context).textTheme.body1.copyWith(color: Colors.black.withOpacity(0.5), fontSize: 16), textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
            ]
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Button1(text: 'Continue', onPressed: () {
            if (_response.length > 0) {
              CurrentGame.of(context).send('vote', {'id': _response});
              setState(() {
                _submitted = true;
              });
            }
          },),
        ),
      ],
    );
  }
}