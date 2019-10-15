import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:wools/pages/tags.dart';
import 'package:wools/widgets/images_widget.dart';
import 'package:wools/widgets/info_card.dart';
import 'package:wools/model/card_info.dart';

class Home extends StatefulWidget {
  Home({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String city = '深圳';
  String img = 'https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=1676338337,14804516&fm=26&gp=0.jpg';
  var data = {
    'nickname': 'https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=2677432097,397548121&fm=26&gp=0.jpg',
    'address': '广东深圳',
    'content': '家乐福五折优惠啦',
    'likes': 19,
    'pic': 'https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=2080995666,4129260583&fm=26&gp=0.jpg'
  };
//  CardInfoModel info = CardInfoModel.fromJson(data);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          _appBar,
          _swiper,
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => Tags()));
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
          loadAssetImage('icons/A',height: 36, width: 36, fit: BoxFit.fill),
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
              child: loadNetworkImage(img, width: double.infinity, height: 100)
            );
          },
          itemCount: 3,
          pagination: SwiperPagination(),
        ),
      ),
    );
  }
}