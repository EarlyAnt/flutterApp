import 'package:flutter/material.dart';

import 'routes.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: routes,
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
