import 'package:flutter/material.dart';
import 'package:superdoku/square_painter.dart';
import 'dart:ui' as ui;

typedef void SquareTappedCallback(int index);

class Square extends StatelessWidget {
  final ui.Image tiles;
  final int index; // 0 to 80 for the grid, 0 to 8 for the selection row
  final int number;
  final bool isSelected;
  final bool isBold;
  final SquareTappedCallback onSquareTapped;

  Square(
      {this.tiles,
      this.index,
      this.number,
      this.isSelected,
      this.isBold,
      this.onSquareTapped});

  _getX() {
    return (index % 9).toInt();
  }

  _getY() {
    return (index ~/ 9);
  }

  // Get the x index into the tiles image at which to find the square's image
  _getTileX() {
    return number;
  }

  // Get the y index into the tiles image at which to find the square's image
  _getTileY() {
    // backgroundOffset toggles whether to use the primar or secondary background
    var backgroundOffset =
        ((_getX() / 3).toInt() + (_getY() / 3).toInt()) % 2 == 0 ? 0 : 1;
    var baseRow = isBold ? 2 : 0;
    return baseRow + backgroundOffset;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // ClipRect
      child: GestureDetector(
        child: CustomPaint(
          // decoration: BoxDecoration(
          //   // To figure out the background color, add the block x index (1-3)
          //   // to the block y index (also 1-3), then % 2 to color every other block
          //   color: ((_getX() / 3).toInt() + (_getY() / 3).toInt()) % 2 == 0
          //       ? Colors.grey.withAlpha(90)
          //       : Colors.grey.withAlpha(20),
          //   border: isSelected
          //       ? Border.all(color: Colors.blueAccent, width: 2.0)
          //       : Border.all(color: Colors.black, width: 0.5),
          // ),
          painter: new SquarePainter(
            tiles: tiles,
            tileX: _getTileX(),
            tileY: _getTileY(),
          ),
        ),
        onTap: () {
          onSquareTapped(index);
        },
      ),
    );
  }
}
