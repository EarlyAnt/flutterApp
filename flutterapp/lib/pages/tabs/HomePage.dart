import 'package:flutter/material.dart';
import 'dart:math';

import 'Scan.dart';

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

class Choice {
  const Choice({this.title, this.icon, this.button});

  final String title;
  final IconData icon;
  final bool button;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: '我的饭盒', icon: Icons.fastfood),
  const Choice(title: '菜谱', icon: Icons.book),
];

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
            return DishCard(
              choice: dish,
              callback: this._refresh,
            );
          }).toList(),
        ),
      ),
    );
  }

  _refresh() {
    setState(() {
      print("1 2 3 4 5 6");
      dishes.insert(dishes.length - 1,
          Choice(title: '饭盒' + dishes.length.toString(), icon: Icons.fastfood));
    });
  }
}

List<Choice> dishes = <Choice>[
  const Choice(title: '饭盒1', icon: Icons.fastfood),
  const Choice(title: '饭盒2', icon: Icons.book),
  const Choice(title: '饭盒3', icon: Icons.cloud),
  const Choice(title: '饭盒4', icon: Icons.fastfood),
  const Choice(title: '饭盒5', icon: Icons.book),
  const Choice(title: '饭盒6', icon: Icons.cloud),
  const Choice(title: '添加新饭盒', icon: Icons.add, button: true),
];

class DishCard extends StatelessWidget {
  const DishCard({Key key, this.choice, this.callback}) : super(key: key);

  final Choice choice;
  final Function callback;

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

  Future _showDialog(BuildContext context) async {
    await showDialog(context: context, builder: (ctx) => _buildDialog())
        .then((value) => {
              print('result: ' + value.toString()),
              if (value == true && callback != null) callback()
            });
    // if (this.callback != null) this.callback();
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = Theme.of(context).textTheme.headline4;
    return GestureDetector(
      onTap: () {
        print(choice.title);
        if (choice.button == true) this._showDialog(context);
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
                visible: choice.button != true,
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
