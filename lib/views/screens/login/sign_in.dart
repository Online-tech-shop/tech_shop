import 'package:flutter/material.dart';
import 'package:tech_shop/service/login_http_services.dart';
import 'package:tech_shop/views/screens/home_screen/views/main_screen.dart';
import 'package:tech_shop/views/screens/login/sig_up.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _authHttpservices = LoginHttpServices();
  final _globalKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool check = false;
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
                key: _globalKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _email,
                      decoration: const InputDecoration(
                          hintText: 'Enter email',
                          border: OutlineInputBorder()),
                    ),

                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _password,
                      decoration: const InputDecoration(
                          hintText: 'Enter password',
                          border: OutlineInputBorder()),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    check
                        ? const Text(
                            "Xato ma'lumot kiritildi !",
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 17,
                                fontWeight: FontWeight.w500),
                          )
                        : const SizedBox(),
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () async {
                        if (_globalKey.currentState!.validate()) {
                          var data = await _authHttpservices.login(
                              _email.text, _password.text);
                          if (data["check"]) {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (ctx) => MainScreen()));
                          } else {
                            check = true;
                            setState(() {});
                          }
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

                    TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (ctx) => const SigUp()));
                        },
                        child: const Text("Ro'yhatdan o'tish"))

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
                "yoki",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context, MaterialPageRoute(builder: (ctx) => SigUp()));
                  },
                  child: const Text("Ro'yhatdan o'tish"))
            ],
          )
        ],
      ),
    );
  }
}
