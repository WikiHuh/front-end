import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wikihuh/pages/home.dart';
import 'package:wikihuh/pages/page_wrapper.dart';
import 'package:wikihuh/widgets/buttons.dart';
import 'package:wikihuh/widgets/shadows.dart';
import 'package:wikihuh/widgets/wikihuh_logo.dart';

class IntroPage extends StatefulWidget {
  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  SharedPreferences _prefs;
  bool _showIntro;

  @override
  void initState() {
    _showIntro = true;
    
    SharedPreferences.getInstance().then((p) {
      setState(() {
        _prefs = p;
        _showIntro = p.getBool("showIntro")?? true;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (!_showIntro) {
      return HomePage();
    }

    return PageWrapper(
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              WikihuhLogo(),
              Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(top: 30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    DropShadow(),
                    ShadowFrame(fgColor: Colors.white)
                  ]
                ),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(bottom: 14),
                      child: Text("How to Play:", style: Theme.of(context).textTheme.display1,),
                    ),
                    HowToItem(1, "Random pictures from WikiHow are shown to you and your friends"),
                    HowToItem(2, "Everyone has 30 seconds to write a funny article title for the image"),
                    HowToItem(3, "Compete to get the most votes and win the game!")
                  ],
                )
              ),
              Padding(
                padding: EdgeInsets.only(top: 40, bottom: 30),
                child: Button1(text: 'Play!', onPressed: () {
                  if (_showIntro) {
                    _prefs?.setBool('showIntro', false);
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
                  }
                },),
              ),
            ],
          ),
        )
      ),
    );
  }
}

class HowToItem extends StatelessWidget {
  final String content;
  final int itemNum;

  HowToItem(this.itemNum, this.content);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Row(
        children: <Widget>[
          Container(
            width: 20,
            margin: EdgeInsets.only(right: 20),
            child: Text(itemNum.toString(), style: Theme.of(context).textTheme.display2,),
          ),
          Expanded(child: Text(this.content)),
        ],
      ),
    );
  }
}