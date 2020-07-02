import 'package:flutter/material.dart';

import 'pages/login/loginView.dart';
import 'pages/adobe_xd/adobe_xd0.dart';
import 'pages/wassail/iPhone678Plus1.dart';
import 'pages/wassail/iPhone678Plus2.dart';
import 'pages/wassail/iPhone678Plus3.dart';

class RouteNames {
  static final String login = "/login";
  static final String xdpage0101 = "/xd_page_1_1";
  static final String xdpage0201 = "/xd_page_2_1";
  static final String xdpage0202 = "/xd_page_2_2";
  static final String xdpage0203 = "/xd_page_2_3";
}

final routes = {
  RouteNames.login: (context) => LoginView(),
  RouteNames.xdpage0101: (context) => IPhoneXXS11Pro1(),
  RouteNames.xdpage0201: (context) => IPhone678Plus1(),
  RouteNames.xdpage0202: (context) => IPhone678Plus2(),
  RouteNames.xdpage0203: (context) => IPhone678Plus3(),
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
  return null;
};
