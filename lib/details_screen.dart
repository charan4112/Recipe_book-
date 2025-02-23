import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/recipe_provider.dart';

class DetailsScreen extends StatelessWidget {
  final String recipeId;
  const DetailsScreen({super.key, required this.recipeId});

  @override
  Widget build(BuildContext context) {
    final recipeProvider = Provider.of<RecipeProvider>(context);
    final recipe = recipeProvider.findById(recipeId);

    return Scaffold(
      appBar: AppBar(title: Text(recipe.name)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(recipe.image, height: 200, width: double.infinity, fit: BoxFit.cover),
            const SizedBox(height: 16),
            Text('Ingredients:', style: Theme.of(context).textTheme.headline6),
            const SizedBox(height: 8),
            ...recipe.ingredients.map((ingredient) => ListTile(
                  leading: const Icon(Icons.check),
                  title: Text(ingredient),
                )),
            const SizedBox(height: 16),
            Text('Instructions:', style: Theme.of(context).textTheme.headline6),
            const SizedBox(height: 8),
            Text(recipe.instructions, style: Theme.of(context).textTheme.bodyText1),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              icon: Icon(recipe.isFavorite ? Icons.favorite : Icons.favorite_border),
              label: Text(recipe.isFavorite ? 'Unfavorite' : 'Mark as Favorite'),
              onPressed: () => recipeProvider.toggleFavoriteStatus(recipe.id),
              style: ElevatedButton.styleFrom(
                backgroundColor: recipe.isFavorite ? Colors.red : Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
