import 'package:flutter/material.dart';

class Post extends StatefulWidget {
  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> {

  final TextEditingController _textController = new TextEditingController();
  String locationText = '所在位置';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          _appBar,
          _textArea,
          _location,
        ],
      ),
    );
  }

  Widget get _appBar {
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top,),
      padding: EdgeInsets.symmetric(horizontal: 20),
      color: Colors.white,
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          InkWell(
            child: Text('取消'),
            onTap: (){
              Navigator.of(context).pop();
            },
          ),
          Container(
            child: FlatButton(
                color: Colors.pink,
                textColor: Colors.white,
                padding: EdgeInsets.all(8.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                onPressed: (){},
                child: Text('发布'),
            ),
          )
        ],
      ),
    );
  }

  Widget get _textArea {
    return TextField(
      maxLines: 5,
      autofocus: true,//自动获取焦点
      controller:_textController,
      decoration: new InputDecoration(
          contentPadding: new EdgeInsets.all(15.0),
          border: InputBorder.none,
          hintText: '请输入内容...'
      ),
      onChanged:(String content){
        print(content);//文本内容变化,会回调给我们
      },
    );
  }

  Widget get _location {
    return Container(
      decoration: BoxDecoration(
        border: Border(top: BorderSide(width: 1, color: Color(0xffededed))),
      ),
      margin: EdgeInsets.symmetric(horizontal: 20),
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(locationText),
          Icon(Icons.keyboard_arrow_right, color: Color(0xffcccccc), size: 28,)
        ],
      ),
    );
  }
}
