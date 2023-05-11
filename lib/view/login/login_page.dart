import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:posyandu_care_apps/models/user_models.dart';
import 'package:posyandu_care_apps/themes/style.dart';
import 'package:posyandu_care_apps/view/dashboard_page.dart';
import 'package:posyandu_care_apps/view/home_page.dart';
import 'package:posyandu_care_apps/view_model/upt_provider.dart';
import 'package:provider/provider.dart';

import '../../helper.dart';
import '../../view_model/login_provider.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

final _pCo = TextEditingController();
final _uCo = TextEditingController();
final _auth = FirebaseAuth.instance;
bool isLihat = true;
bool visible = false;
var _formKey = GlobalKey<FormState>();
UserModel? _itemLogin;
UserModel? get item => _itemLogin;

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryColor,
      body: Consumer<LoginProvider>(
        builder: ((context, loginProvider, child) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Container(
                width: double.infinity,
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text.rich(
                          TextSpan(
                            text: "Welcome,\n",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 32,
                                fontWeight: FontWeight.w700),
                            children: [
                              TextSpan(
                                text: "Posyandu Care",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 70,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                !value.contains('@') ||
                                !value.contains('.')) {
                              return 'Invalid Email';
                            }
                            return null;
                          },
                          controller: _uCo,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Username',
                              labelStyle: TextStyle(color: Colors.white)),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          obscureText: isLihat,
                          controller: _pCo,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Password',
                              suffixIcon: IconButton(
                                  icon: Icon(isLihat
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                                  onPressed: () {
                                    setState(() {
                                      isLihat = !isLihat;
                                    });
                                  }),
                              labelStyle: TextStyle(color: Colors.white)),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Color.fromARGB(255, 33, 92, 97)),
                            onPressed: () async {
                              loginProvider.signIn(
                                  context, _uCo.text, _pCo.text);
                            },
                            child: Text("Login",
                                style: TextStyle(color: Colors.white)),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
