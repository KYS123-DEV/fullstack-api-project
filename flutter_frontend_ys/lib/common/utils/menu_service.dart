import 'package:flutter/material.dart';

class MenuService {
  MenuService._internal();
  static final MenuService _instance = MenuService._internal();
  factory MenuService() => _instance;

  //전역 메뉴 데이터 변수들
  final ValueNotifier<List<Map<String, String>>> categoryMenus = ValueNotifier(
    [],
  );
  final ValueNotifier<List<Map<String, dynamic>>> sidebarMenus = ValueNotifier(
    [],
  );

  // DB(API 서버)에서 데이터를 조회해오는 가상 함수
  Future<void> fetchMenusFromDB() async {
    // 서버 대기 시뮬
    //await Future.delayed(const Duration(milliseconds: 500));

    //여기서 자료 setItem
    //appbar 메뉴
    categoryMenus.value = [
      {'id': 'c1', 'title': '개인정보수정'},
      {'id': 'c2', 'title': '임시메뉴'},
      {'id': 'c3', 'title': '시스템 설정'},
    ];

    //sidebar 메뉴
    sidebarMenus.value = [
      {'id': 'm0', 'title': 'Home', 'icon': 'home', 'children': null},
      {
        'id': 'm1',
        'title': '기준정보',
        'icon': 'folder',
        'children': [
          {'id': 'm1-1', 'title': 'OO등록', 'path': '/menu1-1'},
        ],
      },
      {
        'id': 'm2',
        'title': 'OO관리',
        'icon': 'folder',
        'children': [
          {'id': 'm2-1', 'title': 'OO확인', 'path': '/menu2-1'},
          {'id': 'm2-2', 'title': 'OO현황', 'path': '/menu2-2'},
          {'id': 'm2-3', 'title': 'OO현황', 'path': '/menu2-3'},
        ],
      },
      {
        'id': 'm3',
        'title': 'OO관리',
        'icon': 'folder',
        'children': [
          {'id': 'm3-1', 'title': 'OO등록', 'path': '/menu3-1'},
        ],
      },
      {
        'id': 'm4',
        'title': 'OOOO출력',
        'icon': 'dashboard',
        'path': '/menu4',
        'children': null,
      },
    ];
  }
}
