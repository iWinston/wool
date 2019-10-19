import 'package:flutter/material.dart';
import 'package:wools/dao/news_dao.dart';
import 'package:wools/model/news_model.dart';
import 'package:wools/utils/toast.dart';
import 'package:wools/widgets/my_refresh_list.dart';
import 'package:wools/widgets/state_layout.dart';
import 'package:wools/widgets/state_layout.dart';
import 'info_item.dart';

class InfoList extends StatefulWidget {
  final int index;

  const InfoList({
    Key key,
    @required this.index
  }): super(key: key);


  @override
  _InfoListState createState() => _InfoListState();
}

class _InfoListState extends State<InfoList> with AutomaticKeepAliveClientMixin<InfoList>, SingleTickerProviderStateMixin {

  List _list = [];
  int _page = 1;
  int _maxPage;
  StateType _stateType = StateType.loading;

  @override
  void initState() {
    super.initState();

    //Item数量
    _maxPage = widget.index == 0 ? 1 : (widget.index == 1 ? 2 : 3);

    _onRefresh();
  }

  Future _onRefresh() async {
    NewsModel res = await NewsDao.fetch(widget.index, _page);
    print(res.data);
    setState(() {
      _page = 1;
      _list = res.data;
    });

//    await Future.delayed(Duration(seconds: 2), () {
//      setState(() {
//        _page = 1;
//        _list = List.generate(widget.index == 0 ? 3 : 10, (i) => 'newItem：$i');
//      });
//    });
  }

  Future _loadMore() async {
    await Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _list.addAll(List.generate(10, (i) => 'newItem：$i'));
        _page ++;
      });
    });
  }



  @override
  Widget build(BuildContext context) {
    super.build(context);
    return DeerListView(
        itemCount: _list.length,
        stateType: _stateType,
        onRefresh: _onRefresh,
        loadMore: _loadMore,
        hasMore: _page < _maxPage,
        itemBuilder: (_, index){
          print('三分$index');
          return InfoItem(newItem: _list[index]);
        }
    );
  }

  @override
  bool get wantKeepAlive => true;

}