// import 'package:flutter/material.dart';

// class TriangleTabIndicator extends Decoration {
//   @override
//   BoxPainter createBoxPainter([VoidCallback? onChanged]) {
//     return _TrianglePainter(this);
//   }
// }

// class _TrianglePainter extends BoxPainter {
//   final TriangleTabIndicator decoration;

//   _TrianglePainter(this.decoration);

//   @override
//   void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
//     final rect = Offset(offset.dx, (configuration.size!.height / 3) * 2.2) &
//         Size(configuration.size!.width * 0.1, configuration.size!.width * 0.1);
//     final Paint paint = Paint();
//     paint.color = Colors.white; // You can customize the color
//     paint.style = PaintingStyle.fill;

//     // Drawing the triangle
//     final path = Path();
//     path.moveTo(rect.center.dx, rect.top);
//     path.lineTo(rect.left, rect.bottom);
//     path.lineTo(rect.right, rect.bottom);
//     path.close();
//     canvas.drawPath(path, paint);
//   }
// }

import 'package:flutter/material.dart';

class TriangleTabIndicator extends Decoration {
  final BoxPainter _painter;

  TriangleTabIndicator({required Color color, required double width})
      : _painter = _TrianglePainter(color, width);

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _painter;
  }
}

class _TrianglePainter extends BoxPainter {
  final Paint _paint;
  final double width;

  _TrianglePainter(Color color, this.width)
      : _paint = Paint()
          ..color = color
          ..style = PaintingStyle.fill;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final left = offset.dx + (configuration.size!.width / 2) - (width / 2);
    final top = offset.dy + configuration.size!.height - 10;
    final middle = offset.dx + (configuration.size!.width / 2);
    final triangle = Path()
      ..moveTo(left, top + 10)
      ..lineTo(left + width, top + 10)
      ..lineTo(middle, top)
      ..close();
    canvas.drawPath(triangle, _paint);
  }
}
