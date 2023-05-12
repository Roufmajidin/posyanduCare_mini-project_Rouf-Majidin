import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:posyandu_care_apps/firebase_options.dart';
import 'package:posyandu_care_apps/themes/style.dart';
import 'package:posyandu_care_apps/view/home_page.dart';
import 'package:posyandu_care_apps/view/login/login_page.dart';
import 'package:posyandu_care_apps/view_model/artikel_provider.dart';
import 'package:posyandu_care_apps/view_model/kader_provider.dart';
import 'package:posyandu_care_apps/view_model/kunjungan_provider.dart';
import 'package:posyandu_care_apps/view_model/upt_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'view/dashboard_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SharedPreferences preferences = await SharedPreferences.getInstance();
  var email = preferences.getString('email');
  runApp(MyApp(pefIsLogin: email));
}

class MyApp extends StatelessWidget {
  var pefIsLogin;

  MyApp({super.key, required this.pefIsLogin});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => KunjunganProvider()),
        ChangeNotifierProvider(create: (_) => KaderProvider()),
        ChangeNotifierProvider(create: (_) => UptProvider()),
        ChangeNotifierProvider(create: (_) => ArtikelProvider()),
      ],
      child: MaterialApp(
          title: 'Posyandu Care Apps',
          theme: ThemeData(
              primarySwatch: Colors.blue, canvasColor: AppTheme.bgColor),
          debugShowCheckedModeBanner: false,
          home: const HomePage()),
    );
  }
}
