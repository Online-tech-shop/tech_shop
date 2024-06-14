// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:tech_shop/models/product_item.dart';
//
// class CustomFloatActionButton extends StatefulWidget {
//   final Product product;
//
//   const CustomFloatActionButton({super.key, required this.product});
//
//   @override
//   State<CustomFloatActionButton> createState() =>
//       _CustomFloatActionButtonState();
// }
//
// class _CustomFloatActionButtonState extends State<CustomFloatActionButton> {
//   bool _isTapped = false;
//   int _orderCount = 0;
//
//   void _onButtonPressed() {
//     setState(() {
//       _isTapped = true;
//       _orderCount++;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 60.h,
//       padding: EdgeInsets.symmetric(horizontal: 15.w),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.3),
//             blurRadius: 35.r,
//           ),
//         ],
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(widget.product.price.toString()),
//           SizedBox(
//             height: 35.h,
//             width: 120.w,
//             child: Stack(
//               clipBehavior: Clip.none,
//               children: [
//                 AnimatedPositioned(
//                   duration: const Duration(seconds: 1),
//                   left: _isTapped ? -60.w : 0,
//                   top: 0,
//                   child: GestureDetector(
//                     onTap: _onButtonPressed,
//                     child: Container(
//                       height: 35.h,
//                       width: _isTapped ? 50.w : 120.w,
//                       decoration: BoxDecoration(
//                           color: const Color(0xFF7733FF),
//                           borderRadius: BorderRadius.circular(10.r)),
//                       child: Center(
//                         child: Text(
//                           _isTapped ? '+$_orderCount' : 'Savatga',
//                           style: const TextStyle(color: Colors.white),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 AnimatedPositioned(
//                   duration: const Duration(seconds: 1),
//                   left: _isTapped ? 0 : 130.w,
//                   top: 0,
//                   child: AnimatedOpacity(
//                     duration: const Duration(seconds: 1),
//                     opacity: _isTapped ? 1.0 : 0.0,
//                     child: GestureDetector(
//                       onTap: () {},
//                       child: Container(
//                         height: 35.h,
//                         width: 120.w,
//                         decoration: BoxDecoration(
//                           border: Border.all(
//                             color: const Color(0xFF7733FF),
//                           ),
//                           borderRadius: BorderRadius.circular(10.r),
//                         ),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             Icon(
//                               Icons.shopping_cart,
//                               color: Color(0xFF7733FF),
//                             ),
//                             Text(
//                               'O\'tish',
//                               style: TextStyle(
//                                 color: Color(0xFF7733FF),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

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

  void _onButtonPressed() {
    setState(() {
      _isTapped = true;
      _orderCount++;
    });
    debugPrint("Order count: $_orderCount");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.h,
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 35.r,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(widget.product.price.toString()),
          SizedBox(
            height: 35.h,
            width: 120.w,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                AnimatedPositioned(
                  duration: const Duration(seconds: 1),
                  left: _isTapped ? -60.w : 0,
                  top: 0,
                  child: GestureDetector(
                    onTap: () {
                      _orderCount++;
                      _isTapped = true;
                      setState(() {});
                    },
                    child: Container(
                      height: 35.h,
                      width: _isTapped ? 50.w : 120.w,
                      decoration: BoxDecoration(
                          color: const Color(0xFF7733FF),
                          borderRadius: BorderRadius.circular(10.r)),
                      child: Center(
                        child: Text(
                          _isTapped ? '+$_orderCount' : 'Savatga',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
                AnimatedPositioned(
                  duration: const Duration(seconds: 1),
                  left: _isTapped ? 0 : 130.w,
                  top: 0,
                  child: AnimatedOpacity(
                    duration: const Duration(seconds: 1),
                    opacity: _isTapped ? 1.0 : 0.0,
                    child: GestureDetector(
                      onTap: () {
                        // You can add the functionality for this button here
                      },
                      child: Container(
                        height: 35.h,
                        width: 120.w,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0xFF7733FF),
                          ),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.shopping_cart,
                              color: Color(0xFF7733FF),
                            ),
                            Text(
                              'O\'tish',
                              style: TextStyle(
                                color: Color(0xFF7733FF),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
