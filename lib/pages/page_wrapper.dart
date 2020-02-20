import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tinycolor/tinycolor.dart';

class PageWrapper extends StatefulWidget {
  final Widget child;

  PageWrapper({this.child});

  @override
  _PageWrapperState createState() => _PageWrapperState();
}

class _PageWrapperState extends State<PageWrapper> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData mq = MediaQuery.of(context);
    return Stack(
      children: <Widget>[
        SizedBox.expand(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  TinyColor(Theme.of(context).primaryColor).brighten(3).color,
                  Theme.of(context).primaryColor,
                ],
                stops: [
                  0.0,
                  0.6
                ]
              )
            ),
            child: SvgPicture.asset('assets/background.svg',
              width: mq.size.width,
              height: mq.size.height,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.only(top: 30, bottom: mq.viewInsets.bottom == 0 ? 30 : 0),
              child: this.widget.child,
            ),
          ),
        ),
      ],
    );
  }
}