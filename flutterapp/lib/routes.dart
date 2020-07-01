import 'package:flutter/material.dart';

import 'pages/login/loginView.dart';
import 'package:flutterapp/pages/homePage.dart';
import 'pages/adobe_xd/adobe_xd0.dart';

final routes = {
  // '/': (context) => LoginView(),
  '/': (context) => IPhoneXXS11Pro1(),
  'homePage': (context) => HomePage(),
  'xd': (context) => IPhoneXXS11Pro1(),
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
