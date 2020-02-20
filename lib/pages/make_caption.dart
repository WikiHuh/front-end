
import 'package:flutter/material.dart';
import 'package:wikihuh/animations.dart';
import 'package:wikihuh/pages/waiting.dart';
import 'package:wikihuh/sockets.dart';
import 'package:wikihuh/widgets/buttons.dart';
import 'package:wikihuh/widgets/countdown.dart';
import 'package:wikihuh/widgets/shadows.dart';
import 'package:wikihuh/widgets/wiki_image.dart';

class MakeCaptionPage extends StatefulWidget {
  final Animation<double> animation;

  MakeCaptionPage({this.animation});

  @override
  _MakeCaptionPageState createState() => _MakeCaptionPageState();
}

class _MakeCaptionPageState extends State<MakeCaptionPage> {
  String _caption;
  bool _submitted;

  @override
  void initState() {
    _caption = "";
    _submitted = false;

    super.initState();
  }

  void onSubmit({bool random = false}) {
    if (_caption.length > 0 || random) {
      CurrentGame.of(context).send('response', {'caption' : _caption, 'random': random});
      setState(() {
        _submitted = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_submitted) {
      return WaitingPage();
    }

    return Form(
      child: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          child: SizedBox(
            width: constraints.maxWidth,
            height: MediaQuery.of(context).size.height - MediaQuery.of(context).viewPadding.vertical - 90 + MediaQuery.of(context).viewInsets.bottom,
            child: Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Column(
                children: <Widget>[
                  Countdown(30, onFinish: () => onSubmit(random: true),),
                  ...[Expanded(
                        child: CardBounce(
                          animation: CurvedAnimation(
                            curve: Curves.easeInOutBack,
                            parent: this.widget.animation
                          ),
                          child: WikiImage(CurrentGame.of(context).imageUrl),
                        )
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        alignment: Alignment.centerLeft,
                        child: Text('How to...', style: Theme.of(context).textTheme.display1,),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 30, right: 30, top: 20, bottom: 30),
                        decoration: BoxDecoration(
                          boxShadow: [
                            DropShadow()
                          ]
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
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
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20, right: 20, bottom: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Button3(text: 'Pick random', icon: Icons.refresh, onPressed: () {
                              onSubmit(random: true);
                            },),
                            Button2(text: 'Submit', onPressed: onSubmit)
                          ]
                        ),
                      )
                  ]
                ],
              ),
            )
          )
        ),
      )
    );
  }
}