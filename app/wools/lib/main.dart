import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:wools/pages/login.dart';
import 'package:wools/pages/post.dart';
import 'package:wools/pages/splash.dart';
import 'package:wools/pages/tags_page.dart';
import 'package:wools/pages/home/home.dart';

void main() async {
//  await AMap.init('e70da01d267562f50db59a22b36fc4b6');
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: MaterialApp(
        title: '找羊毛',
        theme: ThemeData(
          primarySwatch: Colors.pink,
        ),
        home: Splash(),
        routes: <String, WidgetBuilder> {
          // 这里可以定义静态路由，不能传递参数
          'home': (BuildContext context) => Home(),
          'login': (BuildContext context) => LoginPage(),
          'tags': (BuildContext context) => TagsPage(),
        },
      ),
    );
  }
}
