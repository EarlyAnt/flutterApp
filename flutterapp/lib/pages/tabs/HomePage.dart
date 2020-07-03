import 'package:flutter/material.dart';
import 'dart:math';

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
              child: ChoiceCard(choice: choice),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class Choice {
  const Choice({this.title, this.icon});

  final String title;
  final IconData icon;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: '我的饭盒', icon: Icons.fastfood),
  const Choice(title: '菜谱', icon: Icons.book),
];

class ChoiceCard extends StatelessWidget {
  const ChoiceCard({Key key, this.choice}) : super(key: key);

  final Choice choice;

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
            return DishCard(choice: dish);
          }).toList(),
        ),
      ),
    );
  }
}

const List<Choice> dishes = const <Choice>[
  const Choice(title: '饭盒1', icon: Icons.fastfood),
  const Choice(title: '饭盒2', icon: Icons.book),
  const Choice(title: '饭盒3', icon: Icons.cloud),
  const Choice(title: '饭盒4', icon: Icons.fastfood),
  const Choice(title: '饭盒5', icon: Icons.book),
  const Choice(title: '饭盒6', icon: Icons.cloud),
  const Choice(title: '饭盒7', icon: Icons.fastfood),
  const Choice(title: '饭盒8', icon: Icons.book),
  const Choice(title: '饭盒9', icon: Icons.cloud),
  const Choice(title: '饭盒10', icon: Icons.fastfood),
  const Choice(title: '饭盒11', icon: Icons.book),
  const Choice(title: '饭盒12', icon: Icons.cloud),
  const Choice(title: '饭盒13', icon: Icons.fastfood),
  const Choice(title: '饭盒14', icon: Icons.book),
  const Choice(title: '饭盒15', icon: Icons.cloud),
];

class DishCard extends StatelessWidget {
  const DishCard({Key key, this.choice}) : super(key: key);

  final Choice choice;

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = Theme.of(context).textTheme.headline4;
    return Card(
      color: Colors.lightBlue[50],
      child: Center(
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: Icon(choice.icon, size: 64),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Text(choice.title),
            ),
            Align(
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
          ],
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
