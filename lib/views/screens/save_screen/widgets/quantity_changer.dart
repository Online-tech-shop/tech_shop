import 'package:flutter/material.dart';
import 'package:tech_shop/utils/functions.dart';
import 'package:tech_shop/views/screens/save_screen/widgets/flush_bar.dart';

class QuantityChanger extends StatelessWidget {
  final int quantity;
  final VoidCallback onDismissed;
  final VoidCallback onDecrement;
  final VoidCallback onIncrement;

  const QuantityChanger({
    required this.quantity,
    required this.onDecrement,
    required this.onIncrement,
    required this.onDismissed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      height: 35,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              if (quantity > 1) {
                onDecrement();
              } else {
                onDecrement();
                onDismissed();
                FlushBars.undo(
                  message: "Mahsulot o'chirildi",
                  duration: const Duration(seconds: 2),
                ).show(context);
              }
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 3),
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: CustomFunctions.isLight(context)
                      ? Colors.white
                      : Colors.black,
                  borderRadius: BorderRadius.circular(10),
                ),
                child:  Center(
                  child: Icon(
                    Icons.remove,
                    size: 15,
                    color: CustomFunctions.isLight(context) ?Colors.black : Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Text(
            "$quantity",
            style: const TextStyle(fontSize: 16),
          ),
          GestureDetector(
            onTap: onIncrement,
            child: Padding(
              padding: const EdgeInsets.only(right: 3),
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: CustomFunctions.isLight(context)
                      ? Colors.white
                      : Colors.black,
                  borderRadius: BorderRadius.circular(10),
                ),
                child:  Center(
                  child: Icon(
                    Icons.add,
                    size: 15,
                    color: CustomFunctions.isLight(context) ?Colors.black : Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
