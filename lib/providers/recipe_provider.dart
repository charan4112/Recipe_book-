import 'package:flutter/material.dart';
import '../models/recipe.dart';

class RecipeProvider with ChangeNotifier {
  final List<Recipe> _recipes = [
    Recipe(
      id: '1',
      name: 'Chicken Biriyani',
      image: 'assets/Chicken_Biriyani.JPG',
      ingredients: ['Rice', 'Chicken', 'Spices', 'Yogurt'],
      instructions: 'Cook chicken with spices, add rice, and simmer.',
    ),
    Recipe(
      id: '2',
      name: 'Chicken Curry',
      image: 'assets/Chicken_Curry.JPG',
      ingredients: ['Chicken', 'Tomato', 'Onion', 'Garlic'],
      instructions: 'Sauté onions, add tomatoes and spices, cook chicken.',
    ),
    Recipe(
      id: '3',
      name: 'Fish Starter',
      image: 'assets/Fish_Starter.JPG',
      ingredients: ['Fish', 'Garlic', 'Lemon', 'Pepper'],
      instructions: 'Marinate fish, fry or grill until crispy.',
    ),
    Recipe(
      id: '4',
      name: 'Shrimp Starter',
      image: 'assets/Shrimp_Starter.JPG',
      ingredients: ['Shrimp', 'Garlic', 'Butter', 'Spices'],
      instructions: 'Sauté shrimp in butter with garlic and spices.',
    ),
    Recipe(
      id: '5',
      name: 'Ice Cream',
      image: 'assets/Icecream.JPG',
      ingredients: ['Milk', 'Sugar', 'Vanilla', 'Cream'],
      instructions: 'Mix ingredients, freeze, and enjoy cold.',
    ),
    Recipe(
      id: '6',
      name: 'Milkshake',
      image: 'assets/Milkshake.JPG',
      ingredients: ['Milk', 'Ice Cream', 'Chocolate'],
      instructions: 'Blend ingredients until smooth and creamy.',
    ),
  ];

  List<Recipe> get recipes => [..._recipes];

  List<Recipe> get favoriteRecipes => _recipes.where((recipe) => recipe.isFavorite).toList();

  Recipe findById(String id) => _recipes.firstWhere((recipe) => recipe.id == id);

  void toggleFavoriteStatus(String id) {
    final index = _recipes.indexWhere((recipe) => recipe.id == id);
    if (index != -1) {
      _recipes[index].isFavorite = !_recipes[index].isFavorite;
      notifyListeners();
    }
  }
}
