import 'package:flutter/material.dart';

class Setting extends StatefulWidget {
  Setting({Key key}) : super(key: key);

  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Column(
          children: <Widget>[
            ListTile(
              title: Text("我是一个文本"),
            ),
            ListTile(
              title: Text("我是一个文本"),
            ),
            ListTile(
              title: Text("我是一个文本"),
            ),
            ListTile(
              title: Text("我是一个文本"),
            )
          ],
        )
      ],
    );
  }
}
