import 'package:flutter/material.dart';
import 'package:superdoku/game.dart';
import 'selection_row.dart';
import 'package:scoped_model/scoped_model.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  final AppModel appModel = AppModel();

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'SuperDoku',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => new _HomeState();
}

class _HomeState extends State<Home> {
  SelectionRow _selectionRow = SelectionRow();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('SuperDoku'),
      ),
      body: Game(),
    );
  }
}
