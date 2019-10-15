import 'package:flutter/material.dart';
import 'package:wools/model/card_info.dart';
import 'images_widget.dart';

class InfoCard extends StatelessWidget {
  final CardInfoModel data;

  const InfoCard({
    Key key,
    @required this.data,
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            loadNetworkImage(data.avatar,height: 36, width: 36, fit: BoxFit.fill),
            Text(data.nickname)
          ],
        ),
        Text(data.content),
        loadNetworkImage(data.pic,height: 150, width: double.infinity, fit: BoxFit.fill),
        Row(
          children: <Widget>[
            Text(data.address),
            Text('2019-01-12'),
          ],
        )
      ],
    );
  }
}
