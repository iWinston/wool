import 'dart:io';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wools/net/http.dart';
import 'package:wools/resource/gaps.dart';
import 'package:wools/utils/toast.dart';
import 'package:wools/widgets/images_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wools/resource/colors.dart';
import 'package:wools/model/login_model.dart';
//import 'package:wools/utils/toast.dart';
import 'package:wools/widgets/input_widget.dart';
//import 'package:oktoast/oktoast.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _codeController = TextEditingController();
  final FocusNode _nodeText1 = FocusNode();
  final FocusNode _nodeText2 = FocusNode();
  bool _isClick = false;
  String phone = '';
  String code = '';

  @override
  void initState() {
    super.initState();
    //监听输入改变
    _phoneController.addListener(_verify);
    _codeController.addListener(_verify);
  }

  void _verify(){
    String phone = _phoneController.text;
    String code = _codeController.text;
    bool isClick = true;
    if (phone.isEmpty || phone.length < 11) {
      isClick = false;
    }
    if (code.isEmpty || code.length < 6) {
      isClick = false;
    }

    /// 状态不一样在刷新，避免重复不必要的setState
    if (isClick != _isClick){
      setState(() {
        _isClick = isClick;
      });
    }
  }

  void _handleLogin() async {
    Map params = Map();
    params['phone'] = _phoneController.text;
    params['code'] = _codeController.text;
    print(params);
    var dio = $http();
    Response response = await dio.post('auth', data: params);
    if (response.data['status'] == 'succ') {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('token', response.data['data']['token']);
      prefs.setString('name', response.data['data']['name']);
      prefs.setString('avatorPath', response.data['data']['avatorPath']);
      prefs.setInt('id', response.data['data']['id']);
      prefs.setInt('point', response.data['data']['point']);
      Navigator.of(context).pushReplacementNamed('tags');
    } else {
      Toast.show('登录失败');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Column(
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 28),
                margin: EdgeInsets.only(top: 80),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 40),
                        child: Column(
                          children: <Widget>[
                            Text('手机号快捷登录', style: TextStyle(color: Color(0xff333333), fontSize: 22, fontWeight: FontWeight.bold),),
                            Gaps.vGap16,
                            InputWidget(
                              focusNode: _nodeText1,
                              controller: _phoneController,
                              maxLength: 11,
                              keyboardType: TextInputType.phone,
                              hintText: "请输入手机号",
                            ),
                            InputWidget(
                              focusNode: _nodeText2,
                              controller: _codeController,
                              maxLength: 6,
                              keyboardType: TextInputType.number,
                              hintText: "请输入验证码",
                              getVCode: (){
//                        Toast.show('获取验证码');
                              },
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 68),
                              child: FlatButton(
                                onPressed: _handleLogin,
                                child: Container(
                                  height: 48,
                                  width: double.infinity,
                                  alignment: Alignment.center,
                                  child: Text('快速登录/注册', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                                ),
                                textColor: Colors.white,
                                color: AppColors.main,
                                disabledTextColor: AppColors.login_text_disabled,
                                disabledColor: AppColors.login_button_disabled,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26.0)),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('登录即同意'),
                Text('《羊毛用户协议》', style: TextStyle(color: AppColors.main)),
                Text('和'),
                Text('《用户隐私协议》', style: TextStyle(color: AppColors.main),),
              ],
            )
          ),
        ],
      )
    );
  }
}