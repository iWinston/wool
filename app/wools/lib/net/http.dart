import 'package:dio/dio.dart';

BaseOptions options = new BaseOptions(
  baseUrl: "https://www.easy-mock.com/mock/5d3e593fe1a16a2139dc7745/xmg/api/",
  connectTimeout: 5000,
  receiveTimeout: 3000,
);
Dio dio = new Dio(options);