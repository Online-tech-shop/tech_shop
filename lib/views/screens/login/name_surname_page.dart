import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tech_shop/views/screens/home_screen/views/main_screen.dart';
import 'package:tech_shop/views/screens/login/widgets/gender.dart';

class NameSurnamePage extends StatefulWidget {
  final String localId;
  final String email;

  const NameSurnamePage({
    Key? key,
    required this.localId,
    required this.email,
  }) : super(key: key);

  @override
  State<NameSurnamePage> createState() => _NameSurnamePageState();
}

class _NameSurnamePageState extends State<NameSurnamePage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _surnameController = TextEditingController();
  final _ageController = TextEditingController();
  final _genderController = TextEditingController();

  Future<void> _selectDate() async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2025),
    );
    if (date != null) {
      _ageController.text = date.toString().split(" ")[0];
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _surnameController.dispose();
    _ageController.dispose();
    _genderController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Foydalanuvchi ma'lumoti",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 100),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    _buildTextFormField(
                      controller: _nameController,
                      labelText: 'Ism',
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Iltimos ismingizni kiriting!";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    _buildTextFormField(
                      controller: _surnameController,
                      labelText: 'Familya',
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Iltimos familyangizni kiriting!";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    _buildDatePickerFormField(
                      controller: _ageController,
                      labelText: 'Yosh',
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Iltimos yoshingizni kiritng!";
                        }
                        return null;
                      },
                      onTap: _selectDate,
                    ),
                    const SizedBox(height: 20),
                    _buildGenderPickerFormField(
                      controller: _genderController,
                      labelText: 'Jins',
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Iltimos jinsingizni kiritng!";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 40),
                    _buildSaveButton(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextFormField _buildTextFormField({
    required TextEditingController controller,
    required String labelText,
    required String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      validator: validator,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: labelText,
        border: const OutlineInputBorder(),
      ),
    );
  }

  TextFormField _buildDatePickerFormField({
    required TextEditingController controller,
    required String labelText,
    required String? Function(String?)? validator,
    required VoidCallback onTap,
  }) {
    return TextFormField(
      readOnly: true,
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        prefixIcon: IconButton(
          onPressed: onTap,
          icon: const Icon(Icons.calendar_month_rounded),
        ),
        hintText: labelText,
        border: const OutlineInputBorder(),
      ),
    );
  }

  TextFormField _buildGenderPickerFormField({
    required TextEditingController controller,
    required String labelText,
    required String? Function(String?)? validator,
  }) {
    return TextFormField(
      readOnly: true,
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        prefixIcon: IconButton(
          onPressed: () async {
            int? num = await showDialog<int>(
              context: context,
              builder: (ctx) => const Gender(),
            );
            if (num == 0) {
              controller.text = "Erkak";
            } else {
              controller.text = "Ayol";
            }
          },
          icon: const Icon(Icons.person),
        ),
        hintText: labelText,
        border: const OutlineInputBorder(),
      ),
    );
  }

  InkWell _buildSaveButton() {
    return InkWell(
      onTap: () async {
        if (_formKey.currentState!.validate()) {
          SharedPreferences sharedPreferences =
              await SharedPreferences.getInstance();
          sharedPreferences.setString("name", _nameController.text);
          sharedPreferences.setString("surname", _surnameController.text);
          sharedPreferences.setString("email", widget.email);
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const MainScreen()),
            (route) => false,
          );
        }
      },
      child: Container(
        width: 250,
        height: 50,
        decoration: BoxDecoration(
          color: const Color(0xff7000FF),
          borderRadius: BorderRadius.circular(5),
        ),
        child: const Center(
          child: Text(
            "Saqlash",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
