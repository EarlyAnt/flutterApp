import 'package:flutter/material.dart';

import 'pages/login/loginView.dart';
import 'package:flutterapp/pages/homePage.dart';

final routes = {
  '/': (context) => LoginView(),
  'homePage': (context) => HomePage(),
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
