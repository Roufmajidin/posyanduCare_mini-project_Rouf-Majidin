import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:posyandu_care_apps/models/puskesmas_models.dart';
import 'package:posyandu_care_apps/models/upt_models.dart';
import 'package:posyandu_care_apps/models/user_models.dart';
import 'package:posyandu_care_apps/view/home_page.dart';
import 'package:posyandu_care_apps/view_model/upt_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../view/dashboard_page.dart';

enum RequestState { empty, loading, loaded, error }

class LoginProvider extends ChangeNotifier {
  // List<DataUptModels> dataKunjunganfetched = [];

// data Posyandu by id dari item.id puskesmas
  UserModel? _itemLogin;
  UserModel? get itemLogin => _itemLogin;
  RequestState _requestState = RequestState.empty;
  RequestState get requestState => _requestState;

  String _message = '';
  String get message => _message;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  void signIn(context, String email, String password) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      route(context);
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setBool("isLogin", true);
      log("Shared preferensnya adalah : ${pref}");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  void route(context) {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;

    User? user = FirebaseAuth.instance.currentUser;
    UserModel? _itemLogin;

    var kk = FirebaseFirestore.instance
        .collection('data_user_login')
        .doc(user?.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) async {
      if (documentSnapshot.exists) {
        if (documentSnapshot.get('role') == "posyandu") {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ),
          );

          final DocumentSnapshot documentSnapshot = await _firestore
              .collection('data_user_login')
              .doc(user?.uid)
              .get();
          _itemLogin = UserModel.fromSnap(documentSnapshot);

          notifyListeners();
          print('ini yaitu${_itemLogin?.posyanduId}');
          print('ini adalah ${documentSnapshot}');

          print(
              'ini adalah role :${_itemLogin?.role} ${_itemLogin?.posyanduId}');
          notifyListeners();
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => DashboardPage(),
            ),
          );
          notifyListeners();
        }
      } else {
        print('Document does not exist on the database');
        notifyListeners();
      }
      notifyListeners();
    });
    notifyListeners();
  }
}
