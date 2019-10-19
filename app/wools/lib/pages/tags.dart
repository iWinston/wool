import 'package:flutter/material.dart';

class Tags extends StatefulWidget {
  @override
  _TagsState createState() => _TagsState();
}

class _TagsState extends State<Tags> {
  var _tabs = ['美食','娱乐','购物','线上优惠', '官方'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(''),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: <Widget>[
            Center(
              child: Text('请选择三个您喜欢的标签', style: TextStyle(fontSize: 22, color: Color(0xff333333), fontWeight: FontWeight.bold),),
            ),
            Padding(padding: EdgeInsets.only(top: 48),),
            Wrap(
              spacing: 6, //主轴上子控件的间距
              runSpacing: 20, //交叉轴上子控件之间的间距
              children: _tabs.map((tab) {
                return _tab(tab);
              }).toList(),
            ),
            FlatButton(
                child: Text('定'),
                color: Colors.blue,
                textColor: Colors.white,
                disabledColor: Colors.grey,
                disabledTextColor: Colors.black,
                padding: EdgeInsets.all(8.0),
                splashColor: Colors.blueAccent,
                shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0))
            ),
          ],
        ),
      ),
    );
  }

  Widget _tab(String tab) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: Color(0xcc9d9d9d0)),
        color: Colors.pink,
      ),
      child: Text(tab, style: TextStyle(color: Colors.white, fontSize: 15),),
    );
  }
}
