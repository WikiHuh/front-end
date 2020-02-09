import 'package:flutter/material.dart';
import 'package:wikihuh/buttons/secondary_button.dart';
import 'package:wikihuh/buttons/third_button.dart';
import 'package:wikihuh/game_state.dart';
import 'package:wikihuh/image.dart';
import 'package:wikihuh/pages/play_or_skip.dart';
import 'package:wikihuh/widgets/countdown.dart';

class MakeCaptionPage extends StatefulWidget {
  @override
  _MakeCaptionPageState createState() => _MakeCaptionPageState();
}

class _MakeCaptionPageState extends State<MakeCaptionPage> {
  String _caption;

  @override
  void initState() {
    _caption = "";

    super.initState();
  }

  void onSubmit() {
    CurrentGame.of(context).send("set-caption", {'caption': _caption});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 30),
            child: Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Countdown(30, onFinish: onSubmit,),
                  WikiImage(CurrentGame.of(context).imageUrl),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    alignment: Alignment.centerLeft,
                    child: Text('How to...', style: Theme.of(context).textTheme.display1,),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 30, right: 30, top: 20, bottom: 30),
                    child: TextFormField(
                      onChanged: (String val) {
                        setState(() {
                          _caption = val;
                        });
                      },
                      onEditingComplete: onSubmit,
                      style: Theme.of(context).textTheme.body1,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        fillColor: Colors.white,
                        focusColor: Colors.white,
                        filled: true,
                      ),
                      maxLines: 1
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ThirdButton(text: 'Pick random', icon: Icons.refresh, onPressed: () {
                          setState(() {
                            _caption = "RANDOM"; // TODO: Random caption gen
                          });
                          onSubmit();
                        },),
                        SecondaryButton(text: 'Submit', onPressed: onSubmit)
                      ]
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}