import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// SupaBase 연동 클래스
class DbConfig {
  static Future<void> initialize() async {
    try {
      // 최상위 루트에 숨겨둔 .env 파일을 메모리에 로드
      await dotenv.load(fileName: ".env");

      // 파일 내부에서 안전하게 변수 값을 꺼냄
      final String url = dotenv.get('SUPABASE_URL', fallback: '');
      final String anonKey = dotenv.get('SUPABASE_ANON_KEY', fallback: '');

      if (url.isEmpty || anonKey.isEmpty) {
        throw Exception("[Error] 올바른 DB 설정 값 없음");
      }

      // 초기화 수행
      await Supabase.initialize(url: url, publishableKey: anonKey);
    } catch (e) {
      ("DB 설정 초기화 중 보안/네트워크 에러 발생: $e");
    }
  }
}
