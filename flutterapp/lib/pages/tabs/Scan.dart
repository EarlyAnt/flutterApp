import 'dart:math';
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'CommonDatas.dart';

class Pages {
  static final String ScanPage = "scan";
  static final String RegisterPage = "register";
}

class ScanStates {
  static final String Start = "start";
  static final String Scanning = "scanning";
}

class RegisterStates {
  static final String Start = "start";
  static final String Next = "next";
}

class ScanDialog extends StatefulWidget {
  ScanDialog({Key key, this.choice}) : super(key: key);

  final Choice choice;

  @override
  _ScanDialogState createState() => _ScanDialogState();
}

class _ScanDialogState extends State<ScanDialog> {
  String _page = Pages.ScanPage;
  String _scanState = ScanStates.Start;
  String _registerState = RegisterStates.Start;
  Timer _timer;
  int _countdownTime = Random().nextInt(3);
  TextEditingController _nameController = new TextEditingController();
  String _title = "";
  var _isSelected = [
    true,
    false,
    false,
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
        child: _page == Pages.ScanPage ? _scanPage() : _registerPage());
  }

  @override
  void dispose() {
    super.dispose();
    if (_timer != null) {
      _timer.cancel();
    }
  }

  Widget _scanPage() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _buildBar(context),
        _buildScanContent(),
        Visibility(
          visible: _scanState == ScanStates.Start,
          child: _buildScanStartFooter(context),
        ),
        Visibility(
          visible: _scanState == ScanStates.Scanning,
          child: _buildScanScanningFooter(context),
        ),
      ],
    );
  }

  Widget _registerPage() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _buildBar(context),
        Visibility(
          visible: _registerState == RegisterStates.Start,
          child: _buildRegisterStart(context),
        ),
        Visibility(
          visible: _registerState == RegisterStates.Next,
          child: _buildRegisterNext(context),
        ),
      ],
    );
  }

  Widget _buildBar(context) => Container(
        height: 30,
        alignment: Alignment.centerRight,
        margin: EdgeInsets.only(right: 10, top: 5),
        child: InkWell(
          onTap: () => Navigator.of(context).pop(),
          child: Icon(
            Icons.close,
            color: Color(0xff82CAE3),
          ),
        ),
      );

  Widget _buildScanContent() {
    return Column(
      children: <Widget>[
        Align(
          alignment: Alignment.center,
          child: Stack(
            children: <Widget>[
              Visibility(
                visible: this._scanState == ScanStates.Start,
                child: Icon(Icons.bluetooth, size: 128),
              ),
              Visibility(
                  visible: this._scanState == ScanStates.Scanning,
                  child: Icon(Icons.bluetooth_searching, size: 128))
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildScanStartFooter(context) {
    return Padding(
      padding:
          const EdgeInsets.only(bottom: 15.0, top: 10, left: 10, right: 10),
      child: Column(
        children: <Widget>[
          Text(
            '长按纽扣开关开启配对模式',
            style: TextStyle(color: Colors.black54, fontSize: 16),
            // textAlign: TextAlign.justify,
          ),
          SizedBox(height: 20.0),
          GestureDetector(
            onTap: () {
              setState(() {
                this.startCountdownTimer(
                    () => {this._page = Pages.RegisterPage});
                this._scanState = ScanStates.Scanning;
              });
            },
            child: Container(
              alignment: Alignment.center,
              height: 40,
              width: 100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  color: Colors.orangeAccent),
              child: Text('START',
                  style: TextStyle(color: Colors.white, fontSize: 16)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScanScanningFooter(context) {
    return Padding(
      padding:
          const EdgeInsets.only(bottom: 15.0, top: 10, left: 10, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Align(
            alignment: Alignment.topCenter,
            child: Text(
              '搜索中...',
              style: TextStyle(color: Colors.black54, fontSize: 16),
              // textAlign: TextAlign.justify,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRegisterStart(context) {
    _nameController.text =
        widget.choice.scanButton == true ? "" : widget.choice.title;

    return Padding(
      padding:
          const EdgeInsets.only(bottom: 15.0, top: 10, left: 10, right: 10),
      child: Column(
        children: <Widget>[
          Text(
            '添加日期: ' + _getDateString(),
            style: TextStyle(color: Colors.black54, fontSize: 16),
            // textAlign: TextAlign.justify,
          ),
          SizedBox(height: 10.0),
          Container(
            child: Image.network(
                'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1594086122114&di=69c2092c1a84a3052a0008d6ef220904&imgtype=0&src=http%3A%2F%2Fp1.meituan.net%2Fdeal%2F05dd3b123d68d734c5aabc259c2e8a2c2630213.jpg',
                fit: BoxFit.cover),
            // child: Icon(widget.choice.icon, size: 128),
          ),
          SizedBox(height: 10.0),
          TextField(
            controller: _nameController,
            decoration: InputDecoration(hintText: '输入菜名'),
            onChanged: (value) {
              _title = value;
              print("_title: ${_title}");
            },
          ),
          SizedBox(height: 10.0),
          ToggleButtons(
            children: <Widget>[
              Text('蔬菜'),
              Text('水果'),
              Text('海鲜'),
            ],
            borderWidth: 1,
            borderRadius: BorderRadius.circular(10),
            isSelected: _isSelected,
            onPressed: (value) => setState(() {
              _isSelected = _isSelected.map((e) => false).toList();
              _isSelected[value] = true;
            }),
          ),
          SizedBox(height: 10.0),
          GestureDetector(
            onTap: () {
              setState(() {
                this._registerState = RegisterStates.Next;
              });
            },
            child: Container(
              alignment: Alignment.center,
              height: 40,
              width: 100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  color: Colors.orangeAccent),
              child: Text('Submit',
                  style: TextStyle(color: Colors.white, fontSize: 16)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRegisterNext(context) {
    return Padding(
      padding:
          const EdgeInsets.only(bottom: 15.0, top: 10, left: 10, right: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Align(
            alignment: Alignment.topCenter,
            child: Icon(Icons.save, size: 128),
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              '距离保质期还有' + Random().nextInt(15).toString() + '天',
              style: TextStyle(color: Colors.black54, fontSize: 16),
              // textAlign: TextAlign.justify,
            ),
          ),
          SizedBox(height: 10),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FlatButton(
                  child: Text('Next', style: TextStyle(color: Colors.white)),
                  color: Colors.blue,
                  onPressed: () {
                    //Todo: 显示Toast提示
                    Fluttertoast.showToast(
                      msg: "功能开发中...",
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIos: 1,
                      backgroundColor: Colors.blue[300],
                      textColor: Colors.white,
                      fontSize: 16.0,
                    );
                  },
                ),
                SizedBox(width: 10),
                FlatButton(
                  child: Text('Exit', style: TextStyle(color: Colors.white)),
                  color: Colors.orange,
                  onPressed: () {
                    Navigator.of(context).pop(Choice(title: _title));
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getDateString() {
    var date = new DateTime.now();
    String timestamp =
        "${date.year.toString()}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}";
    print(timestamp);
    return timestamp;
  }

  void startCountdownTimer(Function callback) {
    const oneSec = const Duration(seconds: 1);
    var doTimer = (timer) => {
          setState(() {
            if (_countdownTime < 1) {
              _timer.cancel();
              if (callback != null) callback();
            } else {
              _countdownTime = _countdownTime - 1;
              print('...');
            }
          })
        };

    _timer = Timer.periodic(oneSec, doTimer);
  }
}

class CustomToggleButtons extends StatefulWidget {
  @override
  _CustomToggleButtonsState createState() => _CustomToggleButtonsState();
}

class _CustomToggleButtonsState extends State<CustomToggleButtons> {
  var _isSelected = [true, false, false];

  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      children: <Widget>[
        Icon(Icons.skip_previous),
        Icon(Icons.pause),
        Icon(Icons.skip_next),
      ],
      borderWidth: 1,
      borderRadius: BorderRadius.circular(10),
      isSelected: _isSelected,
      onPressed: (value) => setState(() {
        _isSelected = _isSelected.map((e) => false).toList();
        _isSelected[value] = true;
      }),
    );
  }
}
