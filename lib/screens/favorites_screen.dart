import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/recipe_provider.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final favorites = Provider.of<RecipeProvider>(context).favoriteRecipes;

    return Scaffold(
      appBar: AppBar(title: Text('Favorite Recipes')),
      body: ListView.builder(
        itemCount: favorites.length,
        itemBuilder: (ctx, index) {
          return ListTile(
            title: Text(favorites[index].name),
          );
        },
      ),
    );
  }
}
