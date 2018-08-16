import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'dart:ui' as ui;

class SquarePainter extends CustomPainter {
  final ui.Image tiles;
  final int tileX;
  final int tileY;
  SquarePainter({this.tiles, this.tileX, this.tileY});
  @override
  void paint(Canvas canvas, Size size) {
    double sourceSquareLength = 52.0;
    canvas.drawAtlas(
        tiles,
        [
          /* Scale the image to fit exactly within the widget's size */
          RSTransform.fromComponents(
            rotation: 0.0,
            scale: size.width / sourceSquareLength,
            anchorX: 0.0,
            anchorY: 0.0,
            translateX: 0.0,
            translateY: 0.0,
          )
        ],
        /* Set the source rectangle based on the (x, y) index of the tile
           We add 2 * tileX (or 2 * tileY) to compesate for the 2 pixel gutter between tiles */
        [
          Rect.fromLTWH(
            tileX * sourceSquareLength + 2 * tileX,
            tileY * sourceSquareLength + 2 * tileY,
            sourceSquareLength,
            sourceSquareLength,
          )
        ],
        [/* No need for colors */],
        BlendMode.src,
        null /* No need for cullRect */,
        Paint());
  }

  @override
  bool shouldRepaint(SquarePainter oldDelegate) => true;
  @override
  bool shouldRebuildSemantics(SquarePainter oldDelegate) => false;
}
