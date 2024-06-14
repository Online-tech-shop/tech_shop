import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:tech_shop/models/product_item.dart';
import 'package:tech_shop/views/screens/home_screen/widgets/custom_float_action_button.dart';
import 'package:tech_shop/views/screens/home_screen/widgets/custom_info_container.dart';

class ViewProductScreen extends StatelessWidget {
  final Product product;

  const ViewProductScreen({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFEFEF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFEFEFEF),
        leading: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: Row(
              children: [
                GestureDetector(
                  child: const Icon(
                    CupertinoIcons.heart,
                  ),
                ),
                const Gap(15),
                GestureDetector(
                  child: const Icon(
                    CupertinoIcons.share_up,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(
                product.images.length,
                (int index) => Image.network(
                  product.images[index],
                  height: 500 - kToolbarHeight,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                topLeft: Radius.circular(20),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product.name),
                const Gap(10),
                Row(
                  children: [
                    CustomInfoContainer(
                      isSelected: true,
                      product: product,
                    ),
                    CustomInfoContainer(
                      isSelected: false,
                      product: product,
                    ),
                  ],
                ),

              ],
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: CustomFloatActionButton(product: product),
    );
  }
}
