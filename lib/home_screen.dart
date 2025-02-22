import 'package:flutter/material.dart';
import 'details_screen.dart'; // Import the DetailsScreen

class HomeScreen extends StatelessWidget {
  final List<Map<String, String>> recipes = [
    {
      "title": "Spaghetti Bolognese",
      "ingredients": "Pasta, Ground Beef, Tomato Sauce, Garlic, Onion, Spices",
      "instructions":
          "1. Cook pasta.\n2. Prepare sauce with ground beef and tomatoes.\n3. Mix and serve."
    },
    {
      "title": "Chicken Curry",
      "ingredients":
          "Chicken, Curry Powder, Coconut Milk, Onion, Garlic, Ginger",
      "instructions":
          "1. Sauté onion, garlic, and ginger.\n2. Add chicken and curry powder.\n3. Pour in coconut milk and simmer."
    },
    {
      "title": "Vegetable Stir Fry",
      "ingredients": "Broccoli, Carrot, Bell Pepper, Soy Sauce, Garlic, Tofu",
      "instructions":
          "1. Sauté vegetables with garlic.\n2. Add tofu and soy sauce.\n3. Cook for 5 minutes and serve."
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Recipe Book")),
      body: ListView.builder(
        itemCount: recipes.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(recipes[index]["title"]!),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailsScreen(recipe: recipes[index]),
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
