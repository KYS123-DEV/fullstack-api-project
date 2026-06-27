import 'package:flutter/material.dart';
import 'package:flutter_frontend_ys/common/utils/menu_model.dart';
import 'package:flutter_frontend_ys/common/utils/app_router.dart';
import 'package:flutter_frontend_ys/domains/system/services/menu_api_service.dart';

class MenuService {
  MenuService._internal();
  static final MenuService _instance = MenuService._internal();
  factory MenuService() => _instance;

  // 전역 메뉴 데이터 변수들
  final ValueNotifier<List<Map<String, String>>> categoryMenus = ValueNotifier([]);
  final ValueNotifier<List<MenuModel>> sidebarMenus = ValueNotifier([]);

  // 현재 선택된 'MenuModel 데이터 객체 자체'를 전역 상태로 관리
  final ValueNotifier<MenuModel?> currentMenu = ValueNotifier(null);

  // 가공되지 않은 순수 통신을 맡을 비서관 서비스
  final MenuApiService _menuApiService = MenuApiService();

  // 화면 변경 메소드
  void changeMenu(MenuModel menu) {
    currentMenu.value = menu;
  }

  // 홈 버튼 클릭 시 호출할 상태 초기화 메서드
  void resetToHome() {
    currentMenu.value = null;
    // currentMenu를 null로 만들면, CommonLayout 우측 영역이 알아서 기본 body 위젯을 띄움.
  }

  // DB(API 서버)에서 데이터를 조회해오는 함수
  Future<void> fetchMenusFromDB() async {
    try {
      // Supabase 'sidebar_menus' 테이블에서 순서(sort_order)대로 데이터를 긁어옴
      final List<dynamic> rawData = await _menuApiService.fetchMenus();

      // 평면형 DB 행(Row)들을 계층형 DTO 구조로 정제하기 위한 리스트 생성
      List<MenuModel> rootMenus = [];

      // 최상위 대메뉴(parent_id가 null인.)만 먼저 필터링
      final parentRows = rawData
          .where((row) => row['parent_id'] == null)
          .toList();

      for (var pRow in parentRows) {
        String pId = pRow['id'];

        // 현재 대메뉴의 ID를 부모로 지정하고 있는 자식 행들을 가져옴
        final childRows = rawData
            .where((row) => row['parent_id'] == pId)
            .toList();

        // 자식 데이터가 존재한다면 이 녀석들을 MenuModel DTO 리스트로 변환
        List<MenuModel>? childrenModels = childRows.isNotEmpty
            ? childRows
                  .map(
                    (cRow) => MenuModel.fromJson(
                      cRow,
                      screenBuilder: (context) =>
                          AppRouter.getScreen(cRow['path'] ?? '/'),
                    ),
                  )
                  .toList()
            : null;

        // 최종 대메뉴를 조립하여 루트 리스트에 담음 (자식 배열과 화면 빌더 결합)
        rootMenus.add(
          MenuModel.fromJson(
            pRow,
            children: childrenModels,
            screenBuilder: pRow['path'] != null
                ? (context) => AppRouter.getScreen(pRow['path'])
                : null,
          ),
        );
      }

      // 조립이 끝난 완벽한 계층형 DTO 데이터를 전역 확성기 상자에 할당.
      sidebarMenus.value = rootMenus;

      // AppBar 상단 카테고리 데이터 세팅
      categoryMenus.value = [
        {'id': 'c1', 'title': '개인정보수정'},
        {'id': 'c2', 'title': '임시메뉴'},
        {'id': 'c3', 'title': '시스템 설정'},
      ];

      // 초기 실행 시 첫 번째 메뉴(Home)가 자동으로 활성화되도록 기본값 주입
      // if (sidebarMenus.value.isNotEmpty) {
      //   currentMenu.value = sidebarMenus.value.first;
      // }
    } catch (e) {
      ('Supabase 메뉴 트리 가공 중 에러 발생: $e');
    }
  }
}
