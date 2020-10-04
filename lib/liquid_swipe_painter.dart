import 'package:flutter/material.dart';

import 'liquid_swipe_data.dart';

class LiquidSwipePainter extends CustomPainter {
  /// Painter that uses a liquid swipe path.
  LiquidSwipePainter({@required this.data});

  final LiquidSwipeData data;

  Size get size => data.size;

  @override
  void paint(Canvas canvas, _) {
    if (data.localPosition == null) return;

    var paint = Paint()
      ..color = Colors.red.withOpacity(0.5)
      ..style = PaintingStyle.fill
      ..strokeWidth = 1.0;

    final path = data.liquidSwipePath;

    canvas..drawPath(path, paint);
    canvas
      ..drawCircle(
        data.buttonCenter,
        data.diameter / 2,
        paint,
      );
  }

  @override
  bool shouldRepaint(LiquidSwipePainter old) => data != old.data;
}
