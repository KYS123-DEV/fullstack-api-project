import 'package:flutter/material.dart';
import 'package:flutter_frontend_ys/common/utils/menu_model.dart';

class MenuService {
  MenuService._internal();
  static final MenuService _instance = MenuService._internal();
  factory MenuService() => _instance;

  // 전역 메뉴 데이터 변수들
  final ValueNotifier<List<Map<String, String>>> categoryMenus = ValueNotifier(
    [],
  );
  final ValueNotifier<List<MenuModel>> sidebarMenus = ValueNotifier([]);

  // 현재 선택된 'MenuModel 데이터 객체 자체'를 전역 상태로 관리
  final ValueNotifier<MenuModel?> currentMenu = ValueNotifier(null);

  // 화면 변경 메소드
  void changeMenu(MenuModel menu) {
    currentMenu.value = menu;
  }

  // DB(API 서버)에서 데이터를 조회해오는 가상 함수
  Future<void> fetchMenusFromDB() async {
    await Future.delayed(const Duration(milliseconds: 500));

    // AppBar 상단 카테고리 데이터 세팅
    categoryMenus.value = [
      {'id': 'c1', 'title': '개인정보수정'},
      {'id': 'c2', 'title': '임시메뉴'},
      {'id': 'c3', 'title': '시스템 설정'},
    ];

    // Sidebar 메뉴 데이터 세팅
    sidebarMenus.value = [
      MenuModel.fromMock(
        id: 'home',
        title: 'Home',
        icon: 'home',
        path: '/',
        screenBuilder: (context) =>
            const Center(child: Text('Main Home 화면 콘텐츠 영역')),
      ),
      MenuModel.fromMock(
        id: 'm1',
        title: '기준정보',
        icon: 'folder',
        children: [
          MenuModel.fromMock(
            id: 'm1-1',
            title: 'OO등록',
            path: '/menu1-1',
            screenBuilder: (context) => const Center(child: Text('기준정보 화면 영역')),
          ),
        ],
      ),
      MenuModel.fromMock(
        id: 'm2',
        title: 'OO관리',
        icon: 'folder',
        children: [
          MenuModel.fromMock(
            id: 'm2-1',
            title: 'OO확인',
            path: '/menu2-1',
            screenBuilder: (context) =>
                const Center(child: Text('실제 화면 영역 2-1')),
          ),
          MenuModel.fromMock(
            id: 'm2-2',
            title: 'OO등록 1',
            path: '/menu2-2',
            screenBuilder: (context) =>
                const Center(child: Text('실제 화면 영역 2-2')),
          ),
          MenuModel.fromMock(
            id: 'm2-3',
            title: 'OO현황 2',
            path: '/menu2-3',
            screenBuilder: (context) =>
                const Center(child: Text('실제 화면 영역 2-3')),
          ),
        ],
      ),
      MenuModel.fromMock(
        id: 'm3',
        title: 'OOOO출력',
        icon: 'dashboard',
        path: '/menu3',
        screenBuilder: (context) => const Center(child: Text('OOOO출력 화면 영역')),
      ),
    ];

    // 초기 실행 시 첫 번째 메뉴(Home)가 자동으로 활성화되도록 기본값 주입
    if (sidebarMenus.value.isNotEmpty) {
      currentMenu.value = sidebarMenus.value.first;
    }
  }
}
