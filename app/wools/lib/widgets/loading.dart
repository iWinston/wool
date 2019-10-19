import 'package:flutter/material.dart';


void $loading(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      // 用Scaffold返回显示的内容，能跟随主题
      return Scaffold(
        backgroundColor: Colors.transparent, // 设置透明背影
        body: Center( // 居中显示
          child: Card(
            color: Colors.transparent,
            child: Text('fd'),
          ), // 自带loading效果，需要宽高设置可在外加一层sizedbox，设置宽高即可
        ),
      );
    },
  );
}