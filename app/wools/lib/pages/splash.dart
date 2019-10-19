import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wools/widgets/images_widget.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  String nextPage = 'login';

  startTime() async {
    //设置启动图生效时间
    var _duration = new Duration(seconds: 1);
    return new Timer(_duration, navigationPage);

  }

  void navigationPage() {
    Navigator.of(context).pushReplacementNamed(nextPage);
  }

  @override
  void initState() {
    super.initState();
    _isLogin();
    startTime();
  }

  void _isLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';
    if (token.isNotEmpty) {
      nextPage = 'home';
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset('assets/images/launch_image.png'),
      ),
    );
  }
}