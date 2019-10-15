import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:wools/utils/utils.dart';

// 加载本地资源图片
Widget loadAssetImage(String name, {double width, double height, BoxFit fit}){
  return Image.asset(
    Utils.getImgPath(name),
    height: height,
    width: width,
    fit: BoxFit.fill,
  );
}

// 返回圆形图片
Widget getAvatar(String url, double length) {
  return ClipOval(
    child: Image.network(url, width: length, height: length,fit: BoxFit.fill,),
  );
}

// 返回圆角图片
Widget getRecCircleImg(String url, double width, double height, double radius) {
  return Container(
    width: width,
    height: width,
    decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(radius),
        image: DecorationImage(
            image: NetworkImage(url),
            fit: BoxFit.fill
        )
    ),
  );
}

// 加载网络图片
Widget loadNetworkImage(String imageUrl, {String placeholder : "none", double width, double height, BoxFit fit: BoxFit.cover}){
  return CachedNetworkImage(
    imageUrl: imageUrl == null ? "" : imageUrl,
    placeholder: (context, url) => loadAssetImage(placeholder, height: height, width: width, fit: fit),
    errorWidget: (context, url, error) => loadAssetImage(placeholder, height: height, width: width, fit: fit),
    width: width,
    height: height,
    fit: fit,
  );
}