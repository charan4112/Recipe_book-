import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  final Map<String, String> recipe;
  final Function(Map<String, String>) toggleFavorite;
  const DetailsScreen(
      {super.key, required this.recipe, required this.toggleFavorite});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(recipe["name"]!)),
      body: Column(
        children: [
          Hero(
            tag: recipe["name"]!,
            child: Image.asset(recipe["image"]!,
                height: 250, width: double.infinity, fit: BoxFit.cover),
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            icon: Icon(Icons.favorite, color: Colors.red),
            label: const Text("Add to Favorites"),
            onPressed: () => toggleFavorite(recipe),
          ),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text("Recipe details and instructions go here...",
                style: TextStyle(fontSize: 16)),
          ),
        ],
      ),
    );
  }
}
