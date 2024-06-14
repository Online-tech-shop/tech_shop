import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:tech_shop/models/product_item.dart';
import 'package:tech_shop/views/screens/home_screen/widgets/custom_float_action_button.dart';

class ViewProductScreen extends StatelessWidget {
  final Product product;

  const ViewProductScreen({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
        ),
        actions: [
          Padding(

            padding: EdgeInsets.only(right: 15.0),
            padding: const EdgeInsets.only(right: 15.0),
            child: Row(
              children: [
                GestureDetector(
                  child: const Icon(
                    CupertinoIcons.heart,
                  ),
                ),

                Gap(15),

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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: CustomFloatActionButton(product: product),
    );
  }
}
