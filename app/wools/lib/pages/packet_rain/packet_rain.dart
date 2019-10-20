import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:wools/resource/gaps.dart';
import 'package:wools/widgets/images_widget.dart';

class PacketRain extends StatefulWidget {
  @override
  _PacketRainState createState() => _PacketRainState();
}

class _PacketRainState extends State<PacketRain> with TickerProviderStateMixin {

  StreamSubscription _subscription;
  final int second = 15;
  int time = 15;
  bool _isClick = true;
  Animation<Offset> animation;
  Animation<Offset> animation2;
  AnimationController controller;
  List _animations = [];
  Color c = Colors.pink;
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();

  List<String> _data = ['horse', 'cow', 'fjk', 'fdk', 'df'];

  @override
  void initState() {
    super.initState();
    _initAnimation();
    _countTime();
  }

  void _initAnimation () {
    controller = AnimationController(duration: const Duration(milliseconds: 3000), vsync: this);
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        //AnimationStatus.completed 动画在结束时停止的状态
        //ontroller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        //AnimationStatus.dismissed 表示动画在开始时就停止的状态
        //controller.forward();
      }
    });
    animation = Tween(begin: Offset.zero, end: Offset(0, 5)).animate(controller);
    animation2 = Tween(begin: Offset.zero, end: Offset(0, 1)).animate(controller);
    controller.forward();
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (context) {
        // 用Scaffold返回显示的内容，能跟随主题
        return Scaffold(
          backgroundColor: Colors.transparent, // 设置透明背影
          body: Center( // 居中显示
            child: Container(
              width: 220,
              height: 240,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12)
              ),
              child: Column( // 定义垂直布局
                mainAxisAlignment: MainAxisAlignment.center, // 主轴居中布局，相关介绍可以搜下flutter-ui的内容
                children: <Widget>[
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Gaps.vGap16,
                        Text('88', style: TextStyle(color: Colors.pink, fontSize: 20),),
                        Gaps.vGap5,
                        Text('恭喜您抢到了88羊毛', style: TextStyle(color: Color(0xff333333)),),
                        Gaps.vGap20,
                        FlatButton(
                          color: Colors.pink,
                          textColor: Colors.white,
                          padding: EdgeInsets.all(8.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          onPressed: (){
                            Navigator.of(context).pop();
                          },
                          child: Text('确定'),
                        ),
                      ],
                    ),
                  ),
                  loadAssetImage('packet_rain/dialog_bg', width: double.infinity, height: 75)
                ],
              ),
            ), // 自带loading效果，需要宽高设置可在外加一层sizedbox，设置宽高即可
          ),
        );
      },
    );
  }

  void _countTime() {
    _subscription = Observable.periodic(Duration(seconds: 1), (i) => i).take(second).listen((i){
      setState(() {
        time = second - i - 1;
        _isClick = time < 1;
      });
    });
    _alertDialog();
  }

  _alertDialog() {
    Future.delayed(Duration(seconds: 2), () {
      _showDialog();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _subscription?.cancel();

    //路由销毁时需要释放动画资源
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top,),
          decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage('assets/images/packet_rain/bg.png',), fit: BoxFit.cover)
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 20, left: 20),
                child: Stack(
                  children: <Widget>[
                    Container(
                      width: 68,
                      height: 24,
                      padding: EdgeInsets.only(right: 16),
                      margin: EdgeInsets.only(top: 6),
                      child: Text(time.toString(), textAlign: TextAlign.end,),
                      decoration: BoxDecoration(
                          color: Colors.pink,
                          borderRadius: BorderRadius.circular(20)
                      ),
                    ),
                    loadAssetImage('packet_rain/timer_tiny', width: 26, height: 30),
                  ],
                ),
              ),
              SizedBox(
                height: 500,
                width: double.infinity,
                child: AnimatedList(
                  key: _listKey,
                  initialItemCount: _data.length,
                  itemBuilder: (context, index, animation) {
                    return _buildItem(_data[index]);
                  },
                ),
              ),
//
            ],
          )
      )
    );
  }

  Widget _buildItem (String item) {
    return SlideTransition(
        position: animation,
        child: Container(
          margin: EdgeInsets.only(left: Random().nextDouble() * 200),
          height: 100,
          width: 100,
          child: Image.network('http://wool.junmapp.com/assert/wool.png')
        )
    );
  }

  Widget woolItem() {
    return SlideTransition(
      position: animation2,
      child: Container(
        color: Colors.pink,
        height: 100,
        width: 100,
        child: Text(''),
      )
    );
  }
}