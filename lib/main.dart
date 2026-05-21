import 'package:flutter/material.dart';
import 'viewport/viewport_screen.dart';

void main() {
  runApp(const CadApp());
}

class CadApp extends StatelessWidget {
  const CadApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ViewportScreen(),
    );
  }
}