// Connects the grid with the selection row, and loads the graphics for both

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:superdoku/grid.dart';
import 'package:superdoku/puzzle_api.dart';
import 'package:superdoku/selection_row.dart';

class GameModel extends Model {
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

class Game extends StatefulWidget {
  final GameModel gameModel = GameModel();
  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  @override
  Widget build(BuildContext context) {
    return new ScopedModel<GameModel>(
      model: widget.gameModel,
      child: Column(
        children: <Widget>[
          ScopedModelDescendant<GameModel>(
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
          ScopedModelDescendant<GameModel>(
            builder: (context, child, model) => SelectionRow(
                  selectedNumber: model.selectedNumber,
                  onSquareTapped: (index) {
                    model.setSelectedNumber(index + 1);
                  },
                ),
          ),
          ScopedModelDescendant<GameModel>(
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

class AppModel {}
