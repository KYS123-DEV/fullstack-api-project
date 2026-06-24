//공용 화면 DTO
import 'package:flutter/material.dart';

class MenuModel {
  final String id;
  final String title;
  final String? icon;
  final String? path;
  final List<MenuModel>? children;

  //메뉴 클릭 시 우측에 그려낼 화면 생성
  final Widget Function(BuildContext)? screenBuilder;

  const MenuModel({
    required this.id,
    required this.title,
    this.icon,
    this.path,
    this.children,
    this.screenBuilder,
  });

  // 백엔드(NestJS)에서 넘어온 Map(JSON) 데이터를 DTO 객체로 변환하는 팩토리 메서드
  // 임시 mock 데이터 변환용 factory (하드코딩 단계용)
  factory MenuModel.fromMock({
    required String id,
    required String title,
    String? icon,
    String? path,
    List<MenuModel>? children,
    Widget Function(BuildContext)? screenBuilder,
  }) {
    return MenuModel(
      id: id,
      title: title,
      icon: icon,
      path: path,
      children: children,
      screenBuilder: screenBuilder,
    );
  }
}
