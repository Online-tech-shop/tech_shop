import 'package:flutter/material.dart';

class NoLoginProfile extends StatefulWidget {
  const NoLoginProfile({super.key});

  @override
  State<NoLoginProfile> createState() => _NoLoginProfileState();
}

class _NoLoginProfileState extends State<NoLoginProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Center(
            child: Text(
              "Shaxsiy kabinet",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          InkWell(
            child: Container(
              width: 80,
              height: 80,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/uzum_logo.png"))),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Container(
            width: 350,
            child: const Text(
              textAlign: TextAlign.center,
              "Savat va akkauntingizdagi istaklarni ro'yhatini ko'rish ochish uchun tizimga kiring",
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Container(
            height: 50,
            color: Colors.white,
            child: const Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: CircleAvatar(
                    backgroundImage: AssetImage('assets/images/uzbekistan.png'),
                    radius: 20,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Ilova tili",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.black26,
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      )),
    );
  }
}
