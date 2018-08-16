import 'package:flutter/material.dart';
import 'square.dart';
import 'dart:ui' as ui;

class SelectionRow extends StatelessWidget {
  final ui.Image tiles;

  // Start with nothing selected
  final int selectedNumber;

  final SquareTappedCallback onSquareTapped;

  SelectionRow({this.tiles, this.selectedNumber, this.onSquareTapped});

  List<Widget> _buildSquares() {
    List<Square> squares = [];
    for (int i = 0; i < 9; i++) {
      Square square = Square(
          tiles: tiles,
          index: i,
          number: i + 1,
          isSelected: i + 1 == selectedNumber,
          isBold: false,
          onSquareTapped: (index) {
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
