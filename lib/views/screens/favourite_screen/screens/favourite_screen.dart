import 'package:flutter/material.dart';
import 'package:tech_shop/viewmodels/favourite_view_model.dart';

class FavouriteScreen extends StatelessWidget {
  FavouriteScreen({super.key});

  final FavouriteViewModel _favouriteViewModel = FavouriteViewModel();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: kToolbarHeight),
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Istaklarim',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          Expanded(
            child: FutureBuilder(
              future: _favouriteViewModel.saveNewFavouriteProduct('id'),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                } else if (!snapshot.hasData) {
                  return const Center(child: Text('No data found'));
                } else {
                  return const Icon(
                    Icons.access_alarm_outlined,
                    size: 100,
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
