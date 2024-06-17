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

  const ProductCard({
    super.key,
    required this.product,
    required this.reviews,
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
      message: "Mahsulot Saqlandi",
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
          _buildProductName(),
          _buildProductRating(),
          const SizedBox(height: 20),
          _buildProductPriceAndCartButton(context),
        ],
      ),
    );
  }

  Widget _buildProductName() {
    return Text(
      product.name[AppConstants.appLanguageIndex],
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(fontSize: 18),
    );
  }

  Widget _buildProductRating() {
    return Row(
      children: [
        const Icon(
          Icons.star,
          color: Color(0XffFFB740),
          size: 15,
        ),
        Text(
          ' ${CustomFunctions.countAverageOfReview(reviews).toStringAsFixed(2)} ',
          style: const TextStyle(color: Colors.grey),
        ),
        Text(
          "(${reviews.length}ta sharhlar)",
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
          '${product.price} so\'m',
          style: const TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
        InkWell(
          radius: 10,
          onTap: () => _addToCart(context),
          child: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
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
