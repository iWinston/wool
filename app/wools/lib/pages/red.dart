import 'dart:async';
import 'dart:math';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:wools/pages/header_painter.dart';

class BackgroundWidget extends StatefulWidget {
  _BackgroundWidgetState createState() => new _BackgroundWidgetState();
}

class _BackgroundWidgetState extends State<BackgroundWidget> with SingleTickerProviderStateMixin {
  int time = 0;
  final int second = 15;
  Animation<double> animation;
  AnimationController controller;
  Animation<Offset> animationStarOffset;
  StreamSubscription _subscription;

  initState() {
    super.initState();
    controller = new AnimationController(
        duration: const Duration(milliseconds: 3000), vsync: this);
    animation = new Tween(begin: 0.0, end: 345.0).animate(controller)
      ..addListener(() {
        setState(() {});
      });

    _drawItem();
  }

  void _drawItem () {
    var beginOffset = new Offset(290.0, 0.0);
    var endOffset = _getEndOffset(beginOffset);
    animationStarOffset =
        new Tween<Offset>(begin: beginOffset, end: endOffset).animate(controller);
    controller.forward();
  }

  void _countTime() {
    _subscription = Observable.periodic(Duration(seconds: 1), (i) => i).take(second).listen((i){
      setState(() {
        time = second - i - 1;
      });
      if (time < 15) {
        _drawItem();
      }
    });
//    if (widget.time < 15) {
//      _drawItem();
//    }
  }

  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      body: new Stack(
        alignment: new Alignment(0.5, 0.94),
        children: <Widget>[
          new CustomPaint(
            painter:
            new HeaderPainter(animation.value, animationStarOffset.value),
            child: new Container(height: 345.0),
          ),
          new Image.asset(
            'assets/images/packet_rain/timer.png',
            scale: 15.0,
          ),
        ],
      ),
    );
  }

  dispose() {
    controller.dispose();
    super.dispose();
  }

  _getRandomBeginOffset() {
    var dy = 0.0;
    var dx = Random().nextInt(345).toDouble();
    return new Offset(dx, dy);
  }

  _getEndOffset(Offset beginOffset) {
    var radians = 30.0 * pi / 180;
    var dy = 345.0;
    var dx = beginOffset.dx - dy * cos(radians) / sin(radians);
    return Offset(dx, dy);
  }
}