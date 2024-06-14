import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tech_shop/models/product_item.dart';

class CustomFloatActionButton extends StatefulWidget {
  final Product product;

  const CustomFloatActionButton({super.key, required this.product});

  @override
  State<CustomFloatActionButton> createState() =>
      _CustomFloatActionButtonState();
}

class _CustomFloatActionButtonState extends State<CustomFloatActionButton> {
  bool _isTapped = false;
  int _orderCount = 0;

  void _onButtonPressed() => setState(() => _isTapped = true);

  void _incrementOrderCount() => setState(() => _orderCount++);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 35,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Narx umumiy',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 10,
                  ),
                ),
                Text(
                  '${widget.product.price} so\'m',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              if (_isTapped)
                GestureDetector(
                  onTap: _incrementOrderCount,
                  child: Container(
                    height: 35,
                    width: 50,
                    decoration: BoxDecoration(
                      color: const Color(0xFF7733FF),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        '+$_orderCount',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              GestureDetector(
                onTap: _onButtonPressed,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  margin: const EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                    color: _isTapped ? Colors.white : const Color(0xFF7733FF),
                    border: Border.all(
                      color: const Color(0xFF7733FF),
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (_isTapped)
                        const Icon(
                          Icons.shopping_cart,
                          color: Color(0xFF7733FF),
                        ),
                      Text(
                        _isTapped ? 'O\'tish' : 'Savatga',
                        style: TextStyle(
                          color: _isTapped
                              ? const Color(0xFF7733FF)
                              : Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
