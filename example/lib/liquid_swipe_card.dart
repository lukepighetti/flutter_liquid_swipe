import 'package:flutter/material.dart';

class LiquidSwipeCard extends StatelessWidget {
  const LiquidSwipeCard({
    Key key,
    this.gradient,
    this.buttonColor,
    this.name,
    this.action,
    this.image,
    this.title,
    this.titleColor,
    this.subtitle,
    this.subtitleColor,
    this.body,
    this.bodyColor,
    this.onTapName,
    this.onSkip,
  }) : super(key: key);

  final Gradient gradient;
  final Color buttonColor;
  final String name;
  final String action;
  final ImageProvider image;
  final String title;
  final Color titleColor;
  final String subtitle;
  final Color subtitleColor;
  final String body;
  final Color bodyColor;
  final VoidCallback onTapName;
  final VoidCallback onSkip;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: gradient,
      ),
      child: SafeArea(
        minimum: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // TODO(Luke Pighetti): extract into [LiquidSwipeView]
            // Action Bar
            Builder(
              builder: (context) {
                var _style = TextStyle(
                  color: buttonColor,
                  fontSize: 15,
                  fontWeight: FontWeight.normal,
                );

                return Row(
                  children: [
                    FlatButton(
                      child: Text(
                        name,
                        style: _style,
                      ),
                      onPressed: onTapName,
                      shape: StadiumBorder(),
                    ),
                    Spacer(),
                    FlatButton(
                      child: Text(
                        action,
                        style: _style,
                      ),
                      onPressed: onSkip,
                      shape: StadiumBorder(),
                    ),
                    SizedBox(width: 16.0 * 2),
                  ],
                );
              },
            ),
            Spacer(),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.all(16),
              child: Image(
                image: image,
                height: 200,
              ),
            ),
            Spacer(),
            Text(
              title,
              style: TextStyle(
                fontSize: 36,
                color: titleColor,
              ),
            ),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 48,
                height: 1.0,
                color: subtitleColor,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 16),
            FractionallySizedBox(
              widthFactor: 0.7,
              alignment: Alignment.centerLeft,
              child: Text(
                body,
                style: TextStyle(
                  fontSize: 16,
                  color: bodyColor,
                ),
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
