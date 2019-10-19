import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wools/model/home_model.dart';
import 'package:wools/model/tags_model.dart';

const URL = 'http://wool.junmapp.com/api/tag';

class TagsDao {
  static Future<TagsModel> fetch () async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    final response = await http.get(URL, headers: {'Authorization': token},);
    print(response.statusCode);
    if (response.statusCode == 200) {
      //  解决中文乱码问题
      Utf8Decoder utf8decoder = Utf8Decoder();
      var result = json.decode(utf8decoder.convert(response.bodyBytes));
      return TagsModel.fromJson(result);
    } else {
      throw Exception('请求失败');
    }
  }
}