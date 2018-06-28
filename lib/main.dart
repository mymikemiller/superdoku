import 'package:flutter/material.dart';
import 'grid.dart';
import 'selection_row.dart';
import 'package:scoped_model/scoped_model.dart';

void main() => runApp(new MyApp());

class AppModel extends Model {
  int _selectedNumber = 0;
  int get selectedNumber => _selectedNumber;

  List<int> _numbers = List.generate(81, (index) {
    return 0;
  });
  List<int> get numbers => _numbers;

  void setSelectedNumber(int number) {
    _selectedNumber = number;
    notifyListeners();
  }

  void setGridNumber(index, number) {
    _numbers[index] = number;
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'SuperDoku',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new ScopedModel<AppModel>(
        model: AppModel(),
        child: Home(),
      ),
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
      body: Column(
        children: <Widget>[
          ScopedModelDescendant<AppModel>(
            builder: (context, child, model) => Grid(
                  numbers: model.numbers,
                  onSquareTapped: (index) {
                    if (model.numbers[index] == model.selectedNumber) {
                      model.setGridNumber(index, 0);
                    } else {
                      model.setGridNumber(index, model.selectedNumber);
                    }
                  },
                ),
          ),
          ScopedModelDescendant<AppModel>(
            builder: (context, child, model) => SelectionRow(
                  selectedNumber: model.selectedNumber,
                  onSquareTapped: (index) {
                    model.setSelectedNumber(index + 1);
                  },
                ),
          ),
        ],
      ),
    );
  }
}
