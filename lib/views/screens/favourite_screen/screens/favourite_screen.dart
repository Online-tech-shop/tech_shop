import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:tech_shop/models/product_item.dart';
import 'package:tech_shop/models/review_model.dart';
import 'package:tech_shop/utils/functions.dart';
import 'package:tech_shop/viewmodels/favourite_view_model.dart';
import 'package:tech_shop/viewmodels/home_view_model.dart';
import 'package:tech_shop/viewmodels/review_view_model.dart';
import 'package:tech_shop/views/screens/home_screen/views/main_screen.dart';
import 'package:tech_shop/views/screens/home_screen/widgets/product_card.dart';
import 'package:tech_shop/views/screens/home_screen/widgets/product_widget.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  final FavouriteViewModel _favouriteViewModel = FavouriteViewModel();
  final ReviewViewModel _reviewViewModel = ReviewViewModel();
  final HomeViewModel _homeViewModel = HomeViewModel();

  bool isDataCame = false;
  final List<Product> _favProductList = [];
  List<Review> _reviewList = [];
  int a = 0;

  @override
  void initState() {
    super.initState();
    getFavouriteProducts();
  }

  Future<void> getFavouriteProducts() async {
    try {
      List<String> favListID =
          await _favouriteViewModel.getFavouriteProductId();
      List<Product> productList = await _homeViewModel.onCarouselItemTap();
      Set<String> favSet = favListID.toSet();
      _favProductList.clear();
      for (Product product in productList) {
        if (favSet.contains(product.id)) {
          _favProductList.add(product);
        }
      }

      _reviewList = await _reviewViewModel.getReviews();
    } catch (e) {
      print('Error fetching data: $e');
    } finally {
      isDataCame = true;
      setState(() {});
    }
  }

  void deleteProductFromFav(String id) {
    _favProductList.removeWhere((element) => element.id == id);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CustomFunctions.isLight(context) ? Colors.white : Colors.black,
      child: Padding(
        padding: const EdgeInsets.only(top: kToolbarHeight, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child:  Text(
                'istaklarim',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: CustomFunctions.isLight(context) ? Colors.black : Colors.white,
                ),
              ).tr(),
            ),
            Expanded(
              child: isDataCame
                  ? (_favProductList.isEmpty
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/fav.png',
                                  height: 250,
                                  width: 250,
                                ),
                              ],
                            ),
                            const Text(
                              'sizga_yoqqanini_qoʻshing',
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w700,
                              ),
                            ).tr(),
                            const Text(
                              'bosh_sahifaga_oʻting_va_mahsulotdagi_♡_belgisini_bosing',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 13,
                              ),
                            ).tr(),
                            const Gap(10),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const MainScreen(),
                                  ),
                                  (route) => false,
                                );
                              },
                              child: Container(
                                width: 130,
                                height: 45,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.deepPurple[500],
                                ),
                                child: Center(
                                  child: const Text(
                                    "bosh_sahifaga",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ).tr(),
                                ),
                              ),
                            )
                          ],
                        )
                      : GridView.builder(
                          itemCount: _favProductList.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            mainAxisExtent: 400,
                            crossAxisCount: 2,
                          ),
                          itemBuilder: (BuildContext context, int index) =>
                              ProductCard(
                            key: UniqueKey(),
                            product: _favProductList[index],
                            reviews:
                                _favProductList[index].getReviews(_reviewList),
                            isDeleteFromFavScreen: true,
                            deleteFromFavScreen: deleteProductFromFav,
                          ),
                        ))
                  : const ShimmerProductGrid(),
            ),
          ],
        ),
      ),
    );
  }
}
