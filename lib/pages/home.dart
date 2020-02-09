import 'package:flutter/material.dart';
import 'package:wikihuh/buttons/main_button.dart';
import 'package:wikihuh/game_state.dart';
import 'package:wikihuh/pages/enter_pin.dart';

class HomePage extends StatefulWidget {
  final Function(String) setName;

  HomePage({@required this.setName});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _name;

  @override
  void initState() {
    _name = '';

    super.initState();
  }

  void onSubmit() {
    this.widget.setName(_name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Center(
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('wiki', style: Theme.of(context).textTheme.display3,),
                    Text('HUH?', style: Theme.of(context).textTheme.display3.copyWith(color: Colors.white),),
                  ],
                ),
                Container(
                  padding: EdgeInsets.only(left: 30, right: 30, top: 20, bottom: 30),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: TextFormField(
                      onChanged: (String val) {
                        setState(() {
                          _name = val;
                        });
                      },
                      onEditingComplete: onSubmit,
                      style: Theme.of(context).textTheme.body1,
                      decoration: InputDecoration(
                        hintText: 'Your name',
                        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        border: InputBorder.none,
                        fillColor: Colors.white,
                        focusColor: Colors.white,
                        filled: true,
                      ),
                      maxLines: 1
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: MainButton(text: 'Create Game', onPressed: () {
                    onSubmit();
                    CurrentGame.of(context).send('create game', {'name': 'kirpal'});
                  },),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: MainButton(text: 'Join Game', onPressed: () {
                    onSubmit();
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => EnterPinPage()));
                  },),
                ),
              ],
            ),
          ),
        ),
      ),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}