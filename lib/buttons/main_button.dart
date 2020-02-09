import 'package:flutter/material.dart';
import 'package:tinycolor/tinycolor.dart';

class MainButton extends StatefulWidget {
  final String text;
  final Function onPressed;

  MainButton({@required this.text, this.onPressed});

  @override
  _MainButtonState createState() => _MainButtonState();
}

class _MainButtonState extends State<MainButton> {
  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 40),
      decoration: BoxDecoration(
        color: Theme.of(context).accentColor,
        borderRadius: BorderRadius.circular(200),
        boxShadow: [
          BoxShadow(
            blurRadius: 0,
            offset: Offset(0, pressed ? 0 : 4),
            color: TinyColor(Theme.of(context).accentColor).darken(10).color
          )
        ]
      ),
      child: FlatButton(
        onPressed: () {
          this.widget.onPressed();
        },
        onHighlightChanged: (bool p) {
          setState(() {
            pressed = p;
          });
        },
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(200)),
        materialTapTargetSize: MaterialTapTargetSize.padded,
        child: Text(this.widget.text, style: Theme.of(context).textTheme.button,)
      ),
    );
  }
}