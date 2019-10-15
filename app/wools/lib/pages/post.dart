import 'package:flutter/material.dart';

class Post extends StatefulWidget {
  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          _appBar,
        ],
      ),
    );
  }


  Widget get _appBar {
    return Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top,),
      color: Colors.white,
      height: 50,
      child: Row(
        children: <Widget>[
          FlatButton(
            child: Text('取消'),
            onPressed: (){},
          ),
          Container(
            child: FlatButton(
                onPressed: (){},
                child: Text('发布'),
            ),
          )
        ],
      ),
    );
  }


}
