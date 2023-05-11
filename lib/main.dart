import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:posyandu_care_apps/firebase_options.dart';
import 'package:posyandu_care_apps/themes/style.dart';
import 'package:posyandu_care_apps/view/home_page.dart';
import 'package:posyandu_care_apps/view/login/login_page.dart';
import 'package:posyandu_care_apps/view_model/artikel_provider.dart';
import 'package:posyandu_care_apps/view_model/kader_provider.dart';
import 'package:posyandu_care_apps/view_model/kunjungan_provider.dart';
import 'package:posyandu_care_apps/view_model/login_provider.dart';
import 'package:posyandu_care_apps/view_model/upt_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'view/dashboard_page.dart';

Future<SharedPreferences> prefIsLogin = SharedPreferences.getInstance();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp(pefIsLogin: prefIsLogin));
}

class MyApp extends StatelessWidget {
  var pefIsLogin;

  MyApp({super.key, required this.pefIsLogin});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => KunjunganProvider()),
        ChangeNotifierProvider(create: (context) => KaderProvider()),
        ChangeNotifierProvider(create: (context) => UptProvider()),
        ChangeNotifierProvider(create: (context) => ArtikelProvider()),
        ChangeNotifierProvider(create: (context) => LoginProvider())
      ],
      child: MaterialApp(
          title: 'Posyandu Care Apps',
          theme: ThemeData(
              primarySwatch: Colors.blue, canvasColor: AppTheme.bgColor),
          debugShowCheckedModeBanner: false,
          home: pefIsLogin == false ? Login() : HomePage()),
    );
  }
}
