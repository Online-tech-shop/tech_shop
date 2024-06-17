import 'package:flutter/material.dart';
import 'package:tech_shop/service/login_http_services.dart';
import 'package:tech_shop/views/screens/login/name_surname_page.dart';
import 'package:tech_shop/views/screens/login/sign_in.dart';

class SigUp extends StatefulWidget {
  const SigUp({super.key});

  @override
  State<SigUp> createState() => _SigUpState();
}

class _SigUpState extends State<SigUp> {
  final authHttpServices = LoginHttpServices();
  final _globalKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Ro'yhatdan o'tish",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          const SizedBox(
            height: 60,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
                key: _globalKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _email,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Iltimos emailni kiriting!";
                        }
                      },
                      decoration: const InputDecoration(
                          hintText: 'Email kiriting',
                          border: OutlineInputBorder()),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _password,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Iltimos parol kiriting!";
                        } else if (value.length <= 6) {
                          return "Parol uzunligi 6 dan katta bo'lishi kerak";
                        }
                      },
                      decoration: const InputDecoration(
                          hintText: 'Parol kiriting',
                          border: OutlineInputBorder()),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value != _password.text) {
                          return "Parollar bir xil emas!";
                        }
                      },
                      decoration: const InputDecoration(
                          hintText: 'Parolni qaytadan kiriting',
                          border: OutlineInputBorder()),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    InkWell(
                      onTap: () async {
                        if (_globalKey.currentState!.validate()) {
                          var data = await authHttpServices.sign(
                              _email.text, _password.text);
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (ctx) => NameSurnamePage(
                                      localId: data["localId"],
                                      email: _email.text)));
                        }
                      },
                      child: Container(
                        width: 250,
                        height: 50,
                        decoration: BoxDecoration(
                            color: Color(0xff7000FF),
                            borderRadius: BorderRadius.circular(5)),
                        child: const Center(
                          child: Text(
                            "Ro'yhatdan o'tish",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 17),
                          ),
                        ),
                      ),
                    )
                  ],
                )),
          ),
          const SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Sizda akkaunt bormi?",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context, MaterialPageRoute(builder: (ctx) => SignIn()));
                  },
                  child: const Text(
                    "Kirish",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ))
            ],
          ),
          const SizedBox(
            height: 100,
          ),
          Container(
            width: 300,
            child: const Text(
                textAlign: TextAlign.center,
                "Tizimda ro'yhatdan o'tish orqali foydalanuvchi shartnomasini qabulgan qilgan bo'lasiz"),
          )
        ],
      ),
    );
  }
}
