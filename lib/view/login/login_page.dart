import 'package:flutter/material.dart';
import 'package:posyandu_care_apps/themes/style.dart';
import 'package:posyandu_care_apps/view/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

final passwordController = TextEditingController();
final usernameController = TextEditingController();
bool isLihat = true;
bool visible = false;
var _formKey = GlobalKey<FormState>();

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppTheme.primaryColor,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              constraints:
                  BoxConstraints(minHeight: MediaQuery.of(context).size.height),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text.rich(TextSpan(
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
                            )
                          ])),
                      const SizedBox(height: 70),
                      TextFormField(
                        style: const TextStyle(color: Colors.white),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              !value.contains('@') ||
                              !value.contains('.')) {
                            return 'Invalid Email (harus ada @)';
                          }
                          return null;
                        },
                        controller: usernameController,
                        decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            fillColor: Colors.white,
                            border: OutlineInputBorder(),
                            labelText: 'Username',
                            labelStyle: TextStyle(color: Colors.white)),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        style: const TextStyle(color: Colors.white),
                        obscureText: isLihat,
                        controller: passwordController,
                        decoration: InputDecoration(
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            border: const OutlineInputBorder(),
                            labelText: 'Password',
                            suffixStyle: const TextStyle(color: Colors.white),
                            suffixIcon: IconButton(
                                icon: Icon(
                                  isLihat
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  setState(() {
                                    isLihat = !isLihat;
                                  });
                                }),
                            labelStyle: TextStyle(color: Colors.white)),
                      ),
                      const SizedBox(height: 50),
                      SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Color.fromARGB(255, 33, 92, 97)),
                              onPressed: () async {
                                SharedPreferences preferences =
                                    await SharedPreferences.getInstance();
                                preferences.setString(
                                    'email', usernameController.text);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomePage()));
                              },
                              child: const Text("Login",
                                  style: TextStyle(color: Colors.white)))),
                      const SizedBox(height: 30),
                      const SizedBox(height: 50),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
