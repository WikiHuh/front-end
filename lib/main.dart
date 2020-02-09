import 'package:flutter/material.dart';
import 'package:wikihuh/game_state.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SocketLoader();
  }
}
