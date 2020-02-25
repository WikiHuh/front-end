import 'package:flutter/material.dart';

class ErrorDialog extends AlertDialog {
  final String error;
  final BuildContext context;

  ErrorDialog(this.context, this.error) : super(
    title: Text("Uh oh", style: TextStyle(color: Colors.black), textAlign: TextAlign.center,),
    content: Text(error, style: TextStyle(color: Colors.black, fontSize: 16), textAlign: TextAlign.center,),
    actions: [
      FlatButton(child: Text('OK', style: TextStyle(color: Colors.black, fontSize: 16),), onPressed: () {
        Navigator.of(context).pop();
      },)
    ]);
}