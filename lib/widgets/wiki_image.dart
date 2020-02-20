import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:wikihuh/widgets/shadows.dart';

class WikiImage extends StatelessWidget {
  final String url;

  WikiImage(this.url);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Padding(
          padding: EdgeInsets.all(30),
          child: Container(
            padding: EdgeInsets.all(6),
            width: constraints.maxWidth,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: [
                DropShadow(),
                ShadowFrame(fgColor: Colors.white),
              ]
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: FadeInImage.memoryNetwork(
                image: this.url,
                placeholder: kTransparentImage,
                width: constraints.maxWidth,
                height: 0.75 * constraints.maxWidth,
                fadeOutDuration: Duration(milliseconds: 20),
                fadeInDuration: Duration(milliseconds: 20),
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
              ),
            ),
          ),
        );
      }
    );
  }
}