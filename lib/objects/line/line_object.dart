import 'package:flutter/material.dart';

class LineObject {
  Offset start;
  Offset end;

  bool selected;

  LineObject({
    required this.start,
    required this.end,
    this.selected = false,
  });
}