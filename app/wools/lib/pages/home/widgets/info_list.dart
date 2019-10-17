import 'package:flutter/material.dart';
import 'package:wools/utils/toast.dart';
import 'package:wools/widgets/my_refresh_list.dart';
import 'package:wools/widgets/state_layout.dart';
import 'package:wools/widgets/state_layout.dart';
import 'info_item.dart';

class InfoList extends StatefulWidget {

  const InfoList({
    Key key,
    @required this.index
  }): super(key: key);

  final int index;

  @override
  _InfoListState createState() => _InfoListState();
}

class _InfoListState extends State<InfoList> with AutomaticKeepAliveClientMixin<InfoList>, SingleTickerProviderStateMixin {

  List _list = [];

  @override
  void initState() {
    super.initState();

    //Item数量
    _maxPage = widget.index == 0 ? 1 : (widget.index == 1 ? 2 : 3);

    _onRefresh();
  }

  List<String> _imgList = [
    "https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=3130502839,1206722360&fm=26&gp=0.jpg",
    "https://xxx", // 故意使用一张错误链接
    "https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=1762976310,1236462418&fm=26&gp=0.jpg",
    "https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=3659255919,3211745976&fm=26&gp=0.jpg",
    "https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=2085939314,235211629&fm=26&gp=0.jpg",
    "https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=2441563887,1184810091&fm=26&gp=0.jpg"
  ];

  Future _onRefresh() async {
    await Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _page = 1;
        _list = List.generate(widget.index == 0 ? 3 : 10, (i) => 'newItem：$i');
      });
    });
  }

  Future _loadMore() async {
    await Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _list.addAll(List.generate(10, (i) => 'newItem：$i'));
        _page ++;
      });
    });
  }

  int _page = 1;
  int _maxPage;
  StateType _stateType = StateType.loading;

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
          return InfoItem();
        }
    );
  }

  @override
  bool get wantKeepAlive => true;

}