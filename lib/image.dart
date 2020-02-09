import 'package:flutter/material.dart';
import 'package:tinycolor/tinycolor.dart';
import 'package:transparent_image/transparent_image.dart';

class WikiImage extends StatelessWidget {
  final String url;

  WikiImage(this.url);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Container(
          margin: EdgeInsets.all(30),
          width: constraints.maxWidth,
          height: 0.75 * constraints.maxWidth,
          decoration: BoxDecoration(
            color: TinyColor(Theme.of(context).primaryColor).greyscale().darken(20).color,
            boxShadow: [
              BoxShadow(blurRadius: 20, offset: Offset(0, 10), color: Colors.black.withOpacity(0.1))
            ]
          ),
          child: FadeInImage.memoryNetwork(
            image: this.url,
            placeholder: kTransparentImage,
            width: constraints.maxWidth,
            fadeOutDuration: Duration(milliseconds: 20),
            fadeInDuration: Duration(milliseconds: 20),
            fit: BoxFit.cover
          ),
        );
      }
    );
  }
}