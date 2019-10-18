import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';

class Ani extends StatefulWidget {
  @override
  _AniState createState() => _AniState();
}

class _AniState extends State<Ani> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: AnimatedBackground(
          behaviour: RandomParticleBehaviour(),
          vsync: this,
          child: Text('Hello'),
        ),
      ),
    );
  }
}
