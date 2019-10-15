import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:wools/resource/colors.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:rxdart/rxdart.dart';

// 封装输入框组件，可配置是否显示密码，是否显示清除按钮
class InputWidget extends StatefulWidget {
  final TextEditingController controller;
  final int maxLength;
  final bool autoFocus;
  final bool showBorderBottom;
  final TextInputType keyboardType;
  final String hintText;
  final FocusNode focusNode;
  final TextStyle hintTextStyle;
  final TextStyle inputTextStyle;
  final bool isInputPwd;
  final Function getVCode;
  final KeyboardActionsConfig config;

  const InputWidget({
    Key key,
    @required this.controller,
    this.maxLength: 16,
    this.autoFocus: false,
    this.keyboardType: TextInputType.text,
    this.hintText: "",
    this.focusNode,
    this.isInputPwd: false,
    this.getVCode,
    this.config,
    this.hintTextStyle,
    this.inputTextStyle,
    this.showBorderBottom: false
  }): super(key: key);
  @override
  _InputWidgetState createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  final int second = 60;
  int time;
  bool _isShowDelete;
  bool _isClick = true;
  bool _isShowPwd = false;
  StreamSubscription _subscription;

  @override
  void initState() {
    super.initState();
    /// 获取初始化值
    _isShowDelete = widget.controller.text.isEmpty;
    /// 监听输入改变
    widget.controller.addListener((){
      setState(() {
        _isShowDelete = widget.controller.text.isEmpty;
      });
    });
    if (widget.config != null && defaultTargetPlatform == TargetPlatform.iOS){
      // 因Android平台输入法兼容问题，所以只配置IOS平台
      FormKeyboardActions.setKeyboardActions(context, widget.config);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _subscription?.cancel();
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerRight,
      children: <Widget>[
        TextField(
          focusNode: widget.focusNode,
          maxLength: widget.maxLength,
          style: widget.inputTextStyle??TextStyle(),
          obscureText: widget.isInputPwd ? !_isShowPwd : false,
          autofocus: widget.autoFocus,
          controller: widget.controller,
          textInputAction: TextInputAction.done,
          keyboardType: widget.keyboardType,
          // 数字、手机号限制格式为0到9(白名单)， 密码限制不包含汉字（黑名单）
          inputFormatters: (widget.keyboardType == TextInputType.number || widget.keyboardType == TextInputType.phone) ?
          [WhitelistingTextInputFormatter(RegExp("[0-9]"))] : [BlacklistingTextInputFormatter(RegExp("[\u4e00-\u9fa5]"))],
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 16.0),
            hintText: widget.hintText,
            hintStyle: widget.hintTextStyle??TextStyle(),
            counterText: "",
            focusedBorder: widget.showBorderBottom ? UnderlineInputBorder(
                borderSide: BorderSide(
                    color: AppColors.main,
                    width: 0.8
                )
            ): UnderlineInputBorder(
                borderSide: BorderSide(width: 0.0)
            ),
            enabledBorder: widget.showBorderBottom ? UnderlineInputBorder(
                borderSide: BorderSide(
                    color: AppColors.line,
                    width: 0.8
                )
            ):  UnderlineInputBorder(
                borderSide: BorderSide(width: 0.0)
            ),
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _deleteIcon(),
            _showPwd(),
            _codeBtn(),
          ],
        )
      ],
    );
  }

  _deleteIcon() {
    // 清除内容图标
    return Offstage(
      offstage: _isShowDelete,
      child: GestureDetector(
        child: Image.asset("assets/images/login/icon_delete.png",
          width: 18.0,
          height: 18.0,
        ),
        onTap: (){
          setState(() {
            widget.controller.text = "";
          });
        },
      ),
    );
  }

  _showPwd() {
    // 查看明文密码图标
    return Offstage(
      offstage: !widget.isInputPwd,
      child: Padding(
        padding: const EdgeInsets.only(left: 15.0),
        child: GestureDetector(
          child: Image.asset(
            _isShowPwd ? "assets/images/login/icon_display.png" : "assets/images/login/icon_hide.png",
            width: 18.0,
            height: 18.0,
          ),
          onTap: (){
            setState(() {
              _isShowPwd = !_isShowPwd;
            });
          },
        ),
      ),
    );
  }

  _codeBtn() {
    // 发送验证码按钮
    return Offstage(
      offstage: widget.getVCode == null,
      child: Padding(
        padding: const EdgeInsets.only(left: 15.0),
        child: Container(
          height: 38.0,
          width: 112.0,
          child: Container(
            height: 36,
            child: FlatButton(
                onPressed: _isClick ? (){
                  widget.getVCode();
                  setState(() {
                    time = second;
                    _isClick = false;
                  });
                  _subscription = Observable.periodic(Duration(seconds: 1), (i) => i).take(second).listen((i){
                    setState(() {
                      time = second - i - 1;
                      _isClick = time < 1;
                    });
                  });
                }: null,
                textColor: Colors.white,
                color: AppColors.main,
                disabledTextColor: Colors.white,
                disabledColor: AppColors.text_gray_light,
                shape:RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(26.0),
                ),
                child: Text(
                  _isClick ? "获取验证码" : "$time s",
                  style: TextStyle(fontSize: 12),
                )
            ),
          ),
        ),
      ),
    );
  }
}
