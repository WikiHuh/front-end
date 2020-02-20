import 'dart:math' as math;

import 'package:flutter/material.dart';

class CardBounce extends AnimatedBuilder {
  final Widget child;
  final Animation animation;

  CardBounce({this.child, this.animation})
   : super(animation: animation, child: child, builder: (context, child) {
      return Transform.translate(
        offset: Offset(10 - (10 * animation.value), 0),
        child: Transform.rotate(
          angle: math.pi / 300 * (1 - animation.value),
          child: Opacity(
            opacity: math.min(1, math.max(0, 0.5 + 0.5 * animation.value)),
            child: child,
          ),
        ),
      );
   });
}

class FlyIn extends AnimatedBuilder {
  final Widget child;
  final Animation animation;

  FlyIn({this.child, this.animation})
   : super(animation: animation, child: child, builder: (context, child) {
      return Transform.translate(
        offset: Offset(0, 50 * (1 - animation.value)),
        child: Opacity(
          opacity: math.min(1, math.max(0, animation.value)),
          child: child,
        ),
      );
   });
}