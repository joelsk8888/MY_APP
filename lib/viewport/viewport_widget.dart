import 'package:flutter/material.dart';
import '../camera/camera_controller.dart';

class ViewportWidget extends StatefulWidget {
  const ViewportWidget({super.key});

  @override
  State<ViewportWidget> createState() => _ViewportWidgetState();
}

class _ViewportWidgetState extends State<ViewportWidget> {
  final CameraController controller = CameraController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onScaleStart: controller.onScaleStart,
      onScaleUpdate: (details) {
        setState(() {
          controller.onScaleUpdate(details);
        });
      },
      child: CustomPaint(
        painter: ViewportPainter(controller),
        child: Container(),
      ),
    );
  }
}

class ViewportPainter extends CustomPainter {
  final CameraController controller;

  ViewportPainter(this.controller);

  @override
  void paint(Canvas canvas, Size size) {
    final camera = controller.camera;

    // fondo
    canvas.drawRect(
      Offset.zero & size,
      Paint()..color = const Color(0xFF1E1E1E),
    );

    // mover origen al centro
    canvas.translate(
      size.width / 2 + camera.pan.dx,
      size.height / 2 + camera.pan.dy,
    );

    // zoom
    canvas.scale(camera.zoom);

    // GRID
    final gridPaint = Paint()
      ..color = const Color(0xFF666666)
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

    // CUBO CENTRAL
    final cubePaint = Paint()
      ..color = const Color(0xFF2196F3);

    canvas.drawRect(
      Rect.fromCenter(
        center: Offset.zero,
        width: 100,
        height: 100,
      ),
      cubePaint,
    );

    // CRUZ CAD (CENTRO)
    final axisPaint = Paint()
      ..color = const Color(0xFFFFFFFF)
      ..strokeWidth = 2;

    final centerPaint = Paint()
      ..color = const Color(0xFFFF3B3B);

    // eje X
    canvas.drawLine(
      const Offset(-150, 0),
      const Offset(150, 0),
      axisPaint,
    );

    // eje Y
    canvas.drawLine(
      const Offset(0, -150),
      const Offset(0, 150),
      axisPaint,
    );

    // punto central
    canvas.drawCircle(Offset.zero, 5, centerPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}