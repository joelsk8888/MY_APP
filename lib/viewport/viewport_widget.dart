import 'package:flutter/material.dart';

import '../camera/camera_controller.dart';
import '../core/tool_mode.dart';
import '../objects/rectangle_object.dart';

class ViewportWidget extends StatefulWidget {
  final ToolMode currentTool;

  const ViewportWidget({
    super.key,
    required this.currentTool,
  });

  @override
  State<ViewportWidget> createState() => _ViewportWidgetState();
}

class _ViewportWidgetState extends State<ViewportWidget> {
  final CameraController controller = CameraController();

  final List<RectangleObject> rectangles = [];

  void createRectangle(TapDownDetails details, Size size) {
    final camera = controller.camera;

    final screenPosition = details.localPosition;

    final worldX =
        (screenPosition.dx - size.width / 2 - camera.pan.dx) /
            camera.zoom;

    final worldY =
        (screenPosition.dy - size.height / 2 - camera.pan.dy) /
            camera.zoom;

    rectangles.add(
      RectangleObject(
        position: Offset(worldX, worldY),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = Size(
          constraints.maxWidth,
          constraints.maxHeight,
        );

        return GestureDetector(
          onTapDown: (details) {
            if (widget.currentTool == ToolMode.rectangle) {
              setState(() {
                createRectangle(details, size);
              });
            }
          },

          onScaleStart: controller.onScaleStart,

          onScaleUpdate: (details) {
            setState(() {
              controller.onScaleUpdate(details);
            });
          },

          child: CustomPaint(
            painter: ViewportPainter(
              controller,
              rectangles,
            ),
            child: Container(),
          ),
        );
      },
    );
  }
}

class ViewportPainter extends CustomPainter {
  final CameraController controller;
  final List<RectangleObject> rectangles;

  ViewportPainter(
    this.controller,
    this.rectangles,
  );

  @override
  void paint(Canvas canvas, Size size) {
    final camera = controller.camera;

    // fondo
    canvas.drawRect(
      Offset.zero & size,
      Paint()..color = const Color(0xFF1E1E1E),
    );

    // centro
    canvas.translate(
      size.width / 2 + camera.pan.dx,
      size.height / 2 + camera.pan.dy,
    );

    // zoom
    canvas.scale(camera.zoom);

    // grid
    final gridPaint = Paint()
      ..color = const Color(0xFF555555)
      ..strokeWidth = 1 / camera.zoom;

    const step = 50.0;
    const limit = 10000.0;

    for (double x = -limit; x <= limit; x += step) {
      canvas.drawLine(
        Offset(x, -limit),
        Offset(x, limit),
        gridPaint,
      );
    }

    for (double y = -limit; y <= limit; y += step) {
      canvas.drawLine(
        Offset(-limit, y),
        Offset(limit, y),
        gridPaint,
      );
    }

    // cuadrados
    final rectPaint = Paint()
      ..color = const Color(0xFF2196F3);

    for (final rect in rectangles) {
      canvas.drawRect(
        Rect.fromCenter(
          center: rect.position,
          width: rect.width,
          height: rect.height,
        ),
        rectPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}