import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_frontend_ys/core/constants/db_config.dart';

class MenuApiService {
  Future<List<dynamic>> fetchMenus() async {
    // db_config.dart에 채워진 NestJS 백엔드 주소를 동적으로 가져옴
    final response = await http.get(Uri.parse('${DbConfig.backendUrl}/menus'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as List<dynamic>;
    } else {
      throw Exception('서버로부터 메뉴 데이터를 가져오지 못했습니다.');
    }
  }
}