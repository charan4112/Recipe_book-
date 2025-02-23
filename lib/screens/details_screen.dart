import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/recipe_provider.dart';

class DetailsScreen extends StatelessWidget {
  static const routeName = '/details';

  @override
  Widget build(BuildContext context) {
    final recipeId = ModalRoute.of(context)!.settings.arguments as String;
    final recipeProvider = Provider.of<RecipeProvider>(context);
    final recipe = recipeProvider.recipes.firstWhere((recipe) => recipe.id == recipeId);

    return Scaffold(
      appBar: AppBar(title: Text(recipe.name)),
      body: Column(
        children: [
          Image.asset(recipe.imagePath, fit: BoxFit.cover),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(recipe.description, style: TextStyle(fontSize: 18)),
          ),
          IconButton(
            icon: Icon(recipe.isFavorite ? Icons.favorite : Icons.favorite_border, color: Colors.red),
            onPressed: () {
              recipeProvider.toggleFavorite(recipe.id);
            },
          ),
        ],
      ),
    );
  }
}
