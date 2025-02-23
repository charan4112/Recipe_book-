import 'package:flutter/material.dart';
import 'details_screen.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Map<String, String>> favoriteRecipes;
  const FavoritesScreen({super.key, required this.favoriteRecipes});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Favorite Recipes")),
      body: favoriteRecipes.isEmpty
          ? const Center(
              child: Text("No favorites added yet!",
                  style: TextStyle(fontSize: 18, color: Colors.grey)))
          : ListView.builder(
              itemCount: favoriteRecipes.length,
              itemBuilder: (ctx, index) {
                return ListTile(
                  title: Text(favoriteRecipes[index]["name"]!),
                  trailing: const Icon(Icons.favorite, color: Colors.red),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DetailsScreen(
                            recipe: favoriteRecipes[index],
                            toggleFavorite: (recipe) {})),
                  ),
                );
              },
            ),
    );
  }
}
