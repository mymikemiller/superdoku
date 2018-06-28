import 'package:flutter/material.dart';
import 'square.dart';

class SelectionRow extends StatelessWidget {
  // Start with nothing selected
  final int selectedNumber;

  final SquareTappedCallback onSquareTapped;

  SelectionRow({this.selectedNumber, this.onSquareTapped});

  List<Widget> _buildSquares() {
    List<Square> squares = [];
    for (int i = 0; i < 9; i++) {
      Square square = Square(i, i + 1, i + 1 == selectedNumber, (index) {
        onSquareTapped(index);
      });
      squares.add(square);
    }
    return squares;
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      // Create a grid with 9 columns.
      crossAxisCount: 9,

      children: _buildSquares(),
    );
  }
}
