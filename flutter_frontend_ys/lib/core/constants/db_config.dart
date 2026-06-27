import 'package:flutter_dotenv/flutter_dotenv.dart';

class DbConfig {
  static String backendUrl = '';
  static Future<void> initialize() async {
    try {
      // 최상위 루트에 숨겨둔 .env 파일을 메모리에 로드
      await dotenv.load(fileName: ".env");

      // 백엔드 서버 주소를 읽어옴
      backendUrl = dotenv.get('PROJECT_URL', fallback: 'http://localhost:3000');
    } catch (e) {
      ("로드 실패, 기본 로컬 백엔드 주소로 구동합니다: $e");
    }
  }
}