import 'package:flutter/material.dart';

class WikihuhLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'wiki',
          style: Theme.of(context).textTheme.display3,
        ),
        Text(
          'HUH?',
          style: Theme.of(context)
              .textTheme
              .display3
              .copyWith(color: Colors.white),
        ),
      ],
    );
  }
}
