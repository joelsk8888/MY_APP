// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:cad_app/main.dart';
import 'package:cad_app/viewport/viewport_widget.dart';

void main() {
  testWidgets('App builds and shows viewport', (WidgetTester tester) async {
    // Build the app and trigger a frame.
    await tester.pumpWidget(const CadApp());

    // Verify that the main viewport widget is present.
    expect(find.byType(ViewportWidget), findsOneWidget);
  });
}
