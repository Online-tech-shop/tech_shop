import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:tech_shop/models/product_item.dart';
import 'package:tech_shop/models/sql_model.dart';
import 'package:tech_shop/service/sql_service.dart';
import 'package:tech_shop/utils/functions.dart';
import 'package:tech_shop/viewmodels/sql_view_model.dart';
import 'package:tech_shop/views/screens/home_screen/views/main_screen.dart';

class CustomFloatActionButton extends StatefulWidget {
  final Product product;

  const CustomFloatActionButton({Key? key, required this.product})
      : super(key: key);

  @override
  _CustomFloatActionButtonState createState() =>
      _CustomFloatActionButtonState();
}

class _CustomFloatActionButtonState extends State<CustomFloatActionButton> {
  int _orderCount = 1;
  bool _isTapped = false;

  @override
  void initState() {
    super.initState();
    _getOrderCount();
  }

  Future<void> _getOrderCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? orderCountJson = prefs.getString('order-count');

    if (orderCountJson == null) return;

    Map<String, dynamic> orderCount = jsonDecode(orderCountJson);
    if (orderCount.containsKey(widget.product.id)) {
      setState(() {
        _orderCount = orderCount[widget.product.id] ?? 1;
        _isTapped = _orderCount > 0;
      });
    }
  }

  Future<void> _incrementOrderCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? orderCountJson = prefs.getString('order-count');

    Map<String, dynamic> orderCount =
        orderCountJson != null ? jsonDecode(orderCountJson) : {};

    setState(() {
      _orderCount = (orderCount[widget.product.id] ?? 0) + 1;
      orderCount[widget.product.id!] = _orderCount;
    });

    await prefs.setString('order-count', jsonEncode(orderCount));
  }

  Future<void> _addToCart(BuildContext context) async {
    final saveViewModel = Provider.of<SaveViewModel>(context, listen: false);
    final dbHelper = DatabaseHelper();

    final existingProducts = await dbHelper.database.then((db) => db.query(
          'saves_product4',
          where: 'title = ?',
          whereArgs: [widget.product.name[0]],
        ));

    if (existingProducts.isNotEmpty) {
      final existingProduct = Save.fromMap(existingProducts.first);
      final updatedSave = existingProduct.copyWith(
        price: existingProduct.price + (widget.product.price * _orderCount),
        quantity: existingProduct.quantity + _orderCount,
      );
      await dbHelper.updateSave(updatedSave);
    } else {
      final save = Save(
        title: widget.product.name[0],
        image: widget.product.images[0],
        price: widget.product.price.toDouble() * _orderCount,
        amount: widget.product.leftProduct,
        seller: widget.product.seller,
        brieflyAboutProduct: widget.product.brieflyAboutProduct[0],
        quantity: _orderCount,
      );
      saveViewModel.addSave(save);
    }
  }

  void _onButtonPressed() {
    setState(() {
      _isTapped = true;
      _orderCount = 1;
    });
  }

  void _navigateToCart(BuildContext context) async {
    await _addToCart(context);
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const MainScreen(n: 2)),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: CustomFunctions.isLight(context)
            ? Colors.white
            : Colors.black.withOpacity(0.8),
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
                const Text(
                  'umumiy_narx',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 10,
                  ),
                ).tr(),
                Text(
                  context.tr(widget.product.price.toString(),
                      namedArgs: {'narx': widget.product.price.toString()}),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: CustomFunctions.isLight(context)
                        ? Colors.black
                        : Colors.white,
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
                    height: 40,
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
                  padding: const EdgeInsets.symmetric(
                    horizontal: 25,
                    vertical: 7,
                  ),
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
                      GestureDetector(
                        onTap:
                            _isTapped ? () => _navigateToCart(context) : null,
                        child: Text(
                          _isTapped
                              ? CustomFunctions.isUzbek(context)
                                  ? 'O\'tish'
                                  : 'Переход'
                              : CustomFunctions.isUzbek(context)
                                  ? 'Savatga'
                                  : 'В корзину',
                          style: TextStyle(
                            color: _isTapped
                                ? const Color(0xFF7733FF)
                                : Colors.white,
                          ),
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
