import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wools/model/tags_model.dart';
import 'package:wools/net/http.dart';
import 'package:wools/resource/gaps.dart';
import 'package:wools/utils/event_bus.dart';
import 'package:wools/utils/toast.dart';
import 'package:wools/widgets/select_image.dart';

class Post extends StatefulWidget {

  final List<TagItem> tags;
  const Post({
    Key key,
    @required this.tags,
  }) : super(key: key);

  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> {

  final TextEditingController _textController = new TextEditingController();
  String locationText = '广东深圳';
  File _imageFile;
  String _goodsSortName;
  String _uploadImgUrl = '';
  Dio dio;
  List<TagItem> _tabs = [];
  String _currTab = '';
  int _currTagId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabs = widget.tags;
    dio = $http();
  }

  void _getImage() async{
    try {
      _imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
      String path = _imageFile.path;
      _uploadImg(path);
      setState(() {});
    } catch (e) {
      Toast.show("没有权限，无法打开相册！");
    }
  }

  void _uploadImg(String path) async {
    _onLoading();
    FormData formData = FormData.from({
      "file": UploadFileInfo(
          File(path), "1.jpg"),
    });
    Response response = await dio.post("news/upload", data: formData);
    if(response.data['status'] == 'succ') {
      setState(() {
        _uploadImgUrl = response.data['data'];
      });
      Toast.show('图片上传成功');
    } else {
      Toast.show('图片上传失败，请重试～');
    }
    Navigator.pop(context);
  }

  void _handleSubmit() async {
    _onLoading();
    Map<String, dynamic> params = Map();
    params['content'] = _textController.text;
    params['location'] = '深圳市南山区';
    params['tagIds'] = [_currTagId];
    params['photoPath'] = _uploadImgUrl;
    Response response = await dio.post('news', data: params);
    Navigator.pop(context);
    if (response.data['status'] == 'succ') {
      _notifyUpdate();
      Toast.show('提交成功');
      Future.delayed(Duration(seconds: 1), () {
        Navigator.pop(context); //pop dialog
      });
    }
  }

  _notifyUpdate() {
    eventBus.fire(pointEvent(2));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _appBar,
            _textArea,
            _selectImage,
            Gaps.vGap16,
            _location,
            Container(
              child: Wrap(
                children: _tabs.map((tab) {
                  return _tab(tab);
                }).toList()
              ),
            )
          ],
        ),
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
              onPressed: _handleSubmit,
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
      autofocus: false,//自动获取焦点
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

  Widget get _selectImage {
    return  Center(
      child: SelectedImage(
          image: _imageFile,
          onTap: _getImage,
      ),
    );
  }

  Widget _tab(TagItem tab) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _currTab = tab.name;
          _currTagId = tab.id;
        });
      },
      child: SizedBox(
        width: 80,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12),
          margin: EdgeInsets.only(right: 20,bottom: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            border: _currTab == tab.name ? Border.all(color: Colors.white) : Border.all(color: Color(0xcc9d9d9d0)),
            color: _currTab == tab.name ? Colors.pink : Colors.white,
          ),
          child: Text(tab.name,textAlign: TextAlign.center, style: TextStyle(color: _currTab == tab.name ? Colors.white : Color(0xff666666), fontSize: 15),),
        ),
      ),
    );
  }

  void _onLoading() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: SizedBox(
            width: 100,
            height: 160,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircularProgressIndicator(),
                Gaps.vGap5,
                Text("加载中"),
              ],
            ),
          ),
        );
      },
    );
  }
}