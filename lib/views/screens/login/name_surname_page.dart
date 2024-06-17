import 'package:flutter/material.dart';
import 'package:tech_shop/service/login_http_services.dart';
import 'package:tech_shop/views/screens/login/widgets/gender.dart';
import 'package:tech_shop/views/screens/profile/profile_screen.dart';

class NameSurnamePage extends StatefulWidget {
  final String localId;
  final String email;
  NameSurnamePage({super.key, required this.localId, required this.email});

  @override
  State<NameSurnamePage> createState() => _NameSurnamePageState();
}

class _NameSurnamePageState extends State<NameSurnamePage> {
  final _authHttpservices = LoginHttpServices();
  final _globalKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _surname = TextEditingController();
  final _age = TextEditingController();
  final _gender = TextEditingController();

  Future<void> _selectDate() async {
    DateTime? _date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(2025));
    if (_date != null) {
      _age.text = _date.toString().split(" ")[0];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Foydalanuvchi ma'lumoti",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          const SizedBox(
            height: 100,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: _globalKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _name,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Iltimos ismingizni kiriting !";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        hintText: 'Ism', border: OutlineInputBorder()),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _surname,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Iltimos familyangizni kiriting !";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        hintText: 'Familya', border: OutlineInputBorder()),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    readOnly: true,
                    controller: _age,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Iltimos yoshingizni kiritng !";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        prefixIcon: IconButton(
                            onPressed: () async {
                              _selectDate();
                            },
                            icon: const Icon(Icons.calendar_month_rounded)),
                        hintText: 'Yosh',
                        border: const OutlineInputBorder()),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    readOnly: true,
                    controller: _gender,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Iltimos jinsingizni kiritng !";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        prefixIcon: IconButton(
                            onPressed: () async {
                              int num;
                              num = await showDialog(
                                  context: context,
                                  builder: (ctx) => const Gender());
                              if (num == 0) {
                                _gender.text = "Erkak";
                              } else {
                                _gender.text = "Ayol";
                              }
                            },
                            icon: const Icon(Icons.calendar_month_rounded)),
                        hintText: 'Jins',
                        border: const OutlineInputBorder()),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  InkWell(
                    onTap: () {
                      if (_globalKey.currentState!.validate()) {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (ctx) => ProfileScreen()));
                        print(
                            "${_name.text}\n${_surname.text}]\n${_age.text}\n${_gender.text}\n${widget.email}\n${widget.localId}");
                      }
                    },
                    child: Container(
                      width: 250,
                      height: 50,
                      decoration: BoxDecoration(
                          color: const Color(0xff7000FF),
                          borderRadius: BorderRadius.circular(5)),
                      child: const Center(
                        child: Text(
                          "Saqlash",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
