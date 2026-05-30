import 'package:flutter/material.dart';

class RectangleObject {
  Offset position;

  double width;
  double height;

  bool selected;

  RectangleObject({
    required this.position,
    this.width = 100,
    this.height = 100,
    this.selected = false,
  });
}