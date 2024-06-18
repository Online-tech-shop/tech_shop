import 'package:flutter/material.dart';

class EditProfileItem extends StatefulWidget {
  const EditProfileItem({super.key});

  @override
  State<EditProfileItem> createState() => _EditProfileItemState();
}

class _EditProfileItemState extends State<EditProfileItem> {
  final _globalKey = GlobalKey<FormState>();
  final _uzumNameController = TextEditingController();
  final _uzumSureNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Profilni tahrirlash',
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.w500),
      ),
      actions: [
        Form(
            key: _globalKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _uzumNameController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Iltimos ismingizni kiriting !';
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
                  controller: _uzumSureNameController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Iltimos Familyangizni kiriting !';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                      hintText: 'Familya', border: OutlineInputBorder()),
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Cansel',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.red,
                              fontWeight: FontWeight.w600),
                        )),
                    InkWell(
                      onTap: () {
                        if (_globalKey.currentState!.validate()) {
                          Navigator.pop(context, {
                            'name': _uzumNameController.text,
                            "surname": _uzumSureNameController.text,
                          });
                        }
                      },
                      child: Container(
                        width: 100,
                        height: 40,
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(20)),
                        child: const Center(
                            child: Text(
                          'Save',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w500),
                        )),
                      ),
                    )
                  ],
                )
              ],
            ))
      ],
    );
  }
}
