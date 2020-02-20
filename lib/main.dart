import 'package:flutter/material.dart';
import 'package:wikihuh/sockets.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SocketLoader();
  }
}
