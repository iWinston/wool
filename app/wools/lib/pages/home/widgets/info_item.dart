import 'package:flutter/material.dart';
import 'package:wools/resource/gaps.dart';
import 'package:wools/widgets/images_widget.dart';

class InfoItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              loadAssetImage('icons/A',height: 36, width: 36, fit: BoxFit.fill),
              Gaps.hGap8,
              Text('Michael'),
            ],
          ),
          Gaps.vGap10,
          Text('家乐福五折优惠走起啦！！！！！'),
          Gaps.vGap10,
          loadNetworkImage('https://dimg04.c-ctrip.com/images/10030v000000k4kfb4E3C_R_220_160.jpg', width: double.infinity, height: 120),
          Gaps.vGap10,
          Row(
            children: <Widget>[
              Text('广东深圳'),
              Gaps.hGap8,
              Text('2019-12-12'),
            ],
          ),
          Gaps.line,
        ],
      ),
    );
  }
}

