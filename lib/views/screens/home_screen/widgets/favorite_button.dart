import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tech_shop/models/product_item.dart';
import 'package:tech_shop/utils/functions.dart';
import 'package:tech_shop/viewmodels/favourite_view_model.dart';

class FavoriteButton extends StatefulWidget {
  final bool isSelected;
  final Product product;
  final bool isDeleteFromFavScreen;
  final Function(String)? deleteFromFavScreen;

  const FavoriteButton({
    super.key,
    required this.product,
    required this.isSelected,
    required this.isDeleteFromFavScreen,
    this.deleteFromFavScreen,
  });

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  final FavouriteViewModel _favouriteViewModel = FavouriteViewModel();
  bool isTapped = false;

  @override
  void initState() {
    super.initState();
    _favouriteViewModel
        .checkIsFav(id: widget.product.id ?? '')
        .then((value) => setState(() => isTapped = value));
  }

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
          _favouriteViewModel.saveNewFavouriteProduct(id: widget.product.id!);
        } else {
          _favouriteViewModel.deleteNewFavouriteProduct(id: widget.product.id!);
        }
        if (widget.isDeleteFromFavScreen) {
          widget.deleteFromFavScreen!(widget.product.id!);
        } else {
          setState(() {});
        }
      },
      child: Container(
        padding: EdgeInsets.only(
          top: 10,
          right: 10,
          left: widget.isSelected ? 20 : 10,
          bottom: widget.isSelected ? 20 : 10,
          // widget.isSelected ? 0 : 10,
        ),
        child: isTapped
            ? const Icon(
                CupertinoIcons.heart_fill,
                color: Color(0xFF6C03FA),
              )
            : Icon(
                CupertinoIcons.heart,
                color: CustomFunctions.isLight(context)
                    ? Colors.grey
                    : Colors.black,
              ),
      ),
    );
  }
}
