import 'package:flutter/material.dart';
import 'package:flutter_frontend_ys/common/utils/menu_service.dart';

class CommonLayout extends StatelessWidget {
  final Widget body;
  final String title;

  const CommonLayout({super.key, this.title = '관리 시스템', required this.body});

  @override
  Widget build(BuildContext context) {
    //싱글톤 상자
    final menuService = MenuService();

    return Scaffold(
      // 1. 상단 카테고리 메뉴 영역
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        foregroundColor: Colors.white,
        title: Text(title),
        actions: [
          ValueListenableBuilder<List<Map<String, String>>>(
            valueListenable: menuService.categoryMenus, // 감시할 상자 지정
            builder: (context, categories, child) {
              return Row(
                children: categories.map((menu) {
                  return TextButton(
                    onPressed: () {},
                    child: Text(
                      menu['title']!,
                      style: const TextStyle(color: Colors.white),
                    ),
                  );
                }).toList(),
              );
            },
          ),
          const SizedBox(width: 20),
        ],
      ),
      // 2. 좌측 트리 메뉴 영역 (가로폭 250으로 고정)
      body: Row(
        children: [
          Container(
            width: 250,
            color: Colors.grey[100],
            child: ValueListenableBuilder<List<Map<String, dynamic>>>(
              valueListenable: menuService.sidebarMenus, //감시할 상자 선택
              builder: (context, menus, child) {
                // 아직 DB에서 데이터를 가져오기 전이라 리스트가 비어있다면 로딩 동그라미 표현
                if (menus.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }

                // 데이터가 서버에서 도착하면 아래 리스트뷰가 동적으로 표현
                return ListView(
                  children: menus.map((menu) {
                    IconData menuIcon = _getMenuIcon(menu['icon']);

                    // 하위 메뉴(children)가 존재하는 계층형 메뉴일 때
                    if (menu['children'] != null) {
                      return ExpansionTile(
                        leading: Icon(menuIcon),
                        title: Text(
                          menu['title'],
                          style: TextStyle(fontSize: 14),
                        ),
                        children: (menu['children'] as List).map((child) {
                          final childMap = child as Map<String, dynamic>;
                          return ListTile(
                            title: Text('  └ ${childMap['title']}'),
                            dense: true,
                            onTap: () {},
                          );
                        }).toList(),
                      );
                    }
                    // 하위 메뉴가 없는 단일 메뉴일 때
                    else {
                      return ListTile(
                        leading: Icon(menuIcon),
                        title: Text(menu['title']),
                        onTap: () {},
                      );
                    }
                  }).toList(),
                );
              },
            ),
          ),
          // 수직 구분선
          VerticalDivider(width: 1, color: Colors.grey[300]),
          // 3. 우측 실제 콘텐츠 영역 (나머지 공간을 꽉 채움)
          Expanded(
            child: Container(
              color: Colors.white,
              child: body, // 외부에서 던져준 화면
            ),
          ),
        ],
      ),
    );
  }

  //아이콘 반환
  IconData _getMenuIcon(String? iconStr) {
    switch (iconStr) {
      case 'dashboard':
        return Icons.dashboard;
      case 'folder':
        return Icons.folder;
      case 'settings':
        return Icons.settings;
      case 'home':
        return Icons.home;
      default:
        return Icons.folder; // 매칭되는 게 없거나 null일 때 보여줄 기본 아이콘
    }
  }
}
