import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:tech_shop/viewmodels/home_view_model.dart';
import 'package:tech_shop/views/screens/home_screen/views/profile_screen.dart';

class Carousel extends StatelessWidget {
  final HomeViewModel viewModel;

  const Carousel({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200.0,
      child: CarouselSlider(
        options: CarouselOptions(
          height: double.infinity,
          autoPlay: true,
          aspectRatio: 16 / 9,
          autoPlayInterval: const Duration(seconds: 10),
          autoPlayAnimationDuration: const Duration(milliseconds: 800),
          autoPlayCurve: Curves.easeIn,
          pauseAutoPlayOnTouch: true,
          scrollDirection: Axis.horizontal,
        ),
        items: viewModel.carouselItems
            .map(
              (item) => GestureDetector(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.only(left: 8, top: 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: Image.asset(
                      item.imagePath,
                      fit: BoxFit.cover,
                      width: 1000,
                    ),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
