import 'package:flutter/material.dart';
import '../models/recipe.dart';

class RecipeProvider with ChangeNotifier {
  final List<Recipe> _recipes = [
    Recipe(
      id: '1',
      name: 'Chicken Biryani',
      imagePath: 'assets/Chicken_Biriyani.JPG',
      description: 'Delicious and spicy chicken biryani cooked with fragrant rice and spices.',
    ),
    Recipe(
      id: '2',
      name: 'Chicken Curry',
      imagePath: 'assets/Chicken_Curry.JPG',
      description: 'Traditional chicken curry made with flavorful spices.',
    ),
    Recipe(
      id: '3',
      name: 'Fish Starter',
      imagePath: 'assets/Fish_Starter.JPG',
      description: 'Marinate fish and fry until golden brown.',
    ),
    Recipe(
      id: '4',
      name: 'Ice Cream',
      imagePath: 'assets/Icecream.JPG',
      description: 'Refreshing and creamy strawberry ice cream.',
    ),
    Recipe(
      id: '5',
      name: 'Milkshake',
      imagePath: 'assets/Milkshake.JPG',
      description: 'A delightful banana chocolate milkshake topped with whipped cream.',
    ),
    Recipe(
      id: '6',
      name: 'Shrimp Starter',
      imagePath: 'assets/Shrimp_Starter.JPG',
      description: 'Spicy shrimp starter with a blend of aromatic spices.',
    ),
  ];

  List<Recipe> get recipes => [..._recipes];

  List<Recipe> get favoriteRecipes => _recipes.where((recipe) => recipe.isFavorite).toList();

  void toggleFavorite(String id) {
    final recipe = _recipes.firstWhere((recipe) => recipe.id == id);
    recipe.toggleFavorite();
    notifyListeners();
  }
}
