import 'package:dio/dio.dart';

BaseOptions options = new BaseOptions(
  baseUrl: "https://5da803af23fa740014697b96.mockapi.io/api/",
  connectTimeout: 5000,
  receiveTimeout: 3000,
);
Dio dio = new Dio(options);