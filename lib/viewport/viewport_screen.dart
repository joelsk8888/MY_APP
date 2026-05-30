import 'package:flutter/material.dart';

import '../core/cursor_state.dart';
import '../core/tool_mode.dart';
import 'viewport_widget.dart';

class ViewportScreen extends StatefulWidget {
  const ViewportScreen({super.key});

  @override
  State<ViewportScreen> createState() =>
      _ViewportScreenState();
}

class _ViewportScreenState
    extends State<ViewportScreen> {
  ToolMode currentTool = ToolMode.select;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color(0xFF1E1E1E),

      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                ViewportWidget(
                  currentTool: currentTool,
                ),

                Positioned(
                  top: 10,
                  left: 10,
                  child: Container(
                    padding:
                        const EdgeInsets.all(10),
                    color: Colors.black87,

                    child:
                        ValueListenableBuilder<
                            Offset>(
                      valueListenable:
                          CursorState
                              .worldPosition,
                      builder: (
                        context,
                        position,
                        child,
                      ) {
                        return Text(
                          'X: ${position.dx.toStringAsFixed(1)}\n'
                          'Y: ${position.dy.toStringAsFixed(1)}',
                          style:
                              const TextStyle(
                            color:
                                Colors.white,
                            fontSize: 14,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),

          Container(
            height: 70,
            color: const Color(0xFF2A2A2A),
            padding:
                const EdgeInsets.symmetric(
              horizontal: 16,
            ),

            child: Row(
              children: [
                const Text(
                  'Figura:',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),

                const SizedBox(width: 15),

                DropdownButton<ToolMode>(
                  value: currentTool,
                  dropdownColor:
                      const Color(
                    0xFF2A2A2A,
                  ),
                  underline: Container(),

                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),

                  items: const [
                    DropdownMenuItem(
                      value:
                          ToolMode.select,
                      child: Text(
                        'Seleccionar',
                      ),
                    ),

                    DropdownMenuItem(
                      value: ToolMode
                          .rectangle,
                      child: Text(
                        'Cuadrado',
                      ),
                    ),
                    DropdownMenuItem(
                       value: ToolMode.line,
                       child: Text(
                             'Línea',
                    ),
                    ),
                  ],

                  onChanged: (value) {
                    if (value == null) {
                      return;
                    }

                    setState(() {
                      currentTool = value;
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}