//appbar, sidebar 임시 데이터
class MenuData {
  //appbar 메뉴
  static const List<Map<String, String>> categoryMenus = [
    {'id': 'c1', 'title': '카테고리1'},
    {'id': 'c2', 'title': '카테고리2'},
    {'id': 'c3', 'title': '카테고리3'},
  ];

  static const List<Map<String, dynamic>> sidebardMenus = [
    //sidebar 메뉴
    {
      'id': 'm1',
      'title': '대메뉴 1',
      'icon': 'folder',
      'children': [
        {'id': 'm1-1', 'title': '메뉴 1-1', 'path': '/menu1-1'},
        {'id': 'm1-2', 'title': '메뉴 1-2', 'path': '/menu1-2'},
      ],
    },
    {
      'id': 'm2',
      'title': '대메뉴 2',
      'icon': 'folder',
      'children': [
        {'id': 'm2-1', 'title': '메뉴 2-1', 'path': '/menu2-1'},
        {'id': 'm2-2', 'title': '메뉴 2-2', 'path': '/menu2-2'},
      ],
    },
    {
      'id': 'm3',
      'title': '메뉴 3',
      'icon': 'dashboard',
      'path': '/menu3',
      'children': null,
    },
  ];
}
