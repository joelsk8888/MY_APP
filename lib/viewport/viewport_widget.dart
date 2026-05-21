import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

class ViewportWidget extends StatefulWidget {
  const ViewportWidget({super.key});

  @override
  State<ViewportWidget> createState() => _ViewportWidgetState();
}

class _ViewportWidgetState extends State<ViewportWidget> {
  double zoom = 1.0;

  void onPointerSignal(PointerSignalEvent event) {
    if (event is PointerScrollEvent) {
      setState(() {
        zoom += event.scrollDelta.dy * -0.001;

        if (zoom < 0.2) {
          zoom = 0.2;
        }

        if (zoom > 5.0) {
          zoom = 5.0;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerSignal: onPointerSignal,
      child: CustomPaint(
        painter: GridPainter(
          zoom: zoom,
        ),
        size: Size.infinite,
      ),
    );
  }
}

class GridPainter extends CustomPainter {
  final double zoom;

  GridPainter({
    required this.zoom,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey.shade800
      ..strokeWidth = 1;

    final spacing = 40.0 * zoom;

    final centerX = size.width / 2;
    final centerY = size.height / 2;

    // Líneas verticales hacia la derecha
    for (
      double x = centerX;
      x < size.width;
      x += spacing
    ) {
      canvas.drawLine(
        Offset(x, 0),
        Offset(x, size.height),
        paint,
      );
    }

    // Líneas verticales hacia la izquierda
    for (
      double x = centerX;
      x > 0;
      x -= spacing
    ) {
      canvas.drawLine(
        Offset(x, 0),
        Offset(x, size.height),
        paint,
      );
    }

    // Líneas horizontales hacia abajo
    for (
      double y = centerY;
      y < size.height;
      y += spacing
    ) {
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        paint,
      );
    }

    // Líneas horizontales hacia arriba
    for (
      double y = centerY;
      y > 0;
      y -= spacing
    ) {
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        paint,
      );
    }

    // Eje X
    final axisPaintX = Paint()
      ..color = Colors.red
      ..strokeWidth = 2;

    canvas.drawLine(
      Offset(0, centerY),
      Offset(size.width, centerY),
      axisPaintX,
    );

    // Eje Y
    final axisPaintY = Paint()
      ..color = Colors.green
      ..strokeWidth = 2;

    canvas.drawLine(
      Offset(centerX, 0),
      Offset(centerX, size.height),
      axisPaintY,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}