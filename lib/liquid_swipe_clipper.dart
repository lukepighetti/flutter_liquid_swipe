import 'package:flutter/material.dart';

import 'liquid_swipe_data.dart';

class LiquidSwipeClipper extends CustomClipper<Path> {
  /// Clipper that uses a liquid swipe path.
  LiquidSwipeClipper({@required this.data});

  final LiquidSwipeData data;

  @override
  Path getClip(_) {
    return data.liquidSwipePath;
  }

  @override
  bool shouldReclip(LiquidSwipeClipper old) => data != old.data;
}
