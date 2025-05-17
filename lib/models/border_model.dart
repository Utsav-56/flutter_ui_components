import 'package:flutter/material.dart';

class BorderModel {
  final double size;
  final BorderStyle style;
  final Color color;

  BorderModel(this.size, this.style, this.color);

  Border toBorder() {
    return Border.all(
      width: size,
      style: style,
      color: color,
    );
  }
}
