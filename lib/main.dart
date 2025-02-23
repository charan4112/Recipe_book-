import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/recipe_provider.dart';
import 'screens/home_screen.dart';
import 'screens/details_screen.dart';
import 'screens/favorites_screen.dart';

void main() {
  runApp(RecipeBookApp());
}

class RecipeBookApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RecipeProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Recipe Book',
        theme: ThemeData(
          primarySwatch: Colors.deepOrange,
          scaffoldBackgroundColor: Colors.white,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => HomeScreen(),
          '/details': (context) => DetailsScreen(),
          '/favorites': (context) => FavoritesScreen(),
        },
      ),
    );
  }
}
