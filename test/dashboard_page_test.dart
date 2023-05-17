import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:posyandu_care_apps/view/dashboard_page.dart';
import 'package:posyandu_care_apps/view/home_page.dart';
import 'package:posyandu_care_apps/view/kaders_page/kader.dart';
import 'package:posyandu_care_apps/view/login/login_page.dart';

void main() {
  testWidgets("Submit button Element", (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: DashboardPage()));
    final keys = find.byKey(const ValueKey('onTap'));
    // await tester.press(keys);
    await tester.tap(keys);
  });
}
