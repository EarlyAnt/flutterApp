import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          RaisedButton(
            child: Text('iPhone678Plus1'),
            onPressed: () {
              Navigator.pushNamed(context, '/p1');
            },
          ),
          RaisedButton(
            child: Text('iPhone678Plus2'),
            onPressed: () {
              Navigator.pushNamed(context, '/p2');
            },
          ),
          RaisedButton(
            child: Text('iPhone678Plus3'),
            onPressed: () {
              Navigator.pushNamed(context, '/p3');
            },
          )
        ],
      ),
    );
  }
}
