
import 'package:flutter/material.dart';

class QuantityChanger extends StatelessWidget {
  final int quantity;
  final VoidCallback onDecrement;
  final VoidCallback onIncrement;

  const QuantityChanger({
    required this.quantity,
    required this.onDecrement,
    required this.onIncrement,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      height: 35,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(.3),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: onDecrement,
            child: Padding(
              padding: const EdgeInsets.only(left: 3),
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Icon(Icons.remove, size: 15),
                ),
              ),
            ),
          ),
          Text("$quantity"),
          GestureDetector(
            onTap: onIncrement,
            child: Padding(
              padding: const EdgeInsets.only(right: 3),
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Icon(Icons.add, size: 15),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
