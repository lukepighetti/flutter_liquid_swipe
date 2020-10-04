import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

import 'liquid_swipe_clipper.dart';
import 'liquid_swipe_data.dart';
import 'liquid_swipe_handle.dart';

class LiquidSwipe extends StatefulWidget {
  /// Draws an interactive liquid swipe flow whose children
  /// are clipped and transitioned when swiping or tapping the handle.
  const LiquidSwipe({Key key, this.children}) : super(key: key);

  /// The pages to display.
  final List<Widget> children;

  @override
  LiquidSwipeState createState() => LiquidSwipeState();
}

class LiquidSwipeState extends State<LiquidSwipe>
    with SingleTickerProviderStateMixin {
  /// A value in pixels per second that will cause the animation to fling left or right.
  ///
  /// Left is negative, right is positive.
  static const flingVelocity = 1800.0;

  AnimationController _controller;
  Animation<Offset> _animation;

  Offset _dragOffset;
  BoxConstraints constraints;

  void _runAnimation(Offset pixelsPerSecond, Size size) {
    final unitsPerSecond = Offset(
      pixelsPerSecond.dx / size.width,
      pixelsPerSecond.dy / size.height,
    );

    final velocity = (pixelsPerSecond.dx / size.width).abs();

    final spring = SpringDescription(mass: 15, stiffness: 1, damping: 1);
    final simulation = SpringSimulation(spring, 0.0, 1.0, velocity * 0.7);

    final flungLeft = unitsPerSecond.dx < -4.0;
    final flungRight = unitsPerSecond.dx > 4.0;
    final onLeft = _dragOffset.dx / size.width < 0.4;

    _animation = _controller.drive(
      Tween(
        begin: _dragOffset,
        end: Offset(
          flungLeft
              ? 0.0
              : flungRight
                  ? size.width
                  : onLeft
                      ? 0.0
                      : size.width,
          size.height * 0.7,
        ),
      ),
    );

    _controller.animateWith(simulation);
  }

  /// Animate to the next page
  void next() {
    _runAnimation(
      Offset(-flingVelocity, 0.0),
      constraints.biggest,
    );
  }

  /// Animate to the previous page
  void previous() {
    _runAnimation(
      Offset(flingVelocity, 0.0),
      constraints.biggest,
    );
  }

  @override
  void initState() {
    _controller ??= AnimationController(vsync: this);

    _controller.addListener(() {
      setState(() {
        _dragOffset = _animation.value;
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        assert(constraints.hasBoundedHeight && constraints.hasBoundedWidth,
            'LiquidSwipe needs a bounded height and width.');

        /// Update constraints on build if possible
        if (this.constraints != constraints) this.constraints = constraints;

        /// The resting position for [LiquidSwipeHandle]
        _dragOffset ??=
            Offset(constraints.maxWidth, constraints.maxHeight * 0.7);

        final data = LiquidSwipeData(
          diameter: 48.0,
          padding: 8.0,
          localPosition: _dragOffset,
          size: constraints.biggest,
        );

        return GestureDetector(
          onPanDown: (_) => _controller.stop(),
          onPanUpdate: (e) => setState(() => _dragOffset += e.delta),
          onPanEnd: (e) => _runAnimation(
            e.velocity.pixelsPerSecond,
            constraints.biggest,
          ),
          child: Material(
            child: Stack(
              fit: StackFit.expand,
              children: [
                /// Background
                widget.children.first,

                /// Next page
                ClipPath(
                  clipper: LiquidSwipeClipper(data: data),
                  child: widget.children[1],
                ),

                /// Handle
                Positioned(
                  top: -data.diameter / 2,
                  left: -data.diameter / 2,
                  child: Transform.translate(
                    offset: data.buttonCenter,
                    child: Opacity(
                      opacity: Curves.easeInCubic.transform(1 - data.progress),
                      child: LiquidSwipeHandle(
                        diameter: data.diameter,
                        onTap: () => next(),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
