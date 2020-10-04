import 'package:flutter/material.dart';

class LiquidSwipeData {
  /// The calculations for a Liquid Swipe path based on transition inputs
  /// and handle diameter and padding.
  LiquidSwipeData({
    @required this.localPosition,
    @required this.padding,
    @required this.diameter,
    @required this.size,
  });

  /// The size of the viewport we are painting to.
  final Size size;

  /// The position of the [LiquidSwipeHandle] center within the viewport.
  ///
  /// Typically driven from gesture pan offset, or defaulting to the lower right.
  final Offset localPosition;

  /// The padding around the [LiquidSwipeHandle]
  final double padding;

  /// The diameter of the [LiquidSwipeHandle]
  final double diameter;

  /// The maximum width this liquid swipe can traverse
  double get xMax {
    return size.width - diameter / 2 - padding;
  }

  /// The current x position
  double get x {
    return localPosition.dx.clamp(0.0, xMax);
  }

  /// The swipe progress from `0.0` to `1.0`
  double get progress {
    return (xMax - x) / xMax;
  }

  /// The [LiquidSwipeHandle] center
  Offset get buttonCenter {
    return Offset(x, localPosition.dy);
  }

  /// Generate the liquid swipe path
  Path get liquidSwipePath {
    final _curve = Curves.easeOut;
    final _sideOffsetCurve = Interval(0.5, 0.8, curve: Curves.easeInOut);

    final d = diameter + padding * 2;
    final r = d / 2;

    /// Canvas and touch position
    final w = size.width;
    final h = size.height;

    final xMax = this.xMax;
    final x = this.x;
    final y = localPosition.dy;

    final sideOffset = diameter * 0.4 +
        _sideOffsetCurve.transform(progress) * (w - diameter * 0.4);

    final apexSpread = r * 1.2 + _curve.transform(progress) * xMax * 0.5;
    final anchorOffset = r * 2.0 + _curve.transform(progress) * xMax * 1.8;
    final anchorSpread = r * 2.0 + _curve.transform(progress) * xMax * 1.2;

    final path = Path();

    /// Top side
    path
      ..moveTo(w, 0)
      ..lineTo(w - sideOffset, 0);

    /// Curvy lump
    path
      ..lineTo(w - sideOffset, y - anchorOffset)
      ..cubicTo(
        /// Control handle A
        w - sideOffset,
        y - anchorOffset + anchorSpread / 2,

        /// Control handle b
        x - r,
        y - apexSpread,

        /// Given point
        x - r,
        y,
      )
      ..cubicTo(
        /// Control handle A
        x - r,
        y + apexSpread,

        /// Control handle b
        w - sideOffset,
        y + anchorOffset - anchorSpread / 2,

        /// Given point
        w - sideOffset,
        y + anchorOffset,
      );

    /// Bottom side
    path
      ..lineTo(w - sideOffset, h)

      /// Canvas lower left
      ..lineTo(w, h)

      /// Close
      ..close();

    return path;
  }

  @override
  operator ==(covariant LiquidSwipeData old) =>
      old.diameter == diameter &&
      old.localPosition == localPosition &&
      old.padding == padding &&
      old.size == size;

  @override
  int get hashCode =>
      diameter.hashCode ^
      localPosition.hashCode ^
      padding.hashCode ^
      size.hashCode;
}
