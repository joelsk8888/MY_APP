import 'package:flutter/material.dart';
import 'orbit_camera.dart';

class CameraController {
  final OrbitCamera camera = OrbitCamera();

  double _lastScale = 1.0;

  void onScaleStart(ScaleStartDetails details) {
    _lastScale = 1.0;
  }

  void onScaleUpdate(ScaleUpdateDetails details) {
    final scaleFactor = details.scale / _lastScale;
    _lastScale = details.scale;

    camera.applyZoom(scaleFactor);
    camera.applyPan(details.focalPointDelta);
  }
}