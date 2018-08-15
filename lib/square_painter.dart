import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class SquarePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Image empty1 = Image.asset('empty1.png');
    var empty1 = ExactAssetImage('emmpty1.png');
    // canvas.drawImage(empty1, Offset.zero, Paint());
  }

  // Since this Sky painter has no fields, it always paints
  // the same thing and semantics information is the same.
  // Therefore we return false here. If we had fields (set
  // from the constructor) then we would return true if any
  // of them differed from the same fields on the oldDelegate.
  @override
  bool shouldRepaint(SquarePainter oldDelegate) => false;
  @override
  bool shouldRebuildSemantics(SquarePainter oldDelegate) => false;
}
