import 'package:flutter/material.dart';

import '../camera/camera_controller.dart';
import '../objects/rectangle_object.dart';

class SelectionManager {
  RectangleObject? selectedRectangle;

  void clearSelection(
    List<RectangleObject> rectangles,
  ) {
    for (final rect in rectangles) {
      rect.selected = false;
    }

    selectedRectangle = null;
  }

  void selectRectangle(
    TapDownDetails details,
    Size size,
    CameraController controller,
    List<RectangleObject> rectangles,
  ) {
    clearSelection(rectangles);

    final camera = controller.camera;

    final screenPosition = details.localPosition;

    final worldX =
        (screenPosition.dx -
                size.width / 2 -
                camera.pan.dx) /
            camera.zoom;

    final worldY =
        (screenPosition.dy -
                size.height / 2 -
                camera.pan.dy) /
            camera.zoom;

    for (final rect in rectangles.reversed) {
      final left =
          rect.position.dx - rect.width / 2;

      final right =
          rect.position.dx + rect.width / 2;

      final top =
          rect.position.dy - rect.height / 2;

      final bottom =
          rect.position.dy + rect.height / 2;

      if (worldX >= left &&
          worldX <= right &&
          worldY >= top &&
          worldY <= bottom) {
        rect.selected = true;

        selectedRectangle = rect;

        break;
      }
    }
  }

  void moveSelectedRectangle(
    DragUpdateDetails details,
    CameraController controller,
  ) {
    if (selectedRectangle == null) return;

    final zoom = controller.camera.zoom;

    selectedRectangle!.position += Offset(
      details.delta.dx / zoom,
      details.delta.dy / zoom,
    );
  }
}