import 'package:flutter/material.dart';

class Gender extends StatelessWidget {
  const Gender({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Jinsingizni tanlang"),
      actions: [
        // aaaa
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context, 0);
              },
              child: const Text(
                "Erkak",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
              ),
            ),
            const Divider(
              thickness: 1,
              color: Colors.black,
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context, 1);
              },
              child: const Text(
                "Ayol",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
              ),
            ),
          ],
        )
      ],
    );
  }
}
