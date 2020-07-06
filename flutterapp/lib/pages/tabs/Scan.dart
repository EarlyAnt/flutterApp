import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _buildRaisedButton(context),
        _buildDialog(),
      ],
    );
  }

  Widget _buildDialog() => Dialog(
        backgroundColor: Colors.white,
        elevation: 5,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Container(
          width: 50,
          child: ScanDialog(),
        ),
      );

  Widget _buildRaisedButton(BuildContext context) => RaisedButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        color: Colors.blue,
        onPressed: () {
          showDialog(context: context, builder: (ctx) => _buildDialog());
        },
        child: Text(
          'Just Show It !',
          style: TextStyle(color: Colors.white),
        ),
      );
}

class ScanStates {
  static final String Start = "start";
  static final String Doing = "doing";
}

class ScanDialog extends StatefulWidget {
  ScanDialog({Key key}) : super(key: key);
  @override
  _ScanDialogState createState() => _ScanDialogState();
}

class _ScanDialogState extends State<ScanDialog> {
  String _scanState = ScanStates.Start;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _buildBar(context),
          _buildContent(),
          Visibility(
            visible: _scanState == ScanStates.Start,
            child: _buildStartFooter(context),
          ),
          Visibility(
            visible: _scanState == ScanStates.Doing,
            child: _buildDoingFooter(context),
          ),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      '添加设备',
      style: TextStyle(color: Color(0xff5CC5E9), fontSize: 24),
    );
  }

  Widget _buildContent() {
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
                  visible: this._scanState == ScanStates.Doing,
                  child: Icon(Icons.bluetooth_searching, size: 128))
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStartFooter(context) {
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
                if (this._scanState == ScanStates.Start)
                  this._scanState = ScanStates.Doing;
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

  Widget _buildDoingFooter(context) {
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
}
