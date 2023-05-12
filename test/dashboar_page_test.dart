import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:posyandu_care_apps/view/dashboard_page.dart';

void main() {
  testWidgets("Submit button Element", (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: DashboardPage(),
    ));

    expect(find.text("Baca Kesehatan"), findsOneWidget);
  });
}
