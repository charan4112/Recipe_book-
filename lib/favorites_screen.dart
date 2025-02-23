import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/recipe_provider.dart';
import 'details_screen.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final recipeProvider = Provider.of<RecipeProvider>(context);
    final favoriteRecipes = recipeProvider.favoriteRecipes;

    return Scaffold(
      appBar: AppBar(title: const Text("Favorite Recipes")),
      body: favoriteRecipes.isEmpty
          ? const Center(child: Text("No favorite recipes yet!", style: TextStyle(fontSize: 18.0)))
          : ListView.builder(
              itemCount: favoriteRecipes.length,
              itemBuilder: (ctx, index) {
                final recipe = favoriteRecipes[index];
                return ListTile(
                  title: Text(recipe.name),
                  trailing: const Icon(Icons.favorite, color: Colors.red),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DetailsScreen(recipeId: recipe.id)),
                  ),
                );
              },
            ),
    );
  }
}
