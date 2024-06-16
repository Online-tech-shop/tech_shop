import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tech_shop/utils/routes.dart';
import 'package:tech_shop/viewmodels/sql_view_model.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SaveViewModel(),
      child: MaterialApp(
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(
              color: Colors.black,
              size: 23,
            ),
          ),
        ),
        debugShowCheckedModeBanner: false,
        onGenerateRoute: generateRoute,
      ),
    );
  }
}
