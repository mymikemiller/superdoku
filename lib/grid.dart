import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'square.dart';
import 'dart:ui' as ui;

class Grid extends StatelessWidget {
  final ui.Image tiles;
  final List<int> numbers;
  final int selectedNumber;
  final SquareTappedCallback onSquareTapped;

  Grid({this.tiles, this.numbers, this.selectedNumber, this.onSquareTapped});

  List<Widget> _buildSquares() {
    List<Square> squares = [];
    for (int i = 0; i < 81; i++) {
      squares.add(Square(
          tiles: tiles,
          index: i,
          number: numbers[i],
          isSelected: false,
          isBold: numbers[i] == selectedNumber,
          onSquareTapped: (square) {
            onSquareTapped(square);
          }));
    }
    return squares;
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      // Makes the actual items show up. Without this, they are squeezed out of existence.
      shrinkWrap: true,

      // Create a grid with 9 columns.
      crossAxisCount: 9,
      // Generate 81 Widgets that display their index in the List
      children: _buildSquares(),
    );
  }
}
