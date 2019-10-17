import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:jpush_flutter/jpush_flutter.dart';
import 'package:wools/pages/home/provider/provider.dart';
import 'package:wools/pages/home/widgets/info_list.dart';
import 'package:wools/pages/location_view.dart';
import 'package:wools/pages/packet_rain/packet_rain.dart';
import 'package:wools/pages/post.dart';
import 'package:wools/pages/tags.dart';
import 'package:wools/widgets/images_widget.dart';
import 'package:wools/pages/home/widgets/info_card.dart';
import 'package:wools/model/card_info.dart';
import 'package:flutter/services.dart';
import 'package:wools/net/http.dart';

class Home extends StatefulWidget {
  Home({Key key, this.title}) : super(key: key);

  final String title;

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

  @override
  void initState() {
    super.initState();
    initPlatformState();
    initTabData();
    _tabController = new TabController(vsync: this, length: tabList.length);
    getData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void getData() async  {
    var data = await dio.get('home');
    print(data);
  }

  void initTabData() {
    tabList = [
      new TabTitle('推荐', 10),
      new TabTitle('热点', 0),
      new TabTitle('社会', 1),
      new TabTitle('娱乐', 2),
      new TabTitle('体育', 3),
      new TabTitle('美文', 4),
      new TabTitle('科技', 5),
      new TabTitle('财经', 6),
      new TabTitle('时尚', 7)
    ];
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
      appKey: "cf08090bdec87ed1528d8ac9",
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
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => Tags()));
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

  String city = '深圳';
  String img = 'https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=1676338337,14804516&fm=26&gp=0.jpg';
//  CardInfoModel info = CardInfoModel.fromJson(data);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      drawer: _drawer,
      body: Column(
        children: <Widget>[
          _appBar,
          TabBar(
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
            tabs: tabList.map((item) {
              return Tab(
                text: item.title,
              );
            }).toList(),
          ),
          Expanded(
            child: PageView.builder(
              itemBuilder: (BuildContext context, int index) {
                return InfoList();
               },
              itemCount: tabList.length,
              controller: _pageController,
              onPageChanged: _onPageChange,
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => PacketRain()));
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
            child: loadAssetImage('icons/A',height: 36, width: 36, fit: BoxFit.fill),
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

  Widget get _swiper {
    return Container(
      child: Container(
        height: 140,
        child: Swiper(
          itemBuilder: (BuildContext context,int index){
            return Container(
              child: Text('ljlfd')
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
            loadAssetImage('user/bg', width: double.infinity, height: 130)
          ],
        ),
      )
    );
  }

  @override
  bool get wantKeepAlive => true;
}