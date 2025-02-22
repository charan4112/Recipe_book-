import 'package:flutter/material.dart';
import 'details_screen.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Map<String, String>> favoriteRecipes;

  const FavoritesScreen({super.key, required this.favoriteRecipes});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Favorite Recipes', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.deepOrangeAccent,
      ),
      body: favoriteRecipes.isEmpty
          ? const Center(
              child: Text(
                "No favorites yet!",
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: favoriteRecipes.length,
              itemBuilder: (context, index) {
                return Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 3,
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(favoriteRecipes[index]["image"]!, width: 60, height: 60, fit: BoxFit.cover),
                    ),
                    title: Text(favoriteRecipes[index]["name"]!, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 18, color: Colors.grey),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailsScreen(recipe: favoriteRecipes[index]),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
