import 'package:flutter/material.dart';
import 'package:flutterapp/pages/login/loginView.dart';

import 'homePage.dart';
import 'pages/adobe_xd/adobe_xd0.dart';
import 'pages/wassail/iPhone678Plus1.dart';
import 'pages/wassail/iPhone678Plus2.dart';
import 'pages/wassail/iPhone678Plus3.dart';

final routes = {
  // '/': (context) => LoginView(),
  // '/': (context) => HomePage(),
  'homePage': (context) => HomePageView(),
  'login': (context) => LoginView(),
  'xd': (context) => IPhoneXXS11Pro1(),
  'p1': (context) => IPhone678Plus1(),
  'p2': (context) => IPhone678Plus2(),
  'p3': (context) => IPhone678Plus3(),
};

var onGenerateRoute = (RouteSettings settings) {
  final String name = settings.name;
  final Function pageContentBuilder = routes[name];
  if (pageContentBuilder != null) {
    if (settings.arguments != null) {
      final Route route = MaterialPageRoute(
          builder: (context) =>
              pageContentBuilder(context, arguments: settings.arguments));
      return route;
    } else {
      final Route route =
          MaterialPageRoute(builder: (context) => pageContentBuilder(context));
      return route;
    }
  }
};
