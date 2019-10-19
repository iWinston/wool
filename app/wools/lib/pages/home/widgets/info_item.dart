import 'package:flutter/material.dart';
import 'package:wools/model/news_model.dart';
import 'package:wools/resource/gaps.dart';
import 'package:wools/widgets/images_widget.dart';

class InfoItem extends StatelessWidget {
  final NewsItem newItem;

  const InfoItem({
    Key key,
    @required this.newItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              loadAssetImage('icons/A',height: 36, width: 36, fit: BoxFit.fill),
              Gaps.hGap8,
              Text(newItem.user.name??'', style: TextStyle(color: Color(0xff888888)),),
            ],
          ),
          Gaps.vGap10,
          Text(newItem.content??''),
          Gaps.vGap10,
          loadNetworkImage(newItem.photoPath, width: double.infinity, height: 150),
          Gaps.vGap10,
          Row(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(newItem.location??'', style: TextStyle(color: Color(0xff999999))),
                  Gaps.hGap8,
                  Text('2019-12-12', style: TextStyle(color: Color(0xff999999))),
                ],
              ),
              GestureDetector(
                child: Icon(Icons.delete)
              )
            ],
          ),
          Gaps.vGap10,
          Gaps.line,
        ],
      ),
    );
  }
}

