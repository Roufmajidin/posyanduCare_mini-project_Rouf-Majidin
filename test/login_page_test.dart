import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:posyandu_care_apps/view/login/login_page.dart';

void main() {
  group("TEST SEMUA ELEMENT DI LOGIN PAGE", () {
    testWidgets("Form Input Element", (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: Login(),
      ));
      Finder inputForm = find.byType(TextFormField);

      log("test input form");
      expect(inputForm, findsNWidgets(2));
    });

    testWidgets("Submit button Element", (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: Login(),
      ));

      expect(find.text("Login"), findsOneWidget);
    });
  });
}
