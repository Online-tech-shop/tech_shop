import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tech_shop/views/screens/home_screen/views/main_screen.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2)).then(
      (value) => Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const MainScreen(),
      )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: double.infinity,
          height: 40.h,
          color: const Color(0xff7000FF),
        ),
        const Image(image: AssetImage('assets/images/uzum_market_logo.png')),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: const AssetImage(
                'assets/images/uzum_bank_logo.png',
              ),
              width: 90.w,
              height: 90.h,
              fit: BoxFit.cover,
            ),
            Container(
              width: 60.w,
              height: 60.h,
              decoration: BoxDecoration(
                color: Colors.amber,
                image: const DecorationImage(
                    image: AssetImage('assets/images/uzum_nasiya_logo.png'),
                    fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(10.h),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15.h, vertical: 50.w),
              width: 60.w,
              height: 60.h,
              decoration: BoxDecoration(
                color: Colors.amber,
                image: const DecorationImage(
                    image: AssetImage('assets/images/uzum_tezkor_logo.png'),
                    fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ],
        )
      ],
    ));
  }
}
