import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:posyandu_care_apps/firebase_options.dart';
import 'package:posyandu_care_apps/themes/colors.dart';
import 'package:posyandu_care_apps/view/home_page.dart';
import 'package:posyandu_care_apps/view_model/kunjungan_provider.dart';
import 'package:provider/provider.dart';

import 'view/dashboard_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => KunjunganProvider())
      ],
      child: MaterialApp(
          title: 'Posyandu Care Apps',
          theme: ThemeData(
              primarySwatch: Colors.blue, canvasColor: AppTheme.bgColor),
          debugShowCheckedModeBanner: false,
          home: const DashboardPage()),
    );
  }
}
