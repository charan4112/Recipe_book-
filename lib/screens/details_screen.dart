import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/recipe_provider.dart';

class DetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final recipeId = ModalRoute.of(context)!.settings.arguments as String;
    final recipe = Provider.of<RecipeProvider>(context).findById(recipeId);

    return Scaffold(
      appBar: AppBar(title: Text(recipe.name)),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.asset(recipe.imageUrl),
            Text(recipe.instructions, style: TextStyle(fontSize: 16.0)),
            IconButton(
              icon: Icon(recipe.isFavorite ? Icons.favorite : Icons.favorite_border),
              onPressed: () {
                Provider.of<RecipeProvider>(context, listen: false).toggleFavoriteStatus(recipe.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
