
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:tech_shop/viewmodels/home_view_model.dart';

class Carousel extends StatelessWidget {
  final HomeViewModel viewModel;

  const Carousel({required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200.0,
      child: CarouselSlider(
        options: CarouselOptions(
          height: double.infinity,
          autoPlay: true,
          enlargeCenterPage: true,
          aspectRatio: 16 / 9,
          autoPlayInterval: const Duration(seconds: 3),
          autoPlayAnimationDuration: const Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
          pauseAutoPlayOnTouch: true,
          scrollDirection: Axis.horizontal,
        ),
        items: viewModel.carouselItems
            .map(
              (item) => GestureDetector(
                onTap: () {},
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Image.asset(item.imagePath,
                      fit: BoxFit.cover, width: 1000),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}