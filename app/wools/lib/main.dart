import 'package:amap_base_location/amap_base_location.dart';
import 'package:flutter/material.dart';
import 'package:jpush_flutter/jpush_flutter.dart';
import './pages/home.dart';
import 'package:flutter/services.dart';

void main() async {
  await AMap.init('e70da01d267562f50db59a22b36fc4b6');
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String debugLable = 'Unknown';
  final JPush jpush = new JPush();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    String platformVersion;
    jpush.setup(
      appKey: "b827094e9bb4ca5dbdadbf82",
      channel: "theChannel",
      production: false,
      debug: false,
    );
    try {
      /*监听响应方法的编写*/
      jpush.addEventHandler(
        onReceiveNotification: (Map<String, dynamic> message) async {
          print(">>>>>>>>>>>>>>>>>flutter 接收到推送: $message");
          setState(() {
            debugLable = "接收到推送: $message";
          });
        },
        onOpenNotification: (Map<String, dynamic> message) async {
          print("flutter onOpenNotification: $message");
          setState(() {
            debugLable = "flutter onOpenNotification: $message";
          });
        },
        onReceiveMessage: (Map<String, dynamic> message) async {
          print("flutter onReceiveMessage: $message");
          setState(() {
            debugLable = "flutter onReceiveMessage: $message";
          });
        },
      );

    } on PlatformException {
      platformVersion = '平台版本获取失败，请检查！';
    }

    if (!mounted){
      return;
    }

    setState(() {
      debugLable = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: Home(title: '撸羊毛',),
    );
  }
}
