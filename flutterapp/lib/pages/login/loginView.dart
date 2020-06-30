import 'package:flutter/material.dart';
import 'package:flutterapp/utils/dio/dioUtils.dart';

class LoginView extends StatefulWidget {
  LoginView({Key key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  var _userName = TextEditingController();
  var _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('登录', textAlign: TextAlign.center),
        ),
        body: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              TextField(
                decoration: InputDecoration(hintText: '请输入用户名'),
                maxLines: 1,
                maxLength: 20,
                controller: _userName,
              ),
              TextField(
                decoration: InputDecoration(hintText: '请输入密码'),
                maxLines: 1,
                maxLength: 20,
                controller: _password,
              ),
              FlatButton(
                child: Text('登陆'),
                color: Colors.blue,
                highlightColor: Color(0xffF88B0A),
                onPressed: () {
                  print('username: ' + _userName.text);
                  print('password: ' + _password.text);
                  _login(_userName.text, _password.text);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

Future _login(String userName, String password) {
  Map<String, String> head = {};
  // Map<String, String> body = {
  //   'email': '54763755@qq.com',
  //   'password': 'bobo123456'
  // };
  Map<String, String> body = {
    'email': userName,
    'password': password,
  };

  DioUtils.postHttp(
    'https://m.api.gululu-a.com:9443/api/v1/m/user/login',
    parameters: body,
    onSuccess: (data) {
      print(data);
    },
    onError: (errorText) {
      print(errorText);
    },
  );
}
