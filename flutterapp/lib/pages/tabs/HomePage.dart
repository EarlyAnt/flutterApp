import 'package:flutter/material.dart';
import 'dart:math';

import 'CommonDatas.dart';
import 'Scan.dart';
import 'Edit.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: choices.length,
      child: Scaffold(
        appBar: PreferredSize(
          child: AppBar(
            bottom: PreferredSize(
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: TabBar(
                      isScrollable: true,
                      unselectedLabelColor: Colors.white54,
                      tabs: choices.map((Choice choice) {
                        return Tab(
                          text: choice.title,
                          icon: Icon(choice.icon),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
              preferredSize: Size.fromHeight(30),
            ),
          ),
          preferredSize: Size.fromHeight(75),
        ),
        body: TabBarView(
          children: choices.map((Choice choice) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: ChoiceCard(),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class ChoiceCard extends StatefulWidget {
  ChoiceCard({Key key}) : super(key: key);

  @override
  _ChoiceCardState createState() => _ChoiceCardState();
}

class _ChoiceCardState extends State<ChoiceCard> {
  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = Theme.of(context).textTheme.headline4;
    return Card(
      color: Colors.white,
      child: Center(
        child: GridView(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
            childAspectRatio: 0.9,
          ),
          children: dishes.map((dish) {
            print("create dish: " +
                dish.title +
                " count: " +
                dishes.length.toString());
            return DishCard(
              choice: dish,
              scanCallback: this._addNewItem,
              editCallback: this._updateItem,
            );
          }).toList(),
        ),
      ),
    );
  }

  _addNewItem(Choice choice) {
    setState(() {
      print("_addNewItem: " + choice.title);
      dishes.insert(
          dishes.length - 1,
          Choice(
              id: dishes.length + 1,
              title: choice != null && choice.title.isNotEmpty
                  ? choice.title
                  : '饭盒' + dishes.length.toString(),
              icon: Icons.fastfood));
    });
  }

  _updateItem(Choice choice) {
    setState(() {
      print("_updateItem: " + choice.title);
      Choice dish = dishes.firstWhere((element) => element.id == choice.id);
      if (dish != null)
        dish.title = choice != null && choice.title.isNotEmpty
            ? choice.title
            : '饭盒' + dishes.length.toString();
    });
  }
}

class DishCard extends StatelessWidget {
  const DishCard({Key key, this.choice, this.scanCallback, this.editCallback})
      : super(key: key);

  final Choice choice;
  final ScanCallback scanCallback;
  final RegisterCallback editCallback;

  Widget _buildScanDialog(Choice choice) => Dialog(
        backgroundColor: Colors.white,
        elevation: 5,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Container(
          width: 50,
          child: ScanDialog(
            choice: choice,
          ),
        ),
      );

  Widget _buildRegisterDialog(Choice choice) => Dialog(
        backgroundColor: Colors.white,
        elevation: 5,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Container(
          width: 50,
          child: EditDialog(choice: choice),
        ),
      );

  Future _showDialog(BuildContext context, bool scan, Choice choice) async {
    if (scan) {
      await showDialog(
          context: context,
          builder: (ctx) => _buildScanDialog(choice)).then((value) {
        if (value != null) {
          print('_buildScanDialog->result: ' + (value as Choice).title);
          if (value != null && scanCallback != null)
            scanCallback(value as Choice);
        }
      });
    } else {
      await showDialog(
          context: context,
          builder: (ctx) => _buildRegisterDialog(choice)).then((value) {
        if (value != null) {
          print('_buildRegisterDialog->result: ' + (value as Choice).title);
          if (value != null && editCallback != null)
            editCallback(value as Choice);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = Theme.of(context).textTheme.headline4;
    return GestureDetector(
      onTap: () {
        print(choice.title);
        this._showDialog(context, choice.scanButton == true, choice);
      },
      child: Card(
        color: Colors.lightBlue[50],
        child: Center(
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.center,
                child: Icon(choice.icon, size: 64, color: Colors.black54),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Text(choice.title),
              ),
              Visibility(
                visible: choice.scanButton != true,
                child: Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    width: 18.0,
                    height: 18.0,
                    child: CircleAvatar(
                      backgroundColor: _getColor(),
                      child: Text(
                        Random().nextInt(10).toString(),
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Color _getColor() {
  int value = Random().nextInt(10) % 3;
  if (value == 0)
    return Colors.red[300];
  else if (value == 1)
    return Colors.orange[300];
  else
    return Colors.green[300];
}

typedef ScanCallback = void Function(Choice choice);
typedef RegisterCallback = void Function(Choice choice);
