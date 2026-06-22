import 'package:flutter/material.dart';
import 'package:flutter_frontend_ys/common/utils/menu_data.dart';

class CommonLayout extends StatelessWidget {
  final Widget body;
  final String title;

  const CommonLayout({super.key, this.title = '관리 시스템', required this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 1. 상단 카테고리 메뉴 영역
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        foregroundColor: Colors.white,
        title: Text(title),
        actions: [
          ...MenuData.categoryMenus.map((menu) {
            return TextButton(
              onPressed: () {},
              child: Text(
                menu['title']!,
                style: const TextStyle(color: Colors.white),
              ),
            );
          }),
          const SizedBox(width: 20),
        ],
      ),
      // 2. 좌측 트리 메뉴 영역 (가로폭 250으로 고정)
      body: Row(
        children: [
          Container(
            width: 250,
            color: Colors.grey[100],
            child: ListView(
              children: [
                ...MenuData.sidebardMenus.map((menu) {
                  IconData menuIcon = menu['icon'] == 'dashboard'
                      ? Icons.dashboard
                      : Icons.folder;
                  if (menu['children'] != null) {
                    return ExpansionTile(
                      leading: Icon(menuIcon),
                      title: Text(menu['title']),
                      children: (menu['children'] as List<Map<String, String>>)
                          .map((child) {
                            return ListTile(
                              title: Text('  └ ${child['title']}'),
                              dense: true,
                              onTap: () {},
                            );
                          })
                          .toList(),
                    );
                  } else {
                    return ListTile(
                      leading: Icon(menuIcon),
                      title: Text(menu['title']),
                      onTap: () {},
                    );
                  }
                }),
              ],
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
}
