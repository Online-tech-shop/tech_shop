import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // toolbarHeight: 100,
        flexibleSpace: FlexibleSpaceBar(
          expandedTitleScale: 15,
          title: Text("Mardon"),
        ),
      ),
      body: Container(
        color: Colors.grey,
      ),
    );
  }
}
