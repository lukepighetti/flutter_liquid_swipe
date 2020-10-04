import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';

import 'liquid_swipe_card.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'liquid_swipe',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: _HomePage(),
    );
  }
}

class _HomePage extends StatelessWidget {
  _HomePage({Key key}) : super(key: key);

  final _key = GlobalKey<LiquidSwipeState>();
  LiquidSwipeState get liquidSwipeController => _key.currentState;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LiquidSwipe(
        key: _key,
        children: [
          /// First page
          LiquidSwipeCard(
            onSkip: () => liquidSwipeController.next(),
            name: "GameCoin",
            action: "Skip",
            image: AssetImage(
              "assets/first-page-image.png",
            ),
            title: "Online",
            subtitle: "Gambling",
            body:
                "Temporibus autem aut\nofficiis debitis aut rerum\nnecessatatibus.",
            buttonColor: Colors.purple.shade800,
            titleColor: Colors.purple.shade100,
            subtitleColor: Colors.grey.shade900,
            bodyColor: Colors.purple.shade50,
            gradient: LinearGradient(
              colors: [Colors.white, Colors.white],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),

          /// Second page
          LiquidSwipeCard(
            onTapName: () => liquidSwipeController.previous(),
            name: "Back",
            action: "",
            image: AssetImage(
              "assets/second-page-image.png",
            ),
            title: "For",
            subtitle: "Gamers",
            body:
                "Excepteur sint occaecat cupidatat \nnonproident, sunt in \nculpa qui officia",
            buttonColor: Colors.white.withOpacity(0.9),
            titleColor: Colors.pink.shade200.withOpacity(0.5),
            subtitleColor: Colors.pink.shade100.withOpacity(0.8),
            bodyColor: Colors.white.withOpacity(0.8),
            gradient: LinearGradient(
              colors: [Colors.purple.shade700, Colors.purple.shade600],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),

          /// Third page
          LiquidSwipeCard(
            onTapName: () => liquidSwipeController.previous(),
            name: "Back",
            action: "",
            image: AssetImage(
              "assets/third-page-image.png",
            ),
            title: "Cash",
            subtitle: "Prizes",
            body:
                "Delorem sunt occaecat cupidatat \nnonproident, mit a \nculpa qui officia",
            buttonColor: Colors.white.withOpacity(0.9),
            titleColor: Colors.red.shade200.withOpacity(0.5),
            subtitleColor: Colors.red.shade100.withOpacity(0.8),
            bodyColor: Colors.white.withOpacity(0.8),
            gradient: LinearGradient(
              colors: [Colors.red.shade700, Colors.red.shade600],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ],
      ),
    );
  }
}
