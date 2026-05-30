import 'package:flutter/material.dart';

import '../camera/camera_controller.dart';
import '../core/cursor_state.dart';
import '../core/tool_mode.dart';
import '../objects/line/line_object.dart';
import '../objects/rectangle/rectangle_object.dart';
import '../selection/selection_manager.dart';

class ViewportWidget extends StatefulWidget {
  final ToolMode currentTool;

  const ViewportWidget({
    super.key,
    required this.currentTool,
  });

  @override
  State<ViewportWidget> createState() =>
      _ViewportWidgetState();
}

class _ViewportWidgetState
    extends State<ViewportWidget> {
  final CameraController controller =
      CameraController();

  final SelectionManager
      selectionManager =
      SelectionManager();

  final List<RectangleObject> rectangles =
      [];

  final List<LineObject> lines = [];

  Offset? lineStartPoint;

  Offset currentCursorWorld =
      Offset.zero;

  void createRectangle(
    TapDownDetails details,
    Size size,
  ) {
    final camera = controller.camera;

    final screenPosition =
        details.localPosition;

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

    rectangles.add(
      RectangleObject(
        position: Offset(
          worldX,
          worldY,
        ),
      ),
    );
  }

  void createLine(
    TapDownDetails details,
    Size size,
  ) {
    final camera = controller.camera;

    final screenPosition =
        details.localPosition;

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

    final point = Offset(
      worldX,
      worldY,
    );

    if (lineStartPoint == null) {
      lineStartPoint = point;
      return;
    }

    lines.add(
      LineObject(
        start: lineStartPoint!,
        end: point,
      ),
    );

    lineStartPoint = null;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (
        context,
        constraints,
      ) {
        final size = Size(
          constraints.maxWidth,
          constraints.maxHeight,
        );

        return GestureDetector(
          onTapDown: (details) {
            setState(() {
              if (widget.currentTool ==
                  ToolMode.line) {
                createLine(
                  details,
                  size,
                );
              }

              if (widget.currentTool ==
                  ToolMode.rectangle) {
                createRectangle(
                  details,
                  size,
                );
              }

              if (widget.currentTool ==
                  ToolMode.select) {
                selectionManager
                    .selectRectangle(
                  details,
                  size,
                  controller,
                  rectangles,
                );
              }
            });
          },

          onScaleStart:
              controller.onScaleStart,

          onScaleUpdate: (details) {
            final camera =
                controller.camera;

            final renderBox =
                context
                        .findRenderObject()
                    as RenderBox;

            final localPosition =
                renderBox.globalToLocal(
              details.focalPoint,
            );

            final worldX =
                (localPosition.dx -
                        size.width / 2 -
                        camera.pan.dx) /
                    camera.zoom;

            final worldY =
                (localPosition.dy -
                        size.height / 2 -
                        camera.pan.dy) /
                    camera.zoom;

            currentCursorWorld = Offset(
              worldX,
              worldY,
            );

            CursorState
                .worldPosition.value = Offset(
              worldX,
              worldY,
            );

            setState(() {
              if (widget.currentTool ==
                      ToolMode.select &&
                  selectionManager
                          .selectedRectangle !=
                      null &&
                  details.scale == 1.0) {
                selectionManager
                    .moveSelected(
                  details
                      .focalPointDelta,
                  controller
                      .camera.zoom,
                );
              } else {
                controller
                    .onScaleUpdate(
                  details,
                );
              }
            });
          },

          child: CustomPaint(
            painter: ViewportPainter(
              controller,
              rectangles,
              lines,
              lineStartPoint,
              currentCursorWorld,
            ),
            child: Container(),
          ),
        );
      },
    );
  }
}

class ViewportPainter
    extends CustomPainter {
  final CameraController controller;

  final List<RectangleObject>
      rectangles;

  final List<LineObject> lines;

  final Offset? lineStartPoint;

  final Offset currentCursorWorld;

  ViewportPainter(
    this.controller,
    this.rectangles,
    this.lines,
    this.lineStartPoint,
    this.currentCursorWorld,
  );

  @override
  void paint(
    Canvas canvas,
    Size size,
  ) {
    final camera = controller.camera;

    canvas.drawRect(
      Offset.zero & size,
      Paint()
        ..color =
            const Color(0xFF1E1E1E),
    );

    canvas.translate(
      size.width / 2 +
          camera.pan.dx,
      size.height / 2 +
          camera.pan.dy,
    );

    canvas.scale(camera.zoom);

    final gridPaint = Paint()
      ..color =
          const Color(0xFF555555)
      ..strokeWidth =
          1 / camera.zoom;

    const step = 50.0;
    const limit = 10000.0;

    for (double x = -limit;
        x <= limit;
        x += step) {
      canvas.drawLine(
        Offset(x, -limit),
        Offset(x, limit),
        gridPaint,
      );
    }

    for (double y = -limit;
        y <= limit;
        y += step) {
      canvas.drawLine(
        Offset(-limit, y),
        Offset(limit, y),
        gridPaint,
      );
    }

    final linePaint = Paint()
      ..color = Colors.white
      ..strokeWidth =
          2 / camera.zoom;

    final previewPaint = Paint()
      ..color = Colors.green
      ..strokeWidth =
          2 / camera.zoom;

    final pointPaint = Paint()
      ..color = Colors.red;

    for (final line in lines) {
      canvas.drawLine(
        line.start,
        line.end,
        linePaint,
      );

      canvas.drawCircle(
        line.start,
        6 / camera.zoom,
        pointPaint,
      );

      canvas.drawCircle(
        line.end,
        6 / camera.zoom,
        pointPaint,
      );
    }

    if (lineStartPoint != null) {
      canvas.drawLine(
        lineStartPoint!,
        currentCursorWorld,
        previewPaint,
      );

      canvas.drawCircle(
        lineStartPoint!,
        7 / camera.zoom,
        pointPaint,
      );
    }

    for (final rect in rectangles) {
      final rectPaint = Paint()
        ..color = rect.selected
            ? const Color(
                0xFFFFD54F)
            : const Color(
                0xFF2196F3);

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
  bool shouldRepaint(
    covariant CustomPainter
        oldDelegate,
  ) {
    return true;
  }
}