import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'HomePage.dart';

class RegisterStatus {
  static final String Start = "start";
  static final String Next = "next";
}

class RegisterDialog extends StatefulWidget {
  RegisterDialog({Key key, this.choice}) : super(key: key);
  final Choice choice;

  @override
  _RegisterDialogState createState() => _RegisterDialogState();
}

class _RegisterDialogState extends State<RegisterDialog> {
  String _scanState = RegisterStatus.Start;
  Timer _timer;
  int _countdownTime = 3;
  TextEditingController _nameController = new TextEditingController();
  var _isSelected = [
    true,
    false,
    false,
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _buildBar(context),
          _buildTitle(),
          Visibility(
            visible: _scanState == RegisterStatus.Start,
            child: _buildStartFooter(context),
          ),
          Visibility(
            visible: _scanState == RegisterStatus.Next,
            child: _buildNextFooter(context),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    if (_timer != null) {
      _timer.cancel();
    }
  }

  Widget _buildTitle() {
    return Text(
      '完善信息',
      style: TextStyle(color: Color(0xff5CC5E9), fontSize: 24),
    );
  }

  String _getDateString() {
    var date = new DateTime.now();
    String timestamp =
        "${date.year.toString()}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}";
    print(timestamp);
    return timestamp;
  }

  Widget _buildStartFooter(context) {
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
            // decoration: BoxDecoration(
            //     color: Colors.cyan,
            //     border: Border.all(),
            //     borderRadius: BorderRadius.all(Radius.circular(20))),
            // height: 200.0,
            // child: Image.network(
            //   'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1594037476131&di=7858d3f5c971251d01aef12cdaec6aa3&imgtype=0&src=http%3A%2F%2Fimg2.imgtn.bdimg.com%2Fit%2Fu%3D1323399767%2C1188757571%26fm%3D214%26gp%3D0.jpg',
            //   fit: BoxFit.cover,
            // ),
            child: Icon(widget.choice.icon, size: 128),
          ),
          SizedBox(height: 10.0),
          TextField(
            controller: _nameController,
            decoration: InputDecoration(hintText: '输入菜名'),
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
                if (this._scanState == RegisterStatus.Start)
                  this._scanState = RegisterStatus.Next;
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

  Widget _buildNextFooter(context) {
    return Padding(
      padding:
          const EdgeInsets.only(bottom: 15.0, top: 10, left: 10, right: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Align(
            alignment: Alignment.topCenter,
            child: Icon(widget.choice.icon, size: 128),
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              '距离保质期还有' + Random().nextInt(15).toString() + '天',
              style: TextStyle(color: Colors.black54, fontSize: 16),
              // textAlign: TextAlign.justify,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CupertinoButton(
                  child: Text('Next'),
                  onPressed: () {
                    // this.startCountdownTimer(() => Navigator.of(context).pop(true));
                    Navigator.of(context).pop(true);
                  },
                ),
                CupertinoButton(
                  child: Text('Exit'),
                  onPressed: () {
                    // this.startCountdownTimer(() => Navigator.of(context).pop());
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
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
