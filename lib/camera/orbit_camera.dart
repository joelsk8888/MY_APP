import 'dart:ui';

class OrbitCamera {
  Offset pan = Offset.zero;
  double zoom = 1.0;

  void applyZoom(double scale) {
    zoom *= scale;
    zoom = zoom.clamp(0.2, 8.0);
  }

  void applyPan(Offset delta) {
    pan += delta;
  }
}