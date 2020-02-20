import 'package:flutter/material.dart';
import 'package:wikihuh/widgets/shadows.dart';

class _MainButton extends StatefulWidget {
  final String text;
  final Function onPressed;
  final TextStyle style;

  _MainButton({@required this.text, @required this.onPressed, @required this.style});

  @override
  _MainButtonState createState() => _MainButtonState();
}

class _MainButtonState extends State<_MainButton> {
  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      transform: Matrix4.translationValues(0, pressed ? 4 : 0, 0),
      duration: Duration(milliseconds: 40),
      decoration: BoxDecoration(
        color: Theme.of(context).accentColor,
        borderRadius: BorderRadius.circular(200),
        boxShadow: [
          DropShadow(),
          ShadowFrame(fgColor: Theme.of(context).accentColor, height: pressed ? 0 : 4),
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
        child: Text(this.widget.text, style: this.widget.style)
      ),
    );
  }
}

class Button1 extends StatelessWidget {
  final String text;
  final Function onPressed;

  Button1({@required this.text, @required this.onPressed});
  
  @override
  Widget build(BuildContext context) {
    return _MainButton(text: this.text, onPressed: this.onPressed, style: Theme.of(context).textTheme.button);
  }
}

class Button2 extends StatelessWidget {
  final String text;
  final Function onPressed;

  Button2({@required this.text, @required this.onPressed});
  
  @override
  Widget build(BuildContext context) {
    return _MainButton(text: this.text, onPressed: this.onPressed, style: Theme.of(context).accentTextTheme.button);
  }
}

class Button3 extends StatelessWidget {
  final String text;
  final IconData icon;
  final Function onPressed;

  Button3({@required this.text, this.icon, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: () {

        this.onPressed();
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      materialTapTargetSize: MaterialTapTargetSize.padded,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (this.icon != null)
            Padding(
              padding: EdgeInsets.only(right: 3),
              child: Icon(this.icon, color: Theme.of(context).accentTextTheme.button.color, size: Theme.of(context).accentTextTheme.button.fontSize,),
            ),
          Text(this.text, style: Theme.of(context).accentTextTheme.button,),
        ],
      )
    );
  }
}