import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  final Map<String, String> recipe;

  const DetailsScreen({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(recipe["name"]!)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Image.asset(recipe["image"]!, width: 300, height: 200, fit: BoxFit.cover)),
            const SizedBox(height: 20),
            Text("Ingredients:", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text(recipe["ingredients"]!, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
            Text("Instructions:", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text(recipe["instructions"]!, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
