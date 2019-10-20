import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:wools/model/news_model.dart';
import 'package:wools/net/http.dart';
import 'package:wools/resource/gaps.dart';
import 'package:wools/utils/toast.dart';
import 'package:wools/widgets/images_widget.dart';

class InfoItem extends StatefulWidget {
  final NewsItem newItem;
  final int userId;
  final Function refreshData;

  const InfoItem({
    Key key,
    @required this.newItem,
    @required this.userId,
    @required this.refreshData,
  }) : super(key: key);

  @override
  _InfoItemState createState() => _InfoItemState();
}

class _InfoItemState extends State<InfoItem> {
  _isShowDelete() {
    return widget.userId == widget.newItem.userId;
  }

  _handleDelete() async {
    Dio dio = $http();
    Response res = await dio.delete('news/${widget.newItem.id}');
    if (res.data['status'] == 'succ') {
      Toast.show('删除成功');
      widget.refreshData();
    } else {
      Toast.show('删除失败～');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Image.network(widget.newItem.user.avatorPath??'',height: 36, width: 36, fit: BoxFit.fill),
              Gaps.hGap8,
              Text(widget.newItem.user.name??'', style: TextStyle(color: Color(0xff888888)),),
            ],
          ),
          Gaps.vGap10,
          Text(widget.newItem.content??'', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
          Gaps.vGap10,
          loadNetworkImage(widget.newItem.photoPath, width: double.infinity, height: 200),
          Gaps.vGap10,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(widget.newItem.location??'', style: TextStyle(color: Color(0xff999999))),
                  Gaps.hGap8,
                  Text(DateTime.parse(widget.newItem.createdAt).toIso8601String(), style: TextStyle(color: Color(0xff999999))),
                ],
              ),
              _isShowDelete() ?
              GestureDetector(
                child: Icon(Icons.delete, color: Colors.deepOrange, size: 28,),
                onTap: _handleDelete,
              ): Text('')
            ],
          ),
          Gaps.vGap10,
          Gaps.line,
        ],
      ),
    );
  }
}

