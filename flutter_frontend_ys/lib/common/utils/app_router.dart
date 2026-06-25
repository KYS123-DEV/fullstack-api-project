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
    'base_menu_reg': () => const Center(child: Text('[기준정보 > 메뉴등록] 화면')),
    'customer_reg': () => const Center(child: Text('[고객사정보 > 고객사등록] 화면')),
    'purchase_delivery_check': () =>
        const Center(child: Text('[구매관리 > 납품등록확인] 화면')),
    'purchase_delivery_status': () =>
        const Center(child: Text('[구매관리 > 납품등록현황] 화면')),
    'purchase_unpaid_status': () =>
        const Center(child: Text('[구매관리 > 미납품현황] 화면')),
    'statement_print': () => const Center(child: Text('거래명세표출력 화면')),
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

    // 맨 앞 슬래시 제거
    // 중간 슬래시를 언더바로 치환
    // 하이픈을 언더바로 치환
    final String menuKey = path
        .replaceFirst('/', '')
        .replaceAll('/', '_')
        .replaceAll('-', '_');

    // 등록된 명부에 키가 존재하면 해당 화면 위젯을 즉시 생성해서 반환
    if (_allRoutes.containsKey(menuKey)) {
      return _allRoutes[menuKey]!();
    }

    // 명부에 없는 엉뚱한 주소 요청이 들어오면 에러 화면으로 방어
    return _allRoutes['not-found']!();
  }
}
