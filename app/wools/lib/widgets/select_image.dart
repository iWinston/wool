
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:wools/utils/image_utils.dart';

class SelectedImage extends StatelessWidget {

  const SelectedImage({
    Key key,
    this.width : 277.0,
    this.height : 187.0,
    this.radius : 8.0,
    this.onTap,
    this.image
  }): super(key: key);

  final double width;
  final double height;
  final double radius;
  final GestureTapCallback onTap;
  final File image;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16.0),
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          // 图片圆角展示
          borderRadius: BorderRadius.circular(radius),
          image: DecorationImage(
              image: image == null ? AssetImage("assets/images/icons/add.png") : FileImage(image),
              fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}