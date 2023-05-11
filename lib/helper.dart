// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:posyandu_care_apps/view/home_page.dart';

// import 'models/user_models.dart';

// class AuthMethods {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   final FirebaseFirestore firestore = FirebaseFirestore.instance;
//   UserModel? _itemLogin;
//   UserModel? get item => _itemLogin;
//   Future<String> logInUser({
//     required String email,
//     required String password,
//   }) async {
//     String result = 'Some error occurred';
//     print("login");
//     try {
//       if (email.isNotEmpty || password.isNotEmpty) {
//         await _auth.signInWithEmailAndPassword(
//             email: email, password: password);
        
//         final DocumentSnapshot documentSnapshot =
//             await firestore.collection('data_login_user').doc(_auth.).get();
//         _itemLogin = UserModel.fromSnap(documentSnapshot);
//         print(_itemLogin);
//         print("OK");
//       print("object")
//         result = 'success';
//       }
//     } catch (err) {
//       result = err.toString();
//     }
//     return result;
//   }
// }
