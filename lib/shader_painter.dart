import 'dart:ui';

import 'package:flutter/material.dart';

class ShaderPainter extends CustomPainter {
  final FragmentShader shader;
  final double timeTick;

  ShaderPainter({
    required this.shader,
    this.timeTick = 0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    shader.setFloat(0, size.width);
    shader.setFloat(1, size.height);
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..shader = shader,
    );
  }

  @override
  bool shouldRepaint(ShaderPainter painter) {
    return painter.shader != shader || painter.timeTick != timeTick;
  }
}
