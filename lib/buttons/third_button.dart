import 'package:flutter/material.dart';

class ThirdButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final Function onPressed;

  ThirdButton({@required this.text, this.icon, this.onPressed});

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