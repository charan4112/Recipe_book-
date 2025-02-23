import 'package:flutter/material.dart';
import '../models/recipe.dart';

class RecipeProvider with ChangeNotifier {
  final List<Recipe> _recipes = [
    Recipe(
      id: '1',
      name: 'Chicken Biriyani',
      imageUrl: 'assets/Chicken_Biriyani.JPG',
      ingredients: ['Rice', 'Chicken', 'Spices', 'Yogurt'],
      instructions: 'Mix ingredients and cook for 45 minutes.',
    ),
    Recipe(
      id: '2',
      name: 'Chicken Curry',
      imageUrl: 'assets/Chicken_Curry.JPG',
      ingredients: ['Chicken', 'Onion', 'Tomato', 'Spices'],
      instructions: 'Cook chicken with onions, tomatoes, and spices.',
    ),
    Recipe(
      id: '3',
      name: 'Fish Starter',
      imageUrl: 'assets/Fish_Starter.JPG',
      ingredients: ['Fish', 'Lemon', 'Garlic', 'Spices'],
      instructions: 'Marinate fish and fry until golden brown.',
    ),
    Recipe(
      id: '4',
      name: 'Ice Cream',
      imageUrl: 'assets/Icecream.JPG',
      ingredients: ['Milk', 'Sugar', 'Flavoring'],
      instructions: 'Freeze mixture for 6 hours.',
    ),
    Recipe(
      id: '5',
      name: 'Shrimp Starter',
      imageUrl: 'assets/Shrimp_Starter.JPG',
      ingredients: ['Shrimp', 'Butter', 'Garlic'],
      instructions: 'Saute shrimp in butter and garlic.',
    ),
    Recipe(
      id: '6',
      name: 'Milkshake',
      imageUrl: 'assets/Milkshake.JPG',
      ingredients: ['Milk', 'Ice Cream', 'Flavoring'],
      instructions: 'Blend until smooth.',
    ),
  ];

  List<Recipe> get recipes => [..._recipes];

  List<Recipe> get favoriteRecipes =>
      _recipes.where((recipe) => recipe.isFavorite).toList();

  Recipe findById(String id) => _recipes.firstWhere((recipe) => recipe.id == id);

  void toggleFavoriteStatus(String id) {
    final recipe = findById(id);
    recipe.isFavorite = !recipe.isFavorite;
    notifyListeners();
  }
}
