import 'package:flutter/material.dart';
import 'package:flutterapp/routes.dart';
import 'routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: 'p3',//初始化时加载默认路由
      onGenerateRoute: onGenerateRoute,
    );
  }
}