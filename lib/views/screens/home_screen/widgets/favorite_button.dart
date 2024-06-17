import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tech_shop/models/product_item.dart';

class FavoriteButton extends StatefulWidget {
  final bool isSelected;
  final Product product;

  const FavoriteButton({
    super.key,
    required this.product,
    required this.isSelected,
  });

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool isTapped = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        isTapped = !isTapped;
        if (isTapped) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Mahsulot saralanganga qo\'shildi'),
            ),
          );
        }

        setState(() {});
      },
      child: Container(
        padding: EdgeInsets.all(
          widget.isSelected ? 0 : 10,
        ),
        child: isTapped
            ? const Icon(
                CupertinoIcons.heart_fill,
                color: Color(0xFF6C03FA),
              )
            : const Icon(
                CupertinoIcons.heart,
              ),
      ),
    );
  }
}
