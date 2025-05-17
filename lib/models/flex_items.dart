import 'package:flutter/material.dart';

class FlexItem {
  final Widget child;
  final int? flex;
  final bool shrink;

  const FlexItem({
    required this.child,
    this.flex,
    this.shrink = false,
  });
}
