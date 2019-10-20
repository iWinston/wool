import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:wools/dao/tags_dao.dart';
import 'package:wools/model/tags_model.dart';
import 'package:wools/net/http.dart';
import 'package:wools/resource/colors.dart';
import 'package:wools/utils/toast.dart';

class TagsPage extends StatefulWidget {
  @override
  _TagsPageState createState() => _TagsPageState();
}

class _TagsPageState extends State<TagsPage> {
  List<TagItem> _tabs = [];
  List<int> _ids = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getData();
  }

  _getData() async {
    TagsModel res = await TagsDao.fetch();
    this.setState(() {
      _tabs = res.data;
    });
  }

  _handleSubmit() async {
    Dio dio = $http();
    Response response = await dio.post('user-tag', data: {'tagIds': _ids});
    if (response.data['status'] == 'succ') {
      Navigator.of(context).pushReplacementNamed('home');
    } else {
      Toast.show('提交失败～');
    }
  }

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
                return _tabItem(tab);
              }).toList(),
            ),
            GestureDetector(
              onTap: _handleSubmit,
              child: Container(
                width: 300,
                height: 50,
                margin: EdgeInsets.only(top: 100),
                decoration: BoxDecoration(
                  color: AppColors.main,
                  borderRadius: BorderRadius.circular(28)
                ),
                child: Center(child: Text('确定',style: TextStyle(color: Colors.white, fontSize: 16),)),
              ),
            )
          ],
        ),
      ),
    );
  }

  bool _isActive (int id) {
    return _ids.any((element)=>(element==id));
  }

  Widget _tabItem(TagItem tab) {
    return GestureDetector(
      onTap: (){
        bool has = _ids.any((element)=>(element==tab.id));
        if (has) {
          _ids.remove(tab.id);
          setState(() {
            _ids = _ids;
          });
        } else if (_ids.length <= 3 && !has) {
          _ids.add(tab.id);
          setState(() {
            _ids = _ids;
          });
        }
      },
      child: SizedBox(
        width: 80,
        child: Container(
          padding: EdgeInsets.symmetric( vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            border: _isActive(tab.id) ? Border.all(width: 0) : Border.all(color: Color(0xcc9d9d9d0)),
            color: _isActive(tab.id) ? Colors.pink : Colors.white,
          ),
          child: Text(tab.name, style: TextStyle(color: _isActive(tab.id) ? Colors.white : Color(0xff666666), fontSize: 15), textAlign: TextAlign.center,),
        ),
      ),
    );
  }
}
