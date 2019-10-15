import 'dart:io';
import 'package:wools/widgets/images_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wools/resource/colors.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 28),
          margin: EdgeInsets.only(top: 80),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 40),
                child: Column(
                  children: <Widget>[
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
                        onPressed: () {},
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
              )
            ],
          ),
        ),
      ),
    );
  }
}