import 'package:flutter/material.dart';

class Choice {
  Choice({this.id, this.title, this.icon, this.scanButton});

  final int id;
  final IconData icon;
  final bool scanButton;
  String title;
}

List<Choice> choices = <Choice>[
  Choice(title: '我的饭盒', icon: Icons.fastfood),
  Choice(title: '菜谱', icon: Icons.book),
];

List<Choice> dishes = <Choice>[
  Choice(id: 1, title: '饭盒1', icon: Icons.fastfood),
  Choice(id: 2, title: '饭盒2', icon: Icons.book),
  Choice(id: 3, title: '饭盒3', icon: Icons.cloud),
  Choice(id: 4, title: '饭盒4', icon: Icons.fastfood),
  Choice(id: 5, title: '饭盒5', icon: Icons.book),
  Choice(id: 6, title: '饭盒6', icon: Icons.cloud),
  Choice(id: 7, title: '添加新饭盒', icon: Icons.add, scanButton: true),
];
