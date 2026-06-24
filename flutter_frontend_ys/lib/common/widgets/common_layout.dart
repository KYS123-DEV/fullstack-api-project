import 'package:flutter/material.dart';
import 'package:flutter_frontend_ys/common/utils/menu_service.dart';
import 'package:flutter_frontend_ys/common/utils/menu_model.dart';

class CommonLayout extends StatelessWidget {
  final Widget body;
  final String title;

  const CommonLayout({super.key, this.title = '관리 시스템', required this.body});

  @override
  Widget build(BuildContext context) {
    final menuService = MenuService();

    return Scaffold(
      // 1. 상단 카테고리 메뉴 영역
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        foregroundColor: Colors.white,
        title: Text(title),
        actions: [
          ValueListenableBuilder<List<Map<String, String>>>(
            valueListenable: menuService.categoryMenus,
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
      // 2. 좌측 사이드 영역 (가로폭 250으로 고정)
      body: Row(
        children: [
          Container(
            width: 250,
            color: Colors.grey[100],
            child: ValueListenableBuilder<List<MenuModel>>(
              valueListenable: menuService.sidebarMenus,
              builder: (context, menus, child) {
                if (menus.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }
                return ListView(
                  children: menus.map((menu) {
                    IconData menuIcon = _getMenuIcon(menu.icon);
                    // 하위 메뉴(children)가 존재하는 계층형 메뉴일 때
                    if (menu.children != null) {
                      return ExpansionTile(
                        leading: Icon(menuIcon),
                        title: Text(
                          menu.title,
                          style: const TextStyle(fontSize: 14),
                        ),
                        children: menu.children!.map((childMenu) {
                          return ListTile(
                            title: Text('  └ ${childMenu.title}'),
                            dense: true,
                            onTap: () {
                              // 문자열 path 대신 데이터 모델 객체를 통째로 넘겨 할당
                              menuService.changeMenu(childMenu);
                            },
                          );
                        }).toList(),
                      );
                    }
                    // 하위 메뉴가 없는 단일 메뉴일 때
                    else {
                      return ListTile(
                        leading: Icon(menuIcon),
                        title: Text(menu.title),
                        onTap: () {
                          // 단일 메뉴 클릭 시에도 객체 자체를 넘겨 할당
                          menuService.changeMenu(menu);
                        },
                      );
                    }
                  }).toList(),
                );
              },
            ),
          ),
          // 수직 구분선
          VerticalDivider(width: 1, color: Colors.grey[300]),

          // 우측 실제 콘텐츠 영역 (비동기 화면 자동 렌더링 지점)
          Expanded(
            child: Container(
              color: Colors.white,
              child: ValueListenableBuilder<MenuModel?>(
                valueListenable: menuService.currentMenu,
                builder: (context, selectedMenu, child) {
                  if (selectedMenu == null ||
                      selectedMenu.screenBuilder == null) {
                    return body;
                  }
                  // 선택된 데이터가 제공하는 고유 빌더 공장 함수를 구동시켜 화면을 반환.
                  return selectedMenu.screenBuilder!(context);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 아이콘 변환 헬퍼
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
        return Icons.folder;
    }
  }
}
