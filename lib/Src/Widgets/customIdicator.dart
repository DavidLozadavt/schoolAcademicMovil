import 'package:flutter/material.dart';

class CustomTabIndicator extends Decoration {
  final double indicatorSize;
  final Color color;

  const CustomTabIndicator({required this.indicatorSize, required this.color});

  @override
  _CustomPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CustomPainter(this, onChanged);
  }
}

class _CustomPainter extends BoxPainter {
  final CustomTabIndicator decoration;

  _CustomPainter(this.decoration, VoidCallback? onChanged) : super(onChanged);

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final Rect rect = offset & configuration.size!;
    final Paint paint = Paint()..color = decoration.color;

    final double indicatorWidth = rect.width * decoration.indicatorSize;
    const double indicatorHeight = 2.0; // Altura de la barra

    final Rect indicatorRect = Rect.fromPoints(
      Offset(rect.left + (rect.width - indicatorWidth) / 2, rect.bottom - indicatorHeight),
      Offset(rect.left + (rect.width + indicatorWidth) / 2, rect.bottom),
    );

    canvas.drawRect(indicatorRect, paint);
  }
}
