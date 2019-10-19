import 'package:flutter/material.dart';

Widget loadingWidget = Stack(
  children: [
    new Opacity(
      opacity: 0.3,
      child: const ModalBarrier(dismissible: false, color: Colors.black),
    ),
    new Center(
        child: new Container(
          width: 200.0,
          height: 140.0,
          decoration: new BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.white,
                offset: Offset(1.0, 3.0),
                blurRadius: 10.0,
              ),
            ],
          ),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new CircularProgressIndicator(),
              new Container(margin: EdgeInsets.only(top: 10.0)),
              new Text('加载中...')
            ],
          ),
        )
    ),
  ],
);
