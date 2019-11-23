import 'package:flutter/material.dart';

class MyPainter extends CustomPainter {
  final String label;

  MyPainter(this.label);

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    Paint paint = Paint();

    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final RRect rRect = RRect.fromRectAndRadius(rect, Radius.circular(10));

    paint.color = Colors.white;
    canvas.drawRRect(rRect, paint);

    paint.color = Colors.green;

    canvas.drawCircle(Offset(20, size.height / 2), 10, paint);

    final textPainter = TextPainter(
        text: TextSpan(
            text: this.label,
            style: TextStyle(fontSize: 19, color: Colors.black)),
        maxLines: 2,
        textDirection: TextDirection.ltr);

    textPainter.layout(minWidth: 0, maxWidth: size.width - 50);
    textPainter.paint(
        canvas, Offset(40, size.height / 2 - textPainter.size.height / 2));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
