import 'package:flutter/material.dart';
import 'transform.dart';

class SceneObject {
  String name;
  Transform transform;
  Color color;
  double width;
  double height;

  SceneObject({
    required this.name,
    required this.transform,
    required this.color,
    required this.width,
    required this.height,
  });
}