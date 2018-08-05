import 'package:flutter/material.dart';
import 'grid.dart';
import 'selection_row.dart';
import 'package:scoped_model/scoped_model.dart';
import 'puzzle.dart';
import 'puzzle_api.dart';

void main() {
  runApp(new MyApp());
}

class AppModel extends Model {
  int _selectedNumber = 0;
  int get selectedNumber => _selectedNumber;

  List<int> _numbers = List.generate(81, (index) {
    return 0;
  });
  List<int> get numbers => _numbers;

  List<int> _givenNumbers = List.generate(80, (index) => 0);
  List<int> get givenNumbers => _givenNumbers;

  void setSelectedNumber(int number) {
    _selectedNumber = number;
    notifyListeners();
  }

  void setGridNumber(index, number) {
    _numbers[index] = number;
    notifyListeners();
  }

  void setPuzzle(puzzle) {
    _numbers = List.from(puzzle.board);
    _givenNumbers = List.from(puzzle.board);
    notifyListeners();
  }
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
      home: new ScopedModel<AppModel>(
        model: appModel,
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
                  selectedNumber: model.selectedNumber,
                  onSquareTapped: (index) {
                    // Only allow changing the number if it's not one of the given numbers from the puzzle
                    if (model.givenNumbers[index] == 0) {
                      if (model.numbers[index] == model.selectedNumber) {
                        model.setGridNumber(index, 0);
                      } else {
                        model.setGridNumber(index, model.selectedNumber);
                      }
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
          ScopedModelDescendant<AppModel>(
            builder: (context, child, model) => RaisedButton(
                  child: Text("Generate Easy Puzzle"),
                  onPressed: () {
                    PuzzleApi.fetchPuzzle().then((puzzle) {
                      model.setPuzzle(puzzle);
                    });
                  },
                ),
          ),
        ],
      ),
    );
  }
}
