import 'package:fluttertripstudy/model/home_model.dart';
import 'package:fluttertripstudy/model/search_model.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

///搜索大接口
class SearchDao {
  static Future<SearchModel> fetch(String url, String text) async {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      Utf8Decoder utf8decoder = Utf8Decoder(); //修复中文乱码
      var result = json.decode(utf8decoder.convert(response.bodyBytes));
      //只有当当前输入的内容和服务器端返回的内容一致时才渲染
      SearchModel model = SearchModel.fromJson(result);
      model.keyword = text;
      return model;
      //return SearchModel.fromJson(result);
    } else {
      throw Exception('Failed to load home_page.json');
    }
  }
}
