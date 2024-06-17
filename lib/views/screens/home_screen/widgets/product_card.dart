import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:tech_shop/models/product_item.dart';
import 'package:tech_shop/models/review_model.dart';
import 'package:tech_shop/service/sql_service.dart';
import 'package:tech_shop/utils/app_constants.dart';
import 'package:tech_shop/utils/functions.dart';
import 'package:tech_shop/utils/routes.dart';
import 'package:tech_shop/views/screens/home_screen/widgets/favorite_button.dart';
import 'package:tech_shop/viewmodels/sql_view_model.dart';
import 'package:tech_shop/views/screens/save_screen/widgets/flush_bar.dart';
import 'package:tech_shop/models/sql_model.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final List<Review> reviews;
  final bool isDeleteFromFavScreen;
  final Function(String)? deleteFromFavScreen;

  const ProductCard({
    super.key,
    required this.product,
    required this.reviews,
    required this.isDeleteFromFavScreen,
    this.deleteFromFavScreen,
  });

  void _navigateToProduct(BuildContext context) {
    Navigator.pushNamed(
      context,
      RouteName.viewProduct,
      arguments: {
        'product': product,
        'review': product.getReviews(reviews),
      },
    );
  }

  Future<void> _addToCart(BuildContext context) async {
    final saveViewModel = Provider.of<SaveViewModel>(context, listen: false);
    final dbHelper = DatabaseHelper();

    final existingProducts = await dbHelper.database.then(
      (db) => db.query(
        'saves_product4',
        where: 'title = ?',
        whereArgs: [product.name[0]],
      ),
    );

    if (existingProducts.isNotEmpty) {
      final existingProduct = Save.fromMap(existingProducts.first);
      final updatedSave = Save(
        id: existingProduct.id,
        title: existingProduct.title,
        image: existingProduct.image,
        price: existingProduct.price + product.price,
        amount: existingProduct.amount,
        seller: existingProduct.seller,
        brieflyAboutProduct: existingProduct.brieflyAboutProduct,
        quantity: existingProduct.quantity + 1,
      );
      await dbHelper.updateSave(updatedSave);
    } else {
      final save = Save(
        title: product.name[0],
        image: product.images[0],
        price: product.price.toDouble(),
        amount: product.leftProduct,
        seller: product.seller,
        brieflyAboutProduct: product.brieflyAboutProduct[0],
        quantity: 1,
      );
      saveViewModel.addSave(save);
    }

    FlushBars.undo(
      message: "mahsulot_saqlandi".tr(),
      duration: const Duration(seconds: 1),
    ).show(context);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _navigateToProduct(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildProductImage(),
          _buildProductDetails(context),
        ],
      ),
    );
  }

  Widget _buildProductImage() {
    return Container(
      clipBehavior: Clip.hardEdge,
      height: 220,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: NetworkImage(product.images[0]),
          fit: BoxFit.cover,
        ),
      ),
      child: Align(
        alignment: Alignment.topRight,
        child: FavoriteButton(
          product: product,
          isSelected: false,
          isDeleteFromFavScreen: isDeleteFromFavScreen,
          deleteFromFavScreen:
              isDeleteFromFavScreen ? deleteFromFavScreen : null,
        ),
      ),
    );
  }

  Widget _buildProductDetails(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildProductName(context),
          _buildProductRating(context),
          const SizedBox(height: 20),
          _buildProductPriceAndCartButton(context),
        ],
      ),
    );
  }

  Widget _buildProductName(BuildContext context) {
    return Text(
      product.name[AppConstants.appLanguageIndex],
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
          fontSize: 18,
          color:
              CustomFunctions.isLight(context) ? Colors.black : Colors.white),
    );
  }

  Widget _buildProductRating(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.star,
          color: Color(0XffFFB740),
          size: 15,
        ),
        Text(
          ' ${CustomFunctions.countAverageOfReview(reviews).toStringAsFixed(1)} ',
          style: const TextStyle(color: Colors.grey),
        ),
        Text(
          context.tr('sharh', namedArgs: {'review':reviews.length.toString()}),
          style: const TextStyle(color: Colors.grey),
        )
      ],
    );
  }

  Widget _buildProductPriceAndCartButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          context.tr('som', namedArgs: {'narx':product.price.toString()}),
          style: TextStyle(
            color:
                CustomFunctions.isLight(context) ? Colors.black : Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
        InkWell(
          borderRadius: BorderRadius.circular(18),
          splashColor: Colors.grey,
          onTap: () => _addToCart(context),
          child: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: CustomFunctions.isLight(context)
                  ? Colors.white
                  : Colors.grey.withOpacity(0.7),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey),
            ),
            child: SvgPicture.asset(
              'assets/icons/product_icons/cart.svg',
            ),
          ),
        ),
      ],
    );
  }
}
