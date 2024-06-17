import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tech_shop/models/user_model.dart';

import 'package:tech_shop/service/login_http_services.dart';
import 'package:tech_shop/views/screens/home_screen/views/main_screen.dart';
import 'package:tech_shop/views/screens/login/sig_up.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final LoginHttpServices _loginHttpServices = LoginHttpServices();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Image(image: AssetImage('assets/images/uzum_market_logo.png')),
          const Text(
            "Kirish",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: Color(0xff7000FF)),
          ),
          const SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Enter email',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Email kiriting';
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      email = newValue ?? '';
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Enter password',
                      border: OutlineInputBorder(),

                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Parol kiriting';
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      password = newValue ?? '';
                    },
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "yoki",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (ctx) => const SigUp(),
                            ),
                          );
                        },
                        child: const Text("Ro'yhatdan o'tish"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          TextButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                final Map<String, dynamic> data =
                    await _loginHttpServices.login(
                  email: email,
                  password: password,
                );
                User user = await _loginHttpServices.getUser(data['localId']);
                SharedPreferences sharedPrefs =
                    await SharedPreferences.getInstance();
                sharedPrefs.setString(
                  'user',
                  jsonEncode(
                    user.toJson(),
                  ),
                );
              }
              SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
              sharedPreferences.setBool('isLogged', true);
              Navigator.pushReplacement(
                context,
                CupertinoPageRoute(
                  builder: (context) => const MainScreen(),
                ),
              );
            },
            child: const Text('Tizimga kirish'),
          ),

        ],
      ),
    );
  }
}
