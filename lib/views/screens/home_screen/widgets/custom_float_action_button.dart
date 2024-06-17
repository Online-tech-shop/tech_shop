import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tech_shop/models/product_item.dart';
import 'package:tech_shop/models/sql_model.dart';
import 'package:tech_shop/service/sql_service.dart';
import 'package:tech_shop/viewmodels/sql_view_model.dart';
import 'package:tech_shop/views/screens/home_screen/views/main_screen.dart';

class CustomFloatActionButton extends StatefulWidget {
  final Product product;

  const CustomFloatActionButton({super.key, required this.product});

  @override
  State<CustomFloatActionButton> createState() =>
      _CustomFloatActionButtonState();
}

class _CustomFloatActionButtonState extends State<CustomFloatActionButton> {
  int _orderCount = 1;
  bool _isTapped = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getOrderCount();
  }

  Future<void> getOrderCount() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    _orderCount = sharedPreferences.getInt('order-count') ?? 0;
    setState(() {});
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
        price: widget.product.price.toDouble() +
            (widget.product.price * _orderCount),
        amount: widget.product.leftProduct,
        seller: widget.product.seller,
        brieflyAboutProduct: widget.product.brieflyAboutProduct[0],
        quantity: _orderCount,
      );
      saveViewModel.addSave(save);
    }
  }

  void _incrementOrderCount() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    int orderC = sharedPreferences.getInt('order-count') ?? 1;
    orderC++;
    sharedPreferences.setInt('order-count', orderC);
    _orderCount = orderC;
    setState(() => _orderCount++);
  }

  void _onButtonPressed() {
    setState(() {
      _isTapped = true;
      _orderCount = 1;
    });
  }

  void _navigateToCart(BuildContext context) {
    _addToCart(context);
    Navigator.pushAndRemoveUntil(
      context,
      CupertinoPageRoute(builder: (context) => const MainScreen(n: 2)),
      (route) => false,
    );
  }

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
                const Text(
                  'Narx umumiy',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 10,
                  ),
                ),
                Text(
                  '${widget.product.price * _orderCount} so\'m',
                  style: const TextStyle(
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
                          _isTapped ? 'O\'tish' : 'Savatga',
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
