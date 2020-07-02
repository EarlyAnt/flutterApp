import 'package:flutter/material.dart';

import 'pages/login/loginView.dart';
import 'pages/adobe_xd/adobe_xd0.dart';
import 'pages/wassail/iPhone678Plus1.dart';
import 'pages/wassail/iPhone678Plus2.dart';
import 'pages/wassail/iPhone678Plus3.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        RouteNames.login: (context) => LoginView(),
        RouteNames.xdpage0101: (context) => IPhoneXXS11Pro1(),
        RouteNames.xdpage0201: (context) => IPhone678Plus1(),
        RouteNames.xdpage0202: (context) => IPhone678Plus2(),
        RouteNames.xdpage0203: (context) => IPhone678Plus3(),
      },
      home: HomePageView(),
    );
  }
}

class HomePageView extends StatefulWidget {
  HomePageView({Key key}) : super(key: key);

  @override
  _HomePageViewState createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('首页')),
      body: Container(
        color: Colors.blueAccent,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              RaisedButton(
                child: Text('iPhone678Plus1'),
                onPressed: () {
                  Navigator.pushNamed(context, RouteNames.xdpage0201);
                },
              ),
              RaisedButton(
                child: Text('iPhone678Plus2'),
                onPressed: () {
                  Navigator.pushNamed(context, RouteNames.xdpage0202);
                },
              ),
              RaisedButton(
                child: Text('iPhone678Plus3'),
                onPressed: () {
                  Navigator.pushNamed(context, RouteNames.xdpage0203);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class RouteNames {
  static final String login = "/login";
  static final String xdpage0101 = "/xd_page_1_1";
  static final String xdpage0201 = "/xd_page_2_1";
  static final String xdpage0202 = "/xd_page_2_2";
  static final String xdpage0203 = "/xd_page_2_3";
}
