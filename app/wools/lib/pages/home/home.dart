import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:jpush_flutter/jpush_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wools/dao/tags_dao.dart';
import 'package:wools/model/home_model.dart';
import 'package:wools/model/tags_model.dart';
import 'package:wools/pages/home/provider/provider.dart';
import 'package:wools/pages/home/widgets/info_list.dart';
import 'package:wools/pages/location_view.dart';
import 'package:wools/pages/packet_rain/packet_rain.dart';
import 'package:wools/pages/post.dart';
import 'package:wools/pages/tags.dart';
import 'package:wools/resource/gaps.dart';
import 'package:wools/utils/event_bus.dart';
import 'package:wools/widgets/images_widget.dart';
import 'package:wools/pages/home/widgets/info_card.dart';
import 'package:wools/model/card_info.dart';
import 'package:flutter/services.dart';
import 'package:wools/net/http.dart';
import '../login.dart';

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class TabTitle {
  String title;
  int id;

  TabTitle(this.title, this.id);
}

class _HomeState extends State<Home>  with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin{

  final JPush jpush = new JPush();
  TabController _tabController;
  PageController _pageController = PageController(initialPage: 0);
  TabPageProvider provider = TabPageProvider();
  List<TabTitle> tabList = [];
  bool isPageCanChanged = true;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
  List<TagItem> tabs = [];
  String city = '深圳';
  int _id;
  String _name = '';
  String _avatorPath = '';
  var pointE;


  @override
  void initState() {
    super.initState();
    initPlatformState();
    _initUserInfo();
    getData();
//    pointE = eventBus.on<pointEvent>().listen((event){
//      print(event);
//    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  _initUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    String name = prefs.getString('name');
    String avatorPath = prefs.getString('avatorPath');
    int id = prefs.getInt('id');
    print(name);
    print(id);
    this.setState((){
      _id = id;
      _name = name;
      _avatorPath = avatorPath;
    });
  }

  void getData() async {
    TagsModel res = await TagsDao.fetch();
    print(res.status);
    setState(() {
      tabs = res.data;
      _tabController = TabController(vsync: this, length: tabs.length);
    });
  }

  void initTabData() {
//    tabList = [
//      new TabTitle('推荐', 10),
//      new TabTitle('热点', 0),
//      new TabTitle('社会', 1),
//      new TabTitle('娱乐', 2),
//      new TabTitle('体育', 3),
//      new TabTitle('美文', 4),
//      new TabTitle('科技', 5),
//      new TabTitle('财经', 6),
//      new TabTitle('时尚', 7),
//    ];
  }


  _onPageChange(int index) {
    _tabController.animateTo(index);
    provider.setIndex(index);
  }

  Future<void> initPlatformState() async {
    String platformVersion;
    String debugLable = 'Unknown';

    jpush.getRegistrationID().then((rid) {
      print(rid);
      setState(() {
        debugLable = "flutter getRegistrationID: $rid";
      });
    });

    jpush.setup(
      appKey: "2901ac7f6638c56788f37156",
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
          print("flutter onOpenNotification点击通知: $message");
          setState(() {
            debugLable = "flutter onOpenNotification: $message";
          });
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => PacketRain()));
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
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      drawer: _drawer,
      body: Column(
        children: <Widget>[
          _appBar,
          tabs.length > 0 ? TabBar(
            onTap: (index){
              if (!mounted){
                return;
              }
              _pageController.jumpToPage(index);
            },
            isScrollable: true,
            controller: _tabController,
            unselectedLabelColor: Color(0xff666666),
            labelStyle: TextStyle(fontSize: 16.0),
            labelColor: Colors.pink,
            tabs: tabs.map((item) {
              return Tab(
                text: item.name,
              );
            }).toList(),
          ) : Text(' '),
          tabs.length > 0 ? Expanded(
            child: PageView.builder(
              itemBuilder: (BuildContext context, int index) {
                print(index);
                return InfoList(index: index);
               },
              itemCount: tabs.length,
              controller: _pageController,
              onPageChanged: _onPageChange,
            ),
          ) : Text(' ')
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => Post(tags: tabs)));
//            Navigator.of(context).pushNamed('/router/post').then((value) {});
        },
        tooltip: 'Increment',
        child: Icon(Icons.add, color: Colors.pink,),
        backgroundColor: Colors.white,
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget get _appBar {
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top,),
      color: Colors.white,
      height: 50,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          GestureDetector(
            onTap: (){
              _scaffoldKey.currentState.openDrawer();
            },
            child: Row(
              children: <Widget>[
                loadAssetImage('icons/A',height: 36, width: 36, fit: BoxFit.fill),
                Gaps.hGap8,
                Text(_name)
              ],
            )
          ),
          Text('撸羊毛', style: TextStyle(color: Colors.pink, fontSize: 20),),
          Row(
            children: <Widget>[
              Icon(Icons.location_on),
              Text(city, style: TextStyle(color: Color(0xff888888), fontSize: 15),)
            ],
          )
        ],
      ),
    );
  }

  void _logout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
    Navigator.of(context).pushReplacementNamed('login');
  }

  Widget get _swiper {
    return Container(
      child: Container(
        height: 140,
        child: Swiper(
          itemBuilder: (BuildContext context,int index){
            return Container(
              child: Text('ljl')
            );
          },
          itemCount: 3,
          pagination: SwiperPagination(),
        ),
      ),
    );
  }

  Widget get _drawer {
    return Drawer(
      child: Container(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                loadAssetImage('user/bg', width: double.infinity, height: 188),
                Container(
                  margin: EdgeInsets.only(top: 50, left: 10),
                  child: Row(
                    children: <Widget>[
                      loadAssetImage('icons/A',height: 36, width: 36, fit: BoxFit.fill),
                      Gaps.hGap8,
                      Text(_name),
                    ],
                  ),
                ),
              ],
            ),
            _drawerItems,
          ],
        ),
      )
    );
  }

  Widget get _drawerItems {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 16, left: 10, right: 10, bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(children: <Widget>[
                loadAssetImage('user/point', width: 25, height: 25),
                Gaps.hGap5,
                Text('我的积分')
              ],),
              Text('883')
            ],
          ),
        ),
        Gaps.line,Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(children: <Widget>[
                loadAssetImage('user/like', width: 25, height: 25),
                Gaps.hGap5,
                Text('偏好')
              ],),
              Wrap(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(right: 5),
                    child: Text('娱乐'),
                  ),Padding(
                    padding: EdgeInsets.only(right: 5),
                    child: Text('娱乐'),
                  ),Padding(
                    padding: EdgeInsets.only(right: 5),
                    child: Text('娱乐'),
                  ),
                ],
              )
            ],
          ),
        ),
        Gaps.line,Padding(
          padding: EdgeInsets.only(top: 16, left: 10, right: 10, bottom: 10),
          child: GestureDetector(
            onTap: _logout,
            child: Row(
              children: <Widget>[
                Row(children: <Widget>[
                  loadAssetImage('user/close', width: 25, height: 25),
                  Gaps.hGap5,
                  Text('退出登录')
                ],),
              ],
            ),
          ),
        ),
        Gaps.line,
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}