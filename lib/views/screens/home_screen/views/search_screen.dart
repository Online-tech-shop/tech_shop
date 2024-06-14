import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    // return const Padding(
    //   padding: EdgeInsets.all(15),
    // );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
      ),
    );

  }
}
