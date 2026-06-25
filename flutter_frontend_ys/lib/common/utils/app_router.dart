import 'package:flutter/material.dart';
import 'package:flutter_frontend_ys/domains/auth/screens/login_page.dart';

// 요청 등록지
class AppRouter {
  // 공통 + 인증 관련 시스템 화면
  static final Map<String, Widget Function()> _systemRoutes = {
    'home_page': () => const Center(child: Text('Main Home 콘텐츠 영역')),
    'login_page': () => const LoginPage(),
    'not-found': () => const Center(child: Text('404: 페이지를 찾을 수 없습니다.')),
  };

  //사이드바 메뉴
  static final Map<String, Widget Function()> _menuRoutes = {
    'home': () => const Center(child: Text('Main Home 화면 콘텐츠 영역')),
    'menu1-1': () => const Center(child: Text('화면 영역 (menu1-1)')),
    'menu1-2': () => const Center(child: Text('화면 영역 (menu1-2)')),
    'menu1-3': () => const Center(child: Text('화면 영역 (menu1-3)')),
    'menu2-1': () => const Center(child: Text('화면 영역 (menu2-1)')),
    'menu3': () => const Center(child: Text('OOOO출력 화면 영역')),
    'menu5-1': () => const Center(child: Text('화면 영역 (menu5-1)')),
  };

  //Routes 통합
  static final Map<String, Widget Function()> _allRoutes = {
    ..._systemRoutes,
    ..._menuRoutes,
    // 나중에 매출관리, 인사관리 등 도메인이 추가되면 여기다가 ..._salesRoutes 툭 추가하면 끝
  };

  // 그저 호출만 하면 공통 규칙에 따라 화면이 튀어나오는 메소드
  static Widget getScreen(String? path) {
    if (path == null || path == '/') {
      return _allRoutes['home']!();
    }

    // 입력된 path가 '/menu1-1' 이라면 앞의 슬래시('/')를 떼어내고 'menu1-1' 키값만 추출.
    final String menuKey = path.replaceFirst('/', '');

    // 등록된 명부에 키가 존재하면 해당 화면 위젯을 즉시 생성해서 반환
    if (_allRoutes.containsKey(menuKey)) {
      return _allRoutes[menuKey]!();
    }

    // 명부에 없는 엉뚱한 주소 요청이 들어오면 에러 화면으로 방어
    return _allRoutes['not-found']!();
  }
}
