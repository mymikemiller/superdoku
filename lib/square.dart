import 'package:flutter/material.dart';

typedef void SquareTappedCallback(int index);

class Square extends StatelessWidget {
  final int index; // 0 to 80 for the grid, 0 to 8 for the selection row
  final int number;
  final bool isSelected;
  final bool isBold;
  final SquareTappedCallback onSquareTapped;

  Square(
      {this.index,
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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          // To figure out the background color, add the block x index (1-3)
          // to the block y index (also 1-3), then % 2 to color every other block
          color: ((_getX() / 3).toInt() + (_getY() / 3).toInt()) % 2 == 0
              ? Colors.grey.withAlpha(90)
              : Colors.grey.withAlpha(20),
          border: isSelected
              ? Border.all(color: Colors.blueAccent, width: 2.0)
              : Border.all(color: Colors.black, width: 0.5),
        ),
        child: Center(
          child: Text(
            number > 0 ? "$number" : "${""}",
            style: isBold
                ? TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold)
                : TextStyle(fontSize: 32.0, fontWeight: FontWeight.normal),
          ),
        ),
      ),
      onTap: () {
        onSquareTapped(index);
      },
    );
  }
}
