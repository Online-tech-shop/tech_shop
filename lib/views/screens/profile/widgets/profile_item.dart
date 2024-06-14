// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class ProfileItem extends StatefulWidget {
  final Icon ikon;
  String name;
  ProfileItem({
    Key? key,
    required this.ikon,
    required this.name,
  }) : super(key: key);

  @override
  State<ProfileItem> createState() => _ProfileItemState();
}

class _ProfileItemState extends State<ProfileItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: Row(
        children: [
          Container(
            width: 70,
            height: 70,
            child: Center(
              child: widget.ikon,
            ),
          ),
          Expanded(
              child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            height: double.infinity,
            decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.black26))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.name,
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.black26,
                )
              ],
            ),
          ))
        ],
      ),
    );
  }
}
